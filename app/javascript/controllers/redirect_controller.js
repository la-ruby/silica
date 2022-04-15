import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static values = { url: String }

  connect() {
    if (this.urlValue.length > 0) {
      let that = this
      setTimeout(function() {
        window.location.href = that.urlValue
      }, 500);
    }
  }
}
