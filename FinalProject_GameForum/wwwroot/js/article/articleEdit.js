var Font = Quill.import("formats/font");
// 定義字體
Font.whitelist = ["Arial", "Helvetica", "Verdana", "Times-New-Roman", "Georgia", "Courier-New", "Comic-Sans-MS",
    "Microsoft-JhengHei", "PingFang-TC", "DFKai-SB", "PMingLiU", "MingLiU"];
Quill.register(Font, true);


// 加入字體
const style = document.createElement("style");
style.innerHTML = `
	  .ql-font-Arial { font-family: "Arial"}
	  .ql-font-Helvetica { font-family: "Helvetica"}
	  .ql-font-Verdana { font-family: "Verdana"}
	  .ql-font-Times-New-Roman { font-family: "Times New Roman"}
	  .ql-font-Georgia { font-family: "Georgia"}
	  .ql-font-Courier-New { font-family: "Courier New"}
	  .ql-font-Comic-Sans-MS { font-family: "Comic Sans MS"}
	  .ql-font-Microsoft-JhengHei { font-family: "Microsoft JhengHei"}
	  .ql-font-PingFang-TC { font-family: "PingFang TC"}
	  .ql-font-DFKai-SB { font-family: "DFKai-SB"}
	  .ql-font-PMingLiU { font-family: "PMingLiU"}
	  .ql-font-MingLiU { font-family: "MingLiU"}
	`;
document.head.appendChild(style);


// 加入水平線(開始)
var BlockEmbed = Quill.import("blots/block/embed");

class HrBlot extends BlockEmbed {
    static create() {
        let node = document.createElement("hr");
        // node.setAttribute("style", "height:0px; margin-top:10px; margin-bottom:10px;");
        return node;
    }
}
HrBlot.blotName = "hr";
// Hr.className = "my-hr";
HrBlot.tagName = "hr";
Quill.register(HrBlot);

function hrHandler() {
    let range = this.quill.getSelection();
    if (range) {
        this.quill.insertEmbed(range.index, "hr", true);
        this.quill.setSelection(range.index + 1, Quill.sources.SILENT);
    }
}
// 加入水平線(結束)
// 超連結(開始)
function linkHandler() {
    let range = quill.getSelection();
    if (!range) return; // 如果沒有選擇文字，則不執行

    let modal = document.getElementById("LinkModal");
    let linkText = document.getElementById("linkText");
    let linkUrl = document.getElementById("linkUrl");
    let insertBtn = document.getElementById("insertLink");
    let cancelBtn = document.getElementById("cancelLink");
    let overlay = document.getElementById("overlay"); // 取得遮罩層

    modal.style.display = "block";
    overlay.style.display = "block";

    linkText.value = quill.getText(range.index, range.length); // 預填選中的文字
    linkUrl.value = "";

      function closeModal() {
        modal.style.display = "none";
        overlay.style.display = "none";
    }

    insertBtn.onclick = function () {
        let text = linkText.value.trim();
        let url = linkUrl.value.trim();

        if (text && url) {
            quill.deleteText(range.index, range.length);
            quill.insertText(range.index, text, { link: url });
        }
        closeModal();
    };

    cancelBtn.onclick = closeModal;
    overlay.onclick = closeModal;

    // 讓點擊 modal 外部時關閉
    window.addEventListener("click", function (event) {
        if (event.target === modal || event.target === overlay) {
            closeModal();
        }
    });
}
// 超連結(結束)
// 圖片(開始)
let savedImageRange = null; // 用來儲存座標位置

function imageHandler() {
    savedImageRange = quill.getSelection(); // 儲存當前座標位置
    let modal = document.getElementById("imageModal");
    let overlay = document.getElementById("overlay"); // 取得遮罩層

    modal.style.display = "block";
    overlay.style.display = "block";

    let input = document.getElementById("imageInput");
    let uploadButton = document.getElementById("uploadImage");
    let closeButton = document.getElementById("closeModal");

    function closeModal() {
        modal.style.display = "none";
        overlay.style.display = "none";
        input.value = "";
        document.getElementById("imageUrl").value = ""; // 清空輸入框
    }

    uploadButton.onclick = function () {
        var imageUrl = document.getElementById("imageUrl").value;
        if (imageUrl) {
            if (savedImageRange) {
                quill.setSelection(savedImageRange.index, Quill.sources.SILENT); // 恢復座標位置
                quill.insertEmbed(savedImageRange.index, "image", imageUrl);
            }

            // 等待 Quill 插入圖片後，再為圖片添加 class
            setTimeout(() => {
                let insertedImages = document.querySelectorAll(".ql-editor img");
                insertedImages.forEach(img => {
                    if (img.src === imageUrl && !img.classList.contains("custom-image-class")) {
                        img.classList.add("custom-image-class");
                    }
                });
            }, 10);

            closeModal();
        }
    };

    closeButton.onclick = closeModal;
    overlay.onclick = closeModal;
}



// 圖片(結束)
// 影片(開始)
let savedVideoRange = null; // 用來儲存影片插入的座標位置

function videoHandler() {
    savedVideoRange = quill.getSelection(); // 儲存當前選取位置
    let modal = document.getElementById("videoModal");
    let overlay = document.getElementById("overlay");
    modal.style.display = "block";
    overlay.style.display = "block"; 

    document.getElementById("confirmVideo").onclick = () => {
        let url = document.getElementById("videoUrl").value;
        if (url) {
            const regExp = /^.*(youtu.be\/|v\/|u\/\w\/|embed\/|watch\?v=|&v=)([^#&?]*).*/;
            const match = url.match(regExp);
            if (match && match[2].length === 11) {
                let videoEmbedUrl = "https://www.youtube.com/embed/" + match[2];

                if (savedVideoRange) {
                    quill.setSelection(savedVideoRange.index, Quill.sources.SILENT); // 恢復座標位置
                    quill.insertEmbed(savedVideoRange.index, "video", videoEmbedUrl);
                }

                modal.style.display = "none";
                overlay.style.display = "none"; 

            } else {
                alert("請輸入有效的 YouTube 影片網址。");
            }
        }
    };

    document.getElementById("cancelVideo").onclick = () => {
        modal.style.display = "none";
        overlay.style.display = "none";
    };

    window.addEventListener("click", (event) => {
       

        if (event.target === modal || event.target === overlay) {
            modal.style.display = "none";
            overlay.style.display = "none";
        }
    });
}
// 影片(結束)


// 綁定撤銷（Undo）按鈕
document.getElementById("undo-button").addEventListener("click", function () {
    quill.history.undo();
});

// 綁定重做（Redo）按鈕
document.getElementById("redo-button").addEventListener("click", function () {
    quill.history.redo();
});


document.getElementById("imgFile").addEventListener("change", function (event) {
    const file = event.target.files[0]; // 取得選擇的檔案
    if (file) {
        const reader = new FileReader();
        reader.onload = function (e) {
            const previewImg = document.getElementById("previewImg");
            previewImg.src = e.target.result;
            imgFileBlock.style.visibility = "visible";
        };
        reader.readAsDataURL(file); // 讀取檔案內容並轉為 Base64
    }
});

var quill = new Quill("#editor", {
	theme: "snow",
	modules: {
		toolbar: {
			container: "#toolbar-container",
			handlers: {
				link: linkHandler,
				image: imageHandler,
				hr: hrHandler,
				video: videoHandler,
			}
		},
		history: {
			delay: 100,
			maxStack: 100,
			userOnly: true
		}
	}
});


// 提交表單時，把 Quill 內容轉換成 HTML 放入 textarea
document.getElementById("editorForm").addEventListener("submit", function (event) {
    // 將 Quill 內容轉換為 HTML
    document.getElementById("hiddenContent").value = quill.root.innerHTML;
});