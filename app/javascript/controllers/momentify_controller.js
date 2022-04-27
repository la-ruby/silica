import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  connect() {
    if ($(this.element).data('iso8601').length > 0) {
      this.element.textContent = "Hello World!"

      if (moment().diff(  moment($(this.element).data('iso8601'))   , 'hours') > 24) {
        this.element.textContent = moment($(this.element).data('iso8601')).calendar()
      } else {
        this.element.textContent = moment($(this.element).data('iso8601')).fromNow()
      }

    }
  }
}
