import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = [ 'plus', 'search', 'searchBtn', 'entry', 'pagination', 'save', 'sortdropdown', 'sort', 'page', 'direction']

  connect() {
    let that = this
    $("#a1648242214")[0].addEventListener("search", function(event) {
      that.submit()
    })

    $(document).on("keydown", "#a1648242214", function(event) {
      if (event.key == "Enter") {
	that.resetPage()
      }
    });

  }

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
    $(this.sortdropdownTarget).removeClass('show')
  }

  search() {
    this.resetPage()
    this.submit()
  }

  resetPage() {
    $(this.pageTarget).val(1)
  }

  sortFirstName() {
    this.resetPage()
    $(this.sortTarget).val('first_name')
    this.submit()
  }

  sortLastName() {
    this.resetPage()
    $(this.sortTarget).val('last_name')
    this.submit()
  }

  sortPhoneMobile() {
    this.resetPage()
    $(this.sortTarget).val('phone_mobile')
    this.submit()
  }

  sortPhoneWork() {
    this.resetPage()
    $(this.sortTarget).val('phone_work')
    this.submit()
  }

  sortEmail() {
    this.resetPage()
    $(this.sortTarget).val('email')
    this.submit()
  }

  sortInvestingLocation() {
    this.resetPage()
    $(this.sortTarget).val('investing_location')
    this.submit()
  }

  sortSendgridCreatedAt() {
    this.resetPage()
    $(this.sortTarget).val('sendgrid_created_at')
    this.submit()
  }

  toggleDirection() {
    if ( $(this.directionTarget).val() == "desc" ) {
      $(this.directionTarget).val('asc')
    } else {
      $(this.directionTarget).val('desc')
    }
    this.submit()
  }

  submit() {
    $('#contact_searches_form')[0].dispatchEvent(new CustomEvent('submit', {bubbles: true}))
  }

  previous() {
    if ( parseInt(  $(this.pageTarget).val(), 10 ) > 1 ) {
      $(this.pageTarget).val(
	parseInt(  $(this.pageTarget).val(), 10 ) - 1
      )
    }
    this.submit()
  }

  next() {
    $(this.pageTarget).val(
      parseInt(  $(this.pageTarget).val(), 10 ) + 1
    )
    this.submit()
  }
}
