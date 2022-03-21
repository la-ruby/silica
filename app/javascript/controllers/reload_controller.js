import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static values = { example: String }

  connect() {
    if (this.exampleValue.length > 0) {
      let that = this
      setTimeout(function() {
        window.location.reload()
      }, 1);
    }
  }
}
