import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = [ 'plus', 'search', 'searchBtn', 'form', 'pagination', 'save' ]

  plus() {
    this.showStuff()
    this.hideStuff()

  }

  save() {
    $(this.saveTarget).addClass('disabled')
    $('#sendgrid-marketing-lists-index-bar-form')[0].dispatchEvent(new CustomEvent('submit', {bubbles: true}))
  }

  showStuff() {
    $(this.formTarget).addClass('show')
  }

  hideStuff() {
    $(this.plusTarget).removeClass('show')
    $(this.searchTarget).removeClass('show')
    $(this.searchBtnTarget).removeClass('show')
    $(this.paginationTarget).removeClass('show')
  }

}
