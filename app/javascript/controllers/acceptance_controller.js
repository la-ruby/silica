import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = [ 'accept' ]

  checkbox(event) {
    if ($(event.target).is(':checked')) {
      $(this.acceptTarget).attr('disabled', false)
    } else {
      $(this.acceptTarget).attr('disabled', true)
    }
  }
}
