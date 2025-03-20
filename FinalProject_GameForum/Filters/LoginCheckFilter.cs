using Microsoft.AspNetCore.Mvc;
using Microsoft.AspNetCore.Mvc.Filters;

namespace FinalProject_GameForum.Filters  // <- 可依專案命名空間調整
{
    public class LoginCheckFilter : IActionFilter
    {
        // 在 Action 執行前檢查是否登入
        public void OnActionExecuting(ActionExecutingContext context)
        {
            if (!context.HttpContext.User.Identity.IsAuthenticated)
            {
                // 未登入，回傳 JSON 給前端觸發 Modal
                context.Result = new JsonResult(new { loggedIn = false, message = "請先登入！" });
            }
        }

        // Action 執行後，暫不做處理
        public void OnActionExecuted(ActionExecutedContext context)
        {
            // Do nothing.
        }
    }
}