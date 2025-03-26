$(document).ready(function () {
    var userInfo = window.userInfo || {
        Name: "",
        Phone: "",
        Email: "",
        Address: ""
    };    

    $("#useUserInfo").on("change", function () {
        if ($(this).is(":checked")) {
            console.log("Checkbox checked");
            $("input[name='uname']").val(userInfo.Name || "");
            $("input[name='ucell']").val(userInfo.Phone || "");
            $("input[name='uemail']").val(userInfo.Email || "");
            $("input[name='uaddress']").val(userInfo.Address || "");
        } else {
            console.log("Checkbox unchecked");
            $("input[name='uname']").val("");
            $("input[name='ucell']").val("");
            $("input[name='uemail']").val("");
            $("input[name='uaddress']").val("");
        }
    });
});