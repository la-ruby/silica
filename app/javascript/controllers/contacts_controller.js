import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = [ 'plus', 'search', 'searchBtn', 'entry', 'pagination', 'save', 'sort' ]

  plus() {
    this.showStuff()
    this.hideStuff()

  }

  save() {
    $(this.saveTarget).addClass('disabled')
    $('#contacts-entry-form')[0].dispatchEvent(new CustomEvent('submit', {bubbles: true}))
  }

  showStuff() {
    $(this.entryTarget).addClass('show')
  }

  hideStuff() {
    $(this.plusTarget).removeClass('show')
    $(this.searchTarget).removeClass('show')
    $(this.searchBtnTarget).removeClass('show')
    $(this.paginationTarget).removeClass('show')
    $(this.sortTarget).removeClass('show')
  }

  search() {
    $('#contact_searches_form')[0].dispatchEvent(new CustomEvent('submit', {bubbles: true}))
  }
  
  submit() {
    alert('submitting')
  }
}
