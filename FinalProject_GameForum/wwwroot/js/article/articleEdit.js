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

    modal.style.display = "block";
    linkText.value = quill.getText(range.index, range.length); // 預填選中的文字
    linkUrl.value = "";

    insertBtn.onclick = function () {
        let text = linkText.value.trim();
        let url = linkUrl.value.trim();

        if (text && url) {
            quill.deleteText(range.index, range.length);
            quill.insertText(range.index, text, { link: url });
        }
        modal.style.display = "none";
    };

    cancelBtn.onclick = function () {
        modal.style.display = "none";
    };
}
// 超連結(結束)
// 圖片(開始)
let savedRange = null; // 用來儲存坐標位置

function imageHandler() {
    savedRange = quill.getSelection(); // 儲存當前坐標位置
    let modal = document.getElementById("imageModal");
    modal.style.display = "block";

    let input = document.getElementById("imageInput");
    let uploadButton = document.getElementById("uploadImage");
    let closeButton = document.getElementById("closeModal");

    function closeModal() {
        modal.style.display = "none";
        input.value = "";
        document.getElementById("imageUrl").value = ""; // 清空輸入框
    }

    uploadButton.onclick = function () {
        var imageUrl = document.getElementById("imageUrl").value;
        if (imageUrl) {
            if (savedRange) {
                quill.setSelection(savedRange.index, Quill.sources.SILENT); // 恢復坐標位置
                quill.insertEmbed(savedRange.index, "image", imageUrl);
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
}



// 圖片(結束)
function videoHandler() {
    document.getElementById("videoModal").style.display = "block";
    document.getElementById("confirmVideo").onclick = () => {
        let url = document.getElementById("videoUrl").value;
        if (url) {
            const regExp = /^.*(youtu.be\/|v\/|u\/\w\/|embed\/|watch\?v=|&v=)([^#&?]*).*/;
            const match = url.match(regExp);
            if (match && match[2].length === 11) {
                let videoEmbedUrl = "https://www.youtube.com/embed/" + match[2];
                let range = quill.getSelection();
                quill.insertEmbed(range.index, "video", videoEmbedUrl);
                document.getElementById("videoModal").style.display = "none";
            }
            else {
                alert("請輸入有效的 YouTube 影片網址。");
            }
        }
    };

    document.getElementById("cancelVideo").onclick = () => {
        document.getElementById("videoModal").style.display = "none";
    };

    window.addEventListener("click", (event) => {
        if (event.target.classList.contains("modal")) {
            event.target.style.display = "none";
        }
    });

}


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