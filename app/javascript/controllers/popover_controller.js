import { Controller } from "@hotwired/stimulus"

export default class extends Controller {  
  connect() {
    // got from getbootstrap.com/docs/5.1/components/popovers/
    new bootstrap.Popover(this.element, {
      trigger: 'focus'
    })
  }
}
