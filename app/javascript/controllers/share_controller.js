import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static values = { url: String }
  static targets = []

  click() {
    navigator.clipboard.writeText(this.urlValue)
    $("#flashes").removeClass('d-none')
    $("#flashes > div > .contents").html( "<span>\"" + this.urlValue + "\" copied to clipboard</span>" );
  }
}
