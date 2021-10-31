const fileInput = document.querySelector('#user_profile_picture');
fileInput.onchange = () => {
  if (fileInput.files.length > 0) {
    const fileName = document.querySelector('#uploading-file');
    fileName.textContent = fileInput.files[0].name;
  }
}