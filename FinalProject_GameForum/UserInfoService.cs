namespace FinalProject_GameForum
{
    public class UserInfoService
    {
        //宣告私人唯獨資料型別屬性(web站台環境資訊)
        private readonly IHttpContextAccessor _HttpContextAccessor;
        //宣告建構子 (初始化傳入參數的指定型別類別)
        public UserInfoService(IHttpContextAccessor httpContextAccessor)
        {
            //注入指定類別(Program.cs找得到)
            _HttpContextAccessor = httpContextAccessor;
        }

        //取得登入用戶其他欄位資訊方法
        //public string GetUserInfo()
        //{
        //    //取得Claims Identity驗證欄位的集合項目
        //    var Claim = _HttpContextAccessor.HttpContext!.User.Claims.ToList();
        //    var Email = Claim.Where(a => a.Type == "UserEmail").First().Value;
        //    var Name = Claim.Where(a => a.Type == "FullName").First().Value;

        //    //取得Claims Identity 欄位用戶名稱
        //    var Account = _HttpContextAccessor.HttpContext.User.Identity!.Name;

        //    return "信箱:" + Email + "姓名:" + Name + "帳號:" + Account;

        //}

        public string GetUserPW()
        {
            //取得Claims Identity驗證欄位的集合項目
            var Claim = _HttpContextAccessor.HttpContext!.User.Claims.ToList();
            var PW = Claim.Where(a => a.Type == "UserPW").First().Value;
            return PW;
        }



    }
}
