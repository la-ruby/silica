import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = [ "form" ]

  disableSendMarketingEmailButton() {
    console.log('disabling')
    $('#send-marketing-email').addClass('disabled')
  }
}
