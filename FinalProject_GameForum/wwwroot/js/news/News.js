var textarea = document.getElementById("text");
if (textarea) {
    textarea.addEventListener("input", function () {
        var message = this.value;
        var counter = document.getElementById("char-count");

        textarea.classList.remove("error");
        if (error) {
            error.remove();
        }

        if (!counter) {
            counter = document.createElement("span");
            counter.id = "char-count";
            textarea.parentElement.appendChild(counter);
        }
        counter.innerText = `${message.length} / 80`;

        if (message.length > 79) {
            this.value = message.substring(0, 80);
            counter.innerText = "80 / 80";
            textarea.classList.add("error");
        } else {
            textarea.classList.remove("error");
        }
    });
}
function alertComment() {

    var message = document.getElementById("text").value;

    if (!message.trim()) {
        alert("留言內容不能空白!!");
        return false;
    }   
    
    return true;
}