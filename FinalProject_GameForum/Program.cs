using FinalProject_GameForum;
using FinalProject_GameForum.Models;
using FinalProject_GameForum.Hubs;
using Microsoft.AspNetCore.Authentication.Cookies;
using Microsoft.EntityFrameworkCore;
using FinalProject_GameForum.Filters;

var builder = WebApplication.CreateBuilder(args);

// Add services to the container.
builder.Services.AddControllersWithViews();

// 聊天室 SignalR
builder.Services.AddSignalR();

// 註冊 LoginCheckFilter
builder.Services.AddScoped<LoginCheckFilter>();


// 從 appsettings.json 讀取連線字串並設定 DbContext
builder.Services.AddDbContext<GameForumContext>(
        options => options.UseSqlServer(builder.Configuration.GetConnectionString("DefaultConnection")));

builder.Services.AddHttpContextAccessor();


builder.Services.AddAuthentication(CookieAuthenticationDefaults.AuthenticationScheme).AddCookie(option =>
{
    //未登入時自動移轉到此網址
    option.LoginPath = new PathString("/Home/Index");
}).AddFacebook(options =>
{
    options.ClientId = "610374368493483";
    options.ClientSecret = "3e8cea269a91bf2175f6509fb0351b65";
    options.AccessDeniedPath = "/Login/Login";

}).AddGoogle(options =>
{
    options.ClientId = "365818433505-0ha2qhf5tuh9brrir7tot8a4qb6otrgr.apps.googleusercontent.com";
    options.ClientSecret = "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";

}).AddMicrosoftAccount(options =>
{
    options.ClientId = "43fc25be-380e-4015-96ea-79eecdd501f5";
    options.ClientSecret = "KTc8Q~ViN4ap6HjHvrC._BVwC7XTAJW-20.xFbxa";
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

app.MapControllerRoute(
    name: "Article",
    pattern: "{controller=Aritcle}/{action=Index}/{discussion?}/{Article?}");

// 註冊 SignalR Hub 路由
app.MapHub<ChatHub>("/Discussion/chatHub");

app.Run();
