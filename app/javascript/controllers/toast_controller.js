import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = ["liveToast"]

  static values = {
    status: String
  }

  connect() {
    console.log(this.statusValue)
    switch (this.statusValue) {
      case 'error':
      case 'alert':
        this.color = '#c23a3a'
        break;
      case 'success':
        this.color = '#3ac243'
        break
    }
    if(this.liveToastTarget.children.length != 0){
      this.liveToastTarget.style.border = `2px solid ${this.color}`
      const toastTitle = document.getElementsByTagName("strong")
      toastTitle[0].style.color = this.color
    }
    setTimeout(() => {
      this.hide()
    }, 10000);
  }

  show() {
    this.liveToastTarget.classList.add("d-block")

  }

  hide() {
    this.liveToastTarget.classList.add("d-none")
  }
}
