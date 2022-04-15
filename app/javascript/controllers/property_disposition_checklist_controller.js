import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static values = { }
  static targets = [ "form" ]

  submit() {
    $(this.formTarget)[0].dispatchEvent(new CustomEvent('submit', {bubbles: true}))
  }
}
