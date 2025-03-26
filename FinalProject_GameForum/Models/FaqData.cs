using System.Text.Json.Serialization;

namespace FinalProject_GameForum.Models
{
    public class FaqData
    {
        [JsonPropertyName("accountFaqList")]
        public List<FaqItem> AccountFaqList { get; set; } = new();
        [JsonPropertyName("shopFaqList")]
        public List<FaqItem> ShopFaqList { get; set; } = new();
    }
}
