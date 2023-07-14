import {Controller} from '@hotwired/stimulus'

export default class extends Controller {
  static targets = ['select']
  connect() {
    const options = this.selectTarget.children
    for(const option of options) {
      const elementType = option.value.split('/').slice(-1)[0]
      if(elementType && window.location.href.includes(elementType)){
        option.setAttribute('selected', true)
      }
    }
  }
  navigate(event) {
    window.location.href = event.target.value
  }
}
