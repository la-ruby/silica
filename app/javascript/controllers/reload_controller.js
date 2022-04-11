import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static values = { should: String }

  connect() {
    if (this.shouldValue.length > 0) {
      let that = this
      setTimeout(function() {
        window.location.reload()
      }, 1);
    }
  }
}
