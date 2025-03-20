using FinalProject_GameForum.Models;
using Microsoft.AspNetCore.Mvc;
using Microsoft.EntityFrameworkCore;

namespace FinalProject_GameForum.Controllers
{
    public class ArticleController : Controller
    {
        private readonly GameForumContext _context;

        public ArticleController(GameForumContext context)
        {
            _context = context;
        }

        [HttpGet]
        public IActionResult Index(int id)
        {
            List<Article> articles = _context.Articles
           .Include(a => a.ArticleGroup)
           .Include(a => a.User)
           .Include(a => a.ArticleMessages)
               .ThenInclude(m => m.User)
           .Where(a => a.ArticleGroupId == id)
           .ToList();

            return View(articles);
        }

        //public IActionResult Index()
        //{
        //    TempArticle tk1 = new TempArticle("faker","五冠", "「能夠再次奪冠，我感到非常高興。這次勝利對我和隊伍都有著特殊的意義。」「感謝一直以來支持我們的粉絲，這個冠軍屬於你們。」", "../tempcontent/Faker.jpg");
        //    TempArticle tk2 = new TempArticle("Zeus", "神王", "「能夠在這樣的舞台上獲得勝利，我感到無比自豪。這是我們團隊共同努力的成果。」", "../tempcontent/Zeus.jpg");
        //    TempArticle tk3 = new TempArticle("Oner", "肌肉", "「這次奪冠對我們意義重大，我們將繼續努力，迎接未來的挑戰。」", "../tempcontent/Oner.jpg");
        //    TempArticle tk4 = new TempArticle("Gumayusi", "雞蛋", "「感謝粉絲們的支持，這個冠軍屬於你們。我們會繼續前行，為大家帶來更多精彩的比賽。」", "../tempcontent/Gumayusi.jpg");
        //    TempArticle tk5 = new TempArticle("Keria", "可愛", "「能與這樣優秀的隊友並肩作戰，我感到非常榮幸。我們的目標是持續進步，創造更多的輝煌。」", "../tempcontent/Keria.jpg");

        //    List<TempArticle> td = new List<TempArticle>
        //    {
        //        tk1,tk2,tk3,tk4,tk5
        //    };
        //    ViewBag.A1 = td;
        //    ViewBag.CreteTime = DateTime.Now.ToString();

        //    return View();
        //}
    }
}
