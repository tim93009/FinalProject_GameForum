using Microsoft.AspNetCore.Mvc;

namespace FinalProject_GameForum.Controllers
{
    using Microsoft.AspNetCore.Mvc;
    using FinalProject_GameForum.Models;

    public class OrderController : Controller
    {
        public IActionResult Index()
        {
            var model = new OrderView
            {
                VirtualCompleted = 0,
                PendingOrders = 0,
                PendingPayment = 0,
                TransactionsCompleted = 0,
                PhysicalPendingShipment = 0,
                PhysicalShipping = 0,
                PhysicalAwaitingPickup = 0,
                PhysicalTransactionsCompleted = 0
            };

            return View(model);
        }
    }

}
