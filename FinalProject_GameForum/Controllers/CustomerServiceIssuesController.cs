using FinalProject_GameForum.Models;
using System.Text.Json;
using Microsoft.AspNetCore.Mvc;

namespace FinalProject_GameForum.Controllers
{
    public class CustomerServiceIssuesController : Controller
    {
        private readonly GameForumContext _context;
        private readonly IWebHostEnvironment _env;

        public CustomerServiceIssuesController(GameForumContext context, IWebHostEnvironment env)
        {
            _context = context;
            _env = env;
        }


        public IActionResult Index()
        {
            string jsonFilePath = Path.Combine(_env.WebRootPath, "data", "faq.json");

            if (!System.IO.File.Exists(jsonFilePath))
            {
                return NotFound("FAQ 資料不存在");
            }

            string jsonContent = System.IO.File.ReadAllText(jsonFilePath);
            var faqData = JsonSerializer.Deserialize<FaqData>(jsonContent);

            return View(faqData);
        }

        [HttpPost]
        public async Task<IActionResult> Submit(IFormFile? image, string userId, string questionType, string questionDescription)
        {
            byte[]? imageData = null;

            var checkUserId = _context.Users
                .FirstOrDefault(u => u.UserId == userId);

            if (checkUserId == null)
            {
                TempData["ErrorMessage"] = "查無此用戶 ID，請重新輸入。";
                return RedirectToAction("Index");
            }

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
