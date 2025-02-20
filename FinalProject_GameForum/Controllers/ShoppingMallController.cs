using Microsoft.AspNetCore.Mvc;

namespace iSpan_MSIT62_Final_Project.Controllers
{
    //https://localhost:7086/ShoppingMall
    public class ShoppingMallController : Controller
    {
        public IActionResult Index()
        {
            return View();
        }
    }
}
