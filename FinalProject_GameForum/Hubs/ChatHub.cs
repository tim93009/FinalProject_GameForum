using Microsoft.AspNetCore.SignalR;
using System.Threading.Tasks;


// 聊天室Hub
namespace FinalProject_GameForum.Hubs
{
    public class ChatHub : Hub
    {
        public async Task SendMessage(string message)
        {
            string userName = Context.User?.Identity?.Name ?? "訪客";
            await Clients.All.SendAsync("ReceiveMessage", userName, message);
        }
    }
}
