using Microsoft.AspNetCore.Mvc;
using Microsoft.EntityFrameworkCore;
using FinalProject_GameForum.Models;
using System.Linq;
using System.Threading.Tasks;

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
            var orders = await _context.Orders
                .Include(o => o.Product)
                .ThenInclude(p => p.ProductCategory)
                .Include(o => o.OrderStatus)
                .ToListAsync();
            return View(orders);
        }

        // 訂單詳情
        public async Task<IActionResult> Details(int id)
        {
            var order = await _context.Orders
                .Include(o => o.Product)
                .ThenInclude(p => p.ProductCategory)
                .Include(o => o.OrderStatus)
                .FirstOrDefaultAsync(o => o.OrderId == id);

            if (order == null)
            {
                return NotFound();
            }

            return View(order);
        }


        // 訂單編號查詢
        public async Task<IActionResult> Search(string? searchOrderId)
        {
            var orders = _context.Orders
                .Include(o => o.Product)
                .ThenInclude(p => p.ProductCategory)
                .Include(o => o.OrderStatus)
                .AsQueryable(); // 先建立 IQueryable

            if (!string.IsNullOrEmpty(searchOrderId))
            {
                orders = orders.Where(o => o.OrderId.ToString().Contains(searchOrderId));
            }

            return View("Index", await orders.ToListAsync()); // 返回 Index 視圖並傳遞結果
        }



    }
}
