using FinalProject_GameForum;
using FinalProject_GameForum.Models;
using Microsoft.AspNetCore.Authentication.Cookies;
using Microsoft.EntityFrameworkCore;

var builder = WebApplication.CreateBuilder(args);

// Add services to the container.
builder.Services.AddControllersWithViews();


// 從 appsettings.json 讀取連線字串並設定 DbContext
builder.Services.AddDbContext<GameForumContext>(
        options => options.UseSqlServer(builder.Configuration.GetConnectionString("DefaultConnection")));

builder.Services.AddHttpContextAccessor();
builder.Services.AddScoped<UserInfoService>();

builder.Services.AddAuthentication(CookieAuthenticationDefaults.AuthenticationScheme).AddCookie(option =>
{
    //未登入時自動移轉到此網址
    option.LoginPath = new PathString("/Home/Index");
}).AddFacebook(options =>
{
    options.AppId = "653772980397141";
    options.AppSecret = "1900b877b5c6f17fe9dc51505daf20b1";
    options.AccessDeniedPath = "/AccessDeniedPathInfo";
}).AddGoogle(options =>
{
    options.ClientId = "365818433505-0ha2qhf5tuh9brrir7tot8a4qb6otrgr.apps.googleusercontent.com";
    options.ClientSecret = "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";

});



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


app.UseRouting();

app.UseCookiePolicy();
app.UseAuthentication();
app.UseAuthorization();


app.MapControllerRoute(
    name: "default",
    pattern: "{controller=Home}/{action=Index}/{id?}");

app.Run();
