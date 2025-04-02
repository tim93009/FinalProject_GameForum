using FinalProject_GameForum.Models;
using System.Text.Json;
using Microsoft.AspNetCore.Mvc;
using Microsoft.EntityFrameworkCore;
using Microsoft.AspNetCore.Authorization;
using System.Security.Claims;

namespace FinalProject_GameForum.Controllers
{
    public class CustomerServiceIssuesController : Controller
    {
        private readonly GameForumContext _context;
        private readonly IWebHostEnvironment _env;
        private string userId => User.FindFirst(ClaimTypes.NameIdentifier)?.Value ?? string.Empty; // 取得登入使用者 ID

        public CustomerServiceIssuesController(GameForumContext context, IWebHostEnvironment env)
        {
            _context = context;
            _env = env;
        }


        public IActionResult Index()
        {
            string jsonFilePath = Path.Combine(Directory.GetCurrentDirectory(), "App_Data", "faq.json");

            if (!System.IO.File.Exists(jsonFilePath))
            {
                return NotFound("FAQ 資料不存在");
            }

            string jsonContent = System.IO.File.ReadAllText(jsonFilePath);
            var faqData = JsonSerializer.Deserialize<FaqData>(jsonContent);

            ViewBag.UserID = userId;
            return View(faqData);
        }

        [Authorize(Roles = "Admin")]
        public async Task<IActionResult> ViewProblem()
        {
            var customerProblems = await _context.CustomerProblems
                .Include(cp => cp.User)
                .ToListAsync();

            // 轉換 byte[] 圖片為 Base64 字串
            foreach (var problem in customerProblems)
            {
                if (problem.Image != null)
                {
                    problem.ImageBase64 = Convert.ToBase64String(problem.Image);
                }
            }
            return View(customerProblems);
        }

        [HttpPost]
        public async Task<IActionResult> Submit(IFormFile? image, string userId, string questionType, string questionDescription)
        {
            byte[]? imageData = null;

            var checkUserId = _context.Users
                .FirstOrDefault(u => u.UserId == userId);

            if (checkUserId == null)
            {
                TempData["Message"] = "查無此用戶 ID，請重新輸入。";
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
            if (ModelState.IsValid)
            {
                CustomerProblem problem = new CustomerProblem
                {
                    UserId = userId,
                    QuestionType = questionType,
                    QuestionDescription = questionDescription,
                    Image = imageData
                };

                _context.CustomerProblems.Add(problem);
                await _context.SaveChangesAsync();

                TempData["Message"] = "您的問題已成功提交，我們將盡快處理！";
            }
            else
            {
                TempData["Message"] = "您的問題提交失敗，請稍後再試！";

            }
            return RedirectToAction("Index");
        }
    }
}
