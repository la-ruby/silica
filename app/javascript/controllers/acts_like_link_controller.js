import { Controller } from "@hotwired/stimulus"

// I think we can use role='button' for this
export default class extends Controller {
  static values = {
    href: String
  }
  static targets = [ "actionable" ]

  connect() {
    let that = this
    $(this.actionableTargets).on('click', function() {
      Turbo.visit(that.hrefValue)
    })
  }
}
