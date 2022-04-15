import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = [ 'button' ]

  checkboxHandler(event) {
    if ($(event.target)[0].checked == true) {
      $(this.buttonTarget).removeClass('disabled')
    } else {
      $(this.buttonTarget).addClass('disabled')
    }
  }
}
