import {Controller} from '@hotwired/stimulus'

export default class extends Controller {
  static targets = ['photo', 'uploadedPhoto']

  connect() {
    this.oneMB = 1048576
    this.uploadButton = document.getElementById('upload-button')
    this.uploadedPhotoContainer = document.getElementsByClassName('uploaded-photo-container')[0]
  }

  async getBase64(file) {
    return new Promise((resolve, reject) => {
      const reader = new FileReader();
      reader.readAsDataURL(file);
      reader.onload = function () {
        resolve(reader.result);
      };

      reader.onerror = function (error) {
        reject(error);
      };
    });
  }

  
  async change_photo() {
    try {
      if(this.photoTarget.files[0].size > this.oneMB * 5){
        alert("File is too big!")
      }else{
        const base64Result = await this.getBase64(this.photoTarget.files[0]);
        // Render new image
        this.uploadedPhotoContainer.classList.remove('d-none')
        this.uploadedPhotoTarget.src = base64Result
        
        // Hide old button
        this.uploadButton.classList.add('d-none')
      }
    } catch (error) {
      console.log("Error: ", error);
    }
  }

  remove_photo() {
    this.uploadedPhotoContainer.classList.add('d-none')
    this.uploadButton.classList.remove('d-none')
  }

  delete() {
    const deleteBtn = document.getElementById('delete-btn')
    deleteBtn.click()
  }
}
