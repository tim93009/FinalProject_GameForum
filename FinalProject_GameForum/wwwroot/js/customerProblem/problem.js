const form = document.getElementById('uploadForm');
const imageInput = document.getElementById('image');
const errorMessage = document.getElementById('error-message');
const maxSizeInBytes = 2 * 1024 * 1024; // 2MB

imageInput.addEventListener('change', checkFile);
form.addEventListener('submit', function (event) {
    const file = imageInput.files[0];
    if (file) {
        if (!file.type.startsWith('image/')) {
            event.preventDefault();
            errorMessage.textContent = '僅允許上傳圖片檔案！';
            errorMessage.style.display = 'block';
        } else if (file.size > maxSizeInBytes) {
            event.preventDefault();
            errorMessage.textContent = '圖片檔案過大，最大限制為 2MB。';
            errorMessage.style.display = 'block';
        }
    }
});

function checkFile(event) {
    const file = event.target.files[0];
    errorMessage.style.display = 'none';
    errorMessage.textContent = '';

    if (file) {
        if (!file.type.startsWith('image/')) {
            errorMessage.textContent = '僅允許上傳圖片檔案！';
            errorMessage.style.display = 'block';
            event.target.value = '';
        } else if (file.size > maxSizeInBytes) {
            errorMessage.textContent = '圖片檔案過大，最大限制為 2MB。';
            errorMessage.style.display = 'block';
            event.target.value = '';
        }
    }
}