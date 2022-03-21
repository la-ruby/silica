import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  submit_form() {
    $('#' + $(this.element).attr('form') )[0].dispatchEvent(new CustomEvent('submit', {bubbles: true}))
  }
}
