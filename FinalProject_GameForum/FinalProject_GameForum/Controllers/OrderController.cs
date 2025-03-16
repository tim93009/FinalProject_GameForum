using Microsoft.AspNetCore.Mvc;
using FinalProject_GameForum.Models;
using System.Linq;

public class OrderController : Controller
{
    //private readonly GameForumContext _context; // 假設你有 DbContext

    //public OrderController(GameForumContext context)
    //{
    //    _context = context;
    //}

    //public IActionResult Index()
    //{
    //    string currentUserId = "測試用戶"; // 這裡應該改成從登入狀態獲取 UserId

    //    // 從資料庫查詢該用戶的所有訂單
    //    var orders = _context.Orders
    //        .Where(o => o.UserId == currentUserId)
    //        .Select(o => new Order
    //        {
    //            OrderId = o.OrderId,
    //            ProductId = o.ProductId,
    //            Quantity = o.Quantity,
    //            OrderDate = o.OrderDate,
    //            OrderStatus = o.OrderStatus,
    //            Product = o.Product // 包含商品資訊
    //        })
    //        .ToList();

    //    var model = new OrderView
    //    {
    //        Orders = orders,
    //        VirtualCompleted = orders.Count(o => o.OrderStatusId == 4), // 例: 狀態 4 代表完成
    //        PendingOrders = orders.Count(o => o.OrderStatusId == 1),
    //        PendingPayment = orders.Count(o => o.OrderStatusId == 2),
    //        TransactionsCompleted = orders.Count(o => o.OrderStatusId == 3),
    //        PhysicalPendingShipment = orders.Count(o => o.OrderStatusId == 5),
    //        PhysicalShipping = orders.Count(o => o.OrderStatusId == 6),
    //        PhysicalAwaitingPickup = orders.Count(o => o.OrderStatusId == 7),
    //        PhysicalTransactionsCompleted = orders.Count(o => o.OrderStatusId == 8)
    //    };

    //    return View(model);

    //上面Code需SQL


    public IActionResult Index()
    {
        // 假資料
        var mockOrders = new List<Order>
            {
                new Order
                {
                    OrderId = 1,
                    UserId = "testUser",
                    Product = new Product
                    {
                        ProductId = 1,
                        ProductName = "測試商品 A",
                        MainImageUrl = "https://via.placeholder.com/150",
                        Price = 123
                    },
                    Quantity = 2,
                    OrderDate = DateTime.Now.AddDays(-2),
                    OrderStatus = new OrderStatus { Status = "待出貨" }
                },
                new Order
                {
                    OrderId = 2,
                    UserId = "testUser",
                    Product = new Product
                    {
                        ProductId = 2,
                        ProductName = "測試商品 B",
                        MainImageUrl = "https://via.placeholder.com/150",
                        Price = 321
                    },
                    Quantity = 1,
                    OrderDate = DateTime.Now.AddDays(-5),
                    OrderStatus = new OrderStatus { Status = "已完成" }
                }
                };

        // 建立 ViewModel
        var model = new OrderView
        {
            Orders = mockOrders, // 新增訂單列表
            VirtualCompleted = 1,
            PendingOrders = 1,
            PendingPayment = 0,
            TransactionsCompleted = 1,
            PhysicalPendingShipment = 1,
            PhysicalShipping = 0,
            PhysicalAwaitingPickup = 0,
            PhysicalTransactionsCompleted = 1
        };

        return View(model);
    }
}
