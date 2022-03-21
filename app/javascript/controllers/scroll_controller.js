import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static values = { elementId: String }

  connect() {
    if (this.elementIdValue.length > 0) {
      let that = this
      setTimeout(function() {
        document.getElementById(that.elementIdValue).scrollIntoView()
      }, 500);
    }
  }
}
