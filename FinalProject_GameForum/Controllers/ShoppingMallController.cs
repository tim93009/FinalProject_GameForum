using Microsoft.AspNetCore.Mvc;

namespace iSpan_MSIT62_Final_Project.Controllers
{    
    public class ShoppingMallController : Controller
    {
        public IActionResult Index()
        {
            return View();
        }
    }
}
