
//確認密碼
function Password() {
    let OldPassword = document.getElementById("OldPassword").value;
    let NewPassword = document.getElementById("NewPassword").value;
    let RePassword = document.getElementById("RePassword").value;
    let pass = document.getElementById("save")

    if (OldPassword !== "" && NewPassword !== "" && RePassword !== "" && NewPassword == RePassword) {
        pass.removeAttribute("disabled");
    } else {
        pass.setAttribute("disabled", true)
    }
}


//個人資料編輯
function MemberEdit(isEditing) {
    let files = ["Email", "Birthdate", "address", "Phone"]
  
    files.forEach(id => {
        let input = document.getElementById(id);
        if (isEditing) {
            input.classList.remove("form-control-plaintext")
            input.classList.add("form-control")
            input.removeAttribute("readonly")
          
        } else {
            input.classList.remove("form-control")
            input.classList.add("form-control-plaintext")
            input.setAttribute("readonly", true)
          
        }
    })
  

    document.getElementById('MemberEdit').classList.toggle('d-none', !isEditing)
    document.getElementById('Edit').classList.toggle('d-none', isEditing)
}

function saveMember() {
    /*上傳資料*/
    MemberEdit(false)
}

//暱稱編輯
function NameEdit(isEditing) {
    document.getElementById('MemberName').classList.toggle("d-none", isEditing);
    document.getElementById('nameInput').classList.toggle("d-none", !isEditing)
    document.getElementById('imageInput').classList.toggle("d-none", !isEditing)
    document.querySelector("h5 a").classList.toggle("d-none", isEditing);
    document.getElementById("EditButton").classList.toggle("d-none", !isEditing);
}


function saveChanges() {
    let newName = document.getElementById('nameInput').value;
    document.getElementById('MemberName').textContent = newName;
    document.getElementById('MemberName').classList.remove("d-none");
    document.getElementById('nameInput').classList.add("d-none");

    let newImage = document.getElementById('imageInput');
    if (newImage.files.length > 0) {
        let reader = new FileReader();
        reader.onload = function (e) {
            document.getElementById('profileImage').src = e.target.result;
        }
        reader.readAsDataURL(newImage.files[0])
    }
    document.getElementById('imageInput').classList.add('d-none')
    document.getElementById('EditButton').classList.add('d-none')
    document.querySelector("h5 a").classList.remove("d-none")
}

document.addEventListener("DOMContentLoaded", function () {
    document.body.classList.add("fade-in");
});

function high() {
    document.getElementById('list-profile-list').classList.remove("active")
    document.getElementById('list-home-list').classList.add("active")
}


function previewImage(event) {
    var input = event.target;
    if (input.files && input.files[0]) {
        var reader = new FileReader();
        reader.onload = function (e) {
            document.getElementById('profileImage').src = e.target.result;
        }
        reader.readAsDataURL(input.files[0])
    }
}

document.getElementById('Infocancel').addEventListener('click', function () {
    document.getElementById('InfoForm').reset()
})

document.getElementById('Namecancel').addEventListener('click', function () {
    document.getElementById('NameForm').reset()
})