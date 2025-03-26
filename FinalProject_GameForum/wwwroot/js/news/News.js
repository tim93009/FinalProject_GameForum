function alertComment() {
    var message = document.getElementById("text").value; // 注意這裡改成 "text"，與 textarea 的 id 對應

    if (!message.trim()) {
        alert("留言內容不能空白!!");
        return false;
    }

    if (message.length > 80) {
        alert("不能超過80個字!!");
        return false;
    }

    return true;
}