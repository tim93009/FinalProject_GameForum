function viewEmail() {
    var email = $('#vote_email').val().trim(); // 確保獲取輸入框值
    if (email === '') {
        alert('請輸入電子信箱');
        $('#vote_email').focus();
        return false;
    } else {
        var emailRegxp = /^[\w.-]+@[\w.-]+\.[a-zA-Z]{2,}$/; // 正確的 email 格式
        if (!emailRegxp.test(email)) {
            alert('電子信箱格式錯誤');
            $('#vote_email').focus();
            $('#vote_email').select();
            return false;
        }
    }
    alert('驗證成功！');
    
}