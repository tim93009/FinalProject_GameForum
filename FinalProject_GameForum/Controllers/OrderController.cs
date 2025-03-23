using Microsoft.AspNetCore.Mvc;
using Microsoft.EntityFrameworkCore;
using FinalProject_GameForum.Models;
using System.Linq;
using System.Threading.Tasks;
using System.Security.Claims; 

namespace FinalProject_GameForum.Controllers
{
    public class OrderController : Controller
    {
        private readonly GameForumContext _context;

        public OrderController(GameForumContext context)
        {
            _context = context;
        }

        // 訂單列表
        public async Task<IActionResult> Index()
        {
            // 取得目前登入使用者的ID
            string currentUserId = HttpContext.User.FindFirst("UserID")?.Value;
            if (string.IsNullOrEmpty(currentUserId))
            {
                // 若未登入則導向登入頁面
                return RedirectToAction("Login", "Login");
            }

            var orders = await _context.Orders
                .Include(o => o.Product)
                .ThenInclude(p => p.ProductCategory)
                .Include(o => o.OrderStatus)
                .Where(o => o.UserId == currentUserId) // 根據登入用戶篩選訂單
                .ToListAsync();
            return View(orders);
        }

        // 訂單詳情
        public async Task<IActionResult> Details(int id)
        {
            // 取得目前登入使用者的ID
            string currentUserId = HttpContext.User.FindFirst("UserID")?.Value;
            if (string.IsNullOrEmpty(currentUserId))
            {
                return RedirectToAction("Login", "Login");
            }

            var order = await _context.Orders
                .Include(o => o.Product)
                .ThenInclude(p => p.ProductCategory)
                .Include(o => o.OrderStatus)
                .FirstOrDefaultAsync(o => o.OrderId == id && o.UserId == currentUserId); // 驗證訂單是否屬於目前用戶

            if (order == null)
            {
                return NotFound();
            }

            return View(order);
        }

        // 訂單編號查詢
        public async Task<IActionResult> Search(string? searchOrderId)
        {
            // 取得目前登入使用者的ID
            string currentUserId = HttpContext.User.FindFirst("UserID")?.Value;
            if (string.IsNullOrEmpty(currentUserId))
            {
                return RedirectToAction("Login", "Login");
            }

            var orders = _context.Orders
                .Include(o => o.Product)
                .ThenInclude(p => p.ProductCategory)
                .Include(o => o.OrderStatus)
                .Where(o => o.UserId == currentUserId) // 只查詢目前用戶的訂單
                .AsQueryable();

            if (!string.IsNullOrEmpty(searchOrderId))
            {
                orders = orders.Where(o => o.OrderId.ToString().Contains(searchOrderId));
            }

            return View("Index", await orders.ToListAsync());
        }
    }
}
