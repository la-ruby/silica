import { Controller } from "@hotwired/stimulus"

// TODO: add delay/debounce
export default class extends Controller {
  submit_form() {
    $(this.element)[0].dispatchEvent(new CustomEvent('submit', {bubbles: true}))
  }
}
