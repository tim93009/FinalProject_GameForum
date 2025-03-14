using FinalProject_GameForum.Models;
using Microsoft.EntityFrameworkCore;

var builder = WebApplication.CreateBuilder(args);

// Add services to the container.
builder.Services.AddControllersWithViews();
////Session �n�J
//builder.Services.AddSession(options =>
//{
//    //�n�J�Ĵ�1��
//    options.IdleTimeout = TimeSpan.FromDays(1);
//    options.Cookie.HttpOnly = true;
//    options.Cookie.IsEssential = true;
//});

// �q appsettings.json Ū���s�u�r��ó]�w DbContext
builder.Services.AddDbContext<GameForumContext>(
        options => options.UseSqlServer(builder.Configuration.GetConnectionString("DefaultConnection")));
builder.Services.AddControllersWithViews();


var app = builder.Build();

// Configure the HTTP request pipeline.
if (!app.Environment.IsDevelopment())
{
    app.UseExceptionHandler("/Home/Error");
    // The default HSTS value is 30 days. You may want to change this for production scenarios, see https://aka.ms/aspnetcore-hsts.
    app.UseHsts();
}

app.UseHttpsRedirection();
app.UseStaticFiles();

//app.UseSession();
app.UseRouting();

app.UseAuthorization();

app.MapControllerRoute(
    name: "default",
    pattern: "{controller=Home}/{action=Index}/{id?}");

app.Run();
