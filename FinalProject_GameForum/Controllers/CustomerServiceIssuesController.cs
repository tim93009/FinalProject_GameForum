using FinalProject_GameForum.Models;
using Microsoft.AspNetCore.Mvc;

namespace FinalProject_GameForum.Controllers
{
    public class CustomerServiceIssuesController : Controller
    {
        private readonly MyDbContext _context;

        public CustomerServiceIssuesController(MyDbContext context)
        {
            _context = context;
        }

        
        public IActionResult Index()
        {
            return View();
        }

        [HttpPost]
        public async Task<IActionResult> Submit(IFormFile? image, int user_id, string questionType, string questionDescription)
        {
            byte[]? imageData = null;

            if (image != null && image.Length > 0)
            {
                using (var memoryStream = new MemoryStream())
                {
                    await image.CopyToAsync(memoryStream);
                    imageData = memoryStream.ToArray();
                }
            }

            var problem = new CustomerProblem
            {
                User_id = user_id,
                QuestionType = questionType,
                QuestionDescription = questionDescription,
                Image = imageData
            };

            _context.CustomerProblems.Add(problem);
            await _context.SaveChangesAsync();

            return RedirectToAction("Index");
        }
    }
}
