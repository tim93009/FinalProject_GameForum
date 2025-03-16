using System.Collections.Generic;

namespace FinalProject_GameForum.Models
{
    public class OrderView
    {
        public int VirtualCompleted { get; set; }
        public int PendingOrders { get; set; }
        public int PendingPayment { get; set; }
        public int TransactionsCompleted { get; set; }

        public int PhysicalPendingShipment { get; set; }
        public int PhysicalShipping { get; set; }
        public int PhysicalAwaitingPickup { get; set; }
        public int PhysicalTransactionsCompleted { get; set; }

        public List<Order> Orders { get; set; } = new List<Order>();
    }

}
