using FinalProject_GameForum.Models;
using Microsoft.AspNetCore.Mvc;

namespace FinalProject_GameForum.Controllers
{
    public class CustomerServiceIssuesController : Controller
    {
        private readonly GameForumContext _context;

        public CustomerServiceIssuesController(GameForumContext context)
        {
            _context = context;
        }

        
        public IActionResult Index()
        {
            return View();
        }

        [HttpPost]
        public async Task<IActionResult> Submit(IFormFile? image, string userId, string questionType, string questionDescription)
        {
            byte[]? imageData = null;

            if (image != null && image.Length > 0)
            {
                using (MemoryStream memoryStream = new MemoryStream())
                {
                    await image.CopyToAsync(memoryStream);
                    imageData = memoryStream.ToArray();
                }
            }

            CustomerProblem problem = new CustomerProblem
            {
                UserId = userId,
                QuestionType = questionType,
                QuestionDescription = questionDescription,
                Image = imageData
            };

            _context.CustomerProblems.Add(problem);
            await _context.SaveChangesAsync();

            return RedirectToAction("Index", "Home");
        }
    }
}
