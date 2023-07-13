import {Controller} from '@hotwired/stimulus'

export default class extends Controller {
  static targets = ['photo', 'uploadedPhoto']

  async fetchAndConvertToFile(url) {
    try {
      // Get filename 
      const filename = url.split('/').pop()

      const response = await fetch(url)
      const blob = await response.blob()
      const file = new File([blob], filename, {type: blob.type})

      return file
    } catch (error) {
      console.log("[ERROR FETCHING FILE]: ", error)
    }
  }

  async fetchImages(urls) {
    const fetchedFiles = []
    for(const url of urls) {
      const file = await this.fetchAndConvertToFile(url)
      fetchedFiles.push(file)
    }
    return fetchedFiles
  }

  connect() {
    // Keep track of UI elements
    this.albumPhotos = new Map()

    // Keep track of actual files for deletion
    this.filesHash = new Map()

    // Keep track of actual files for submitting
    this.dt = new DataTransfer()

    this.uploadButton = document.getElementById('upload-button')
    this.uploadedPhotoContainer = document.getElementsByClassName('uploaded-photo-container')[0]
    this.albumPhotoContainer = document.getElementById('album-photo-container')

    const existedPhotosURLs = JSON.parse(this.data.get('existed-photos'))
    if(existedPhotosURLs && existedPhotosURLs.length > 0){
      this.fetchImages(existedPhotosURLs)
        .then(fetchedFiles => {
          fetchedFiles.forEach((file,index) => {
            this.dt.items.add(file)
            this.filesHash.set(index, file)
          })
          // Assign id to the span for remove event
          if(this.albumPhotoContainer.children.length > 2){
            for(let i =2; i<this.albumPhotoContainer.children.length;i++){
              this.albumPhotoContainer.children[i].children[0].id = i - 2
              this.albumPhotos.set(i-2, this.albumPhotoContainer.children[i])
            }
          }
          console.log("FINISHED")
        })
    }
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

  generatePhoto(base64Result) {
    const newPhotoContainer = this.uploadedPhotoContainer.cloneNode(true)
    newPhotoContainer.children[0].id = this.albumPhotos.size
    newPhotoContainer.children[1].src = base64Result
    newPhotoContainer.classList.remove('d-none')
    return newPhotoContainer
  }
  
  async change_photo() {
    try {
      console.log("BEFORE: ", this.photoTarget.files)
      Array.from(this.photoTarget.files).forEach(file => {
        this.dt.items.add(file)
      })
      const tempFiles = this.photoTarget.files
      this.photoTarget.files = this.dt.files
      Array.from(tempFiles).forEach(async file => {
        console.log("HERE")
        const base64Result = await this.getBase64(file);
        const newPhotoContainer = this.generatePhoto(base64Result)

        this.albumPhotos.set(this.albumPhotos.size, newPhotoContainer)
        this.filesHash.set(this.albumPhotos.size-1, file)
        console.log(this.filesHash)
        // Render new images
        if(this.albumPhotos.size === 0){
          this.albumPhotoContainer.appendChild(newPhotoContainer)
        }else {
          this.albumPhotos.forEach((photo,_) => {
            this.albumPhotoContainer.appendChild(photo)
          })
        }
      })
    } catch (error) {
      console.log("Error: ", error);
    }
  }

  remove_photo(event) {
    const photoID = +(event.target.id || event.target.closest('span').id)
    console.log(this.filesHash)
    this.albumPhotos.delete(photoID)
    // Remove photo in DOM 
    const length = this.albumPhotoContainer.children.length
    // First 2 element is the template and upload button
    for(let i=2;i<length;i++) {
      const parentChild = this.albumPhotoContainer.children[i]
      if(parentChild.children[0].id == photoID){
        this.albumPhotoContainer.removeChild(parentChild)
        break
      }
    }
    // Remove file from filesHash
    this.filesHash.delete(photoID)
    const filesArrays = []

    this.filesHash.forEach(file => {
      filesArrays.push(file)
    })

    this.dt.items.clear()
    // Create new FileList 
    filesArrays.forEach(file => {
      this.dt.items.add(file)
    })

    this.photoTarget.files = this.dt.files
    console.log("REMOVE: ",this.photoTarget.files)
  }

  delete() {
    const deleteBtn = document.getElementById('delete-btn')
    deleteBtn.click()
  }
}
