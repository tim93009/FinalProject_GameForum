$(document).ready(function () {
    var userInfo = window.userInfo || {
        Name: "",
        Phone: "",
        Email: "",
        Address: ""
    };

    // 根據地址判斷郵遞區號的完整映射表
    function getPostalCode(address) {
        if (!address) return "";

        // 標準化地址：轉小寫並移除多餘空格
        var normalizedAddress = address.toLowerCase().replace(/\s+/g, "");
        console.log("Normalized Address: " + normalizedAddress); // 調試：檢查標準化後的地址

        // 台北市
        if (normalizedAddress.includes("台北市中正區")) return "100";
        if (normalizedAddress.includes("台北市大同區")) return "103";
        if (normalizedAddress.includes("台北市中山區")) return "104";
        if (normalizedAddress.includes("台北市松山區")) return "105";
        if (normalizedAddress.includes("台北市大安區")) return "106";
        if (normalizedAddress.includes("台北市萬華區")) return "108";
        if (normalizedAddress.includes("台北市信義區")) return "110";
        if (normalizedAddress.includes("台北市士林區")) return "111";
        if (normalizedAddress.includes("台北市北投區")) return "112";
        if (normalizedAddress.includes("台北市內湖區")) return "114";
        if (normalizedAddress.includes("台北市南港區")) return "115";
        if (normalizedAddress.includes("台北市文山區")) return "116";

        // 新北市
        if (normalizedAddress.includes("新北市萬里區")) return "207";
        if (normalizedAddress.includes("新北市金山區")) return "208";
        if (normalizedAddress.includes("新北市板橋區")) return "220";
        if (normalizedAddress.includes("新北市汐止區")) return "221";
        if (normalizedAddress.includes("新北市深坑區")) return "222";
        if (normalizedAddress.includes("新北市石碇區")) return "223";
        if (normalizedAddress.includes("新北市瑞芳區")) return "224";
        if (normalizedAddress.includes("新北市平溪區")) return "226";
        if (normalizedAddress.includes("新北市雙溪區")) return "227";
        if (normalizedAddress.includes("新北市貢寮區")) return "228";
        if (normalizedAddress.includes("新北市新店區")) return "231";
        if (normalizedAddress.includes("新北市坪林區")) return "232";
        if (normalizedAddress.includes("新北市烏來區")) return "233";
        if (normalizedAddress.includes("新北市永和區")) return "234";
        if (normalizedAddress.includes("新北市中和區")) return "235";
        if (normalizedAddress.includes("新北市土城區")) return "236";
        if (normalizedAddress.includes("新北市三峽區")) return "237";
        if (normalizedAddress.includes("新北市樹林區")) return "238";
        if (normalizedAddress.includes("新北市鶯歌區")) return "239";
        if (normalizedAddress.includes("新北市三重區")) return "241";
        if (normalizedAddress.includes("新北市新莊區")) return "242";
        if (normalizedAddress.includes("新北市泰山區")) return "243";
        if (normalizedAddress.includes("新北市林口區")) return "244";
        if (normalizedAddress.includes("新北市蘆洲區")) return "247";
        if (normalizedAddress.includes("新北市五股區")) return "248";
        if (normalizedAddress.includes("新北市八里區")) return "249";
        if (normalizedAddress.includes("新北市淡水區")) return "251";
        if (normalizedAddress.includes("新北市三芝區")) return "252";
        if (normalizedAddress.includes("新北市石門區")) return "253";

        // 桃園市
        if (normalizedAddress.includes("桃園市中壢區")) return "320";
        if (normalizedAddress.includes("桃園市平鎮區")) return "324";
        if (normalizedAddress.includes("桃園市龍潭區")) return "325";
        if (normalizedAddress.includes("桃園市楊梅區")) return "326";
        if (normalizedAddress.includes("桃園市新屋區")) return "327";
        if (normalizedAddress.includes("桃園市觀音區")) return "328";
        if (normalizedAddress.includes("桃園市桃園區")) return "330";
        if (normalizedAddress.includes("桃園市龜山區")) return "333";
        if (normalizedAddress.includes("桃園市八德區")) return "334";
        if (normalizedAddress.includes("桃園市大溪區")) return "335";
        if (normalizedAddress.includes("桃園市復興區")) return "336";
        if (normalizedAddress.includes("桃園市大園區")) return "337";
        if (normalizedAddress.includes("桃園市蘆竹區")) return "338";

        // 台中市
        if (normalizedAddress.includes("台中市中區")) return "400";
        if (normalizedAddress.includes("台中市東區")) return "401";
        if (normalizedAddress.includes("台中市南區")) return "402";
        if (normalizedAddress.includes("台中市西區")) return "403";
        if (normalizedAddress.includes("台中市北區")) return "404";
        if (normalizedAddress.includes("台中市北屯區")) return "406";
        if (normalizedAddress.includes("台中市西屯區")) return "407";
        if (normalizedAddress.includes("台中市南屯區")) return "408";
        if (normalizedAddress.includes("台中市太平區")) return "411";
        if (normalizedAddress.includes("台中市大里區")) return "412";
        if (normalizedAddress.includes("台中市霧峰區")) return "413";
        if (normalizedAddress.includes("台中市烏日區")) return "414";
        if (normalizedAddress.includes("台中市豐原區")) return "420";
        if (normalizedAddress.includes("台中市后里區")) return "421";
        if (normalizedAddress.includes("台中市石岡區")) return "422";
        if (normalizedAddress.includes("台中市東勢區")) return "423";
        if (normalizedAddress.includes("台中市和平區")) return "424";
        if (normalizedAddress.includes("台中市新社區")) return "426";
        if (normalizedAddress.includes("台中市潭子區")) return "427";
        if (normalizedAddress.includes("台中市大雅區")) return "428";
        if (normalizedAddress.includes("台中市神岡區")) return "429";
        if (normalizedAddress.includes("台中市大肚區")) return "432";
        if (normalizedAddress.includes("台中市沙鹿區")) return "433";
        if (normalizedAddress.includes("台中市龍井區")) return "434";
        if (normalizedAddress.includes("台中市梧棲區")) return "435";
        if (normalizedAddress.includes("台中市清水區")) return "436";
        if (normalizedAddress.includes("台中市大甲區")) return "437";
        if (normalizedAddress.includes("台中市外埔區")) return "438";
        if (normalizedAddress.includes("台中市大安區")) return "439";

        // 台南市
        if (normalizedAddress.includes("台南市中西區")) return "700";
        if (normalizedAddress.includes("台南市東區")) return "701";
        if (normalizedAddress.includes("台南市南區")) return "702";
        if (normalizedAddress.includes("台南市北區")) return "704";
        if (normalizedAddress.includes("台南市安平區")) return "708";
        if (normalizedAddress.includes("台南市安南區")) return "709";
        if (normalizedAddress.includes("台南市永康區")) return "710";
        if (normalizedAddress.includes("台南市歸仁區")) return "711";
        if (normalizedAddress.includes("台南市新化區")) return "712";
        if (normalizedAddress.includes("台南市左鎮區")) return "713";
        if (normalizedAddress.includes("台南市玉井區")) return "714";
        if (normalizedAddress.includes("台南市楠西區")) return "715";
        if (normalizedAddress.includes("台南市南化區")) return "716";
        if (normalizedAddress.includes("台南市仁德區")) return "717";
        if (normalizedAddress.includes("台南市關廟區")) return "718";
        if (normalizedAddress.includes("台南市龍崎區")) return "719";
        if (normalizedAddress.includes("台南市官田區")) return "720";
        if (normalizedAddress.includes("台南市麻豆區")) return "721";
        if (normalizedAddress.includes("台南市佳里區")) return "722";
        if (normalizedAddress.includes("台南市西港區")) return "723";
        if (normalizedAddress.includes("台南市七股區")) return "724";
        if (normalizedAddress.includes("台南市將軍區")) return "725";
        if (normalizedAddress.includes("台南市學甲區")) return "726";
        if (normalizedAddress.includes("台南市北門區")) return "727";
        if (normalizedAddress.includes("台南市新營區")) return "730";
        if (normalizedAddress.includes("台南市後壁區")) return "731";
        if (normalizedAddress.includes("台南市白河區")) return "732";
        if (normalizedAddress.includes("台南市東山區")) return "733";
        if (normalizedAddress.includes("台南市六甲區")) return "734";
        if (normalizedAddress.includes("台南市下營區")) return "735";
        if (normalizedAddress.includes("台南市柳營區")) return "736";
        if (normalizedAddress.includes("台南市鹽水區")) return "737";
        if (normalizedAddress.includes("台南市善化區")) return "741";
        if (normalizedAddress.includes("台南市大內區")) return "742";
        if (normalizedAddress.includes("台南市山上區")) return "743";
        if (normalizedAddress.includes("台南市新市區")) return "744";
        if (normalizedAddress.includes("台南市安定區")) return "745";

        // 高雄市
        if (normalizedAddress.includes("高雄市新興區")) return "800";
        if (normalizedAddress.includes("高雄市前金區")) return "801";
        if (normalizedAddress.includes("高雄市苓雅區")) return "802";
        if (normalizedAddress.includes("高雄市鹽埕區")) return "803";
        if (normalizedAddress.includes("高雄市鼓山區")) return "804";
        if (normalizedAddress.includes("高雄市旗津區")) return "805";
        if (normalizedAddress.includes("高雄市前鎮區")) return "806";
        if (normalizedAddress.includes("高雄市三民區")) return "807";
        if (normalizedAddress.includes("高雄市左營區")) return "813";
        if (normalizedAddress.includes("高雄市楠梓區")) return "811";
        if (normalizedAddress.includes("高雄市小港區")) return "812";
        if (normalizedAddress.includes("高雄市仁武區")) return "814";
        if (normalizedAddress.includes("高雄市大社區")) return "815";
        if (normalizedAddress.includes("高雄市岡山區")) return "820";
        if (normalizedAddress.includes("高雄市路竹區")) return "821";
        if (normalizedAddress.includes("高雄市阿蓮區")) return "822";
        if (normalizedAddress.includes("高雄市田寮區")) return "823";
        if (normalizedAddress.includes("高雄市燕巢區")) return "824";
        if (normalizedAddress.includes("高雄市橋頭區")) return "825";
        if (normalizedAddress.includes("高雄市梓官區")) return "826";
        if (normalizedAddress.includes("高雄市彌陀區")) return "827";
        if (normalizedAddress.includes("高雄市永安區")) return "828";
        if (normalizedAddress.includes("高雄市湖內區")) return "829";
        if (normalizedAddress.includes("高雄市鳳山區")) return "830";
        if (normalizedAddress.includes("高雄市大寮區")) return "831";
        if (normalizedAddress.includes("高雄市林園區")) return "832";
        if (normalizedAddress.includes("高雄市鳥松區")) return "833";
        if (normalizedAddress.includes("高雄市大樹區")) return "840";
        if (normalizedAddress.includes("高雄市旗山區")) return "842";
        if (normalizedAddress.includes("高雄市美濃區")) return "843";
        if (normalizedAddress.includes("高雄市六龜區")) return "844";
        if (normalizedAddress.includes("高雄市內門區")) return "845";
        if (normalizedAddress.includes("高雄市杉林區")) return "846";
        if (normalizedAddress.includes("高雄市甲仙區")) return "847";
        if (normalizedAddress.includes("高雄市桃源區")) return "848";
        if (normalizedAddress.includes("高雄市那瑪夏區")) return "849";
        if (normalizedAddress.includes("高雄市茂林區")) return "851";
        if (normalizedAddress.includes("高雄市茄萣區")) return "852";

        // 其他縣市
        if (normalizedAddress.includes("基隆市")) return "200";
        if (normalizedAddress.includes("宜蘭縣")) return "260";
        if (normalizedAddress.includes("新竹市")) return "300";
        if (normalizedAddress.includes("新竹縣")) return "310";
        if (normalizedAddress.includes("苗栗縣")) return "350";
        if (normalizedAddress.includes("彰化縣")) return "500";
        if (normalizedAddress.includes("南投縣")) return "540";
        if (normalizedAddress.includes("雲林縣")) return "630";
        if (normalizedAddress.includes("嘉義市")) return "600";
        if (normalizedAddress.includes("嘉義縣")) return "610";
        if (normalizedAddress.includes("屏東縣")) return "900";
        if (normalizedAddress.includes("花蓮縣")) return "970";
        if (normalizedAddress.includes("台東縣")) return "950";
        if (normalizedAddress.includes("澎湖縣")) return "880";
        if (normalizedAddress.includes("金門縣")) return "890";
        if (normalizedAddress.includes("連江縣")) return "209";

        console.log("No match found"); // 調試：若無匹配
        return ""; // 若無匹配，留空
    }

    $("#useUserInfo").on("change", function () {
        if ($(this).is(":checked")) {
            console.log("Checkbox checked"); // 調試：確認事件觸發
            $("input[name='uname']").val(userInfo.Name || "");
            $("input[name='ucell']").val(userInfo.Phone || "");
            $("input[name='uemail']").val(userInfo.Email || "");

            var address = userInfo.Address || "";
            var postalCode = getPostalCode(address);
            console.log("Postal Code: " + postalCode); // 調試：檢查返回值
            $("input[name='upostal']").val(getPostalCode(address));
            $("input[name='uaddress']").val(address);
        } else {
            console.log("Checkbox unchecked"); // 調試：確認事件觸發
            $("input[name='uname']").val("");
            $("input[name='ucell']").val("");
            $("input[name='uemail']").val("");
            $("input[name='upostal']").val("");
            $("input[name='uaddress']").val("");
        }
    });
});