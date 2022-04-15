import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  connect() {
    let myModalEl = document.querySelector('#gallery-dialog')
    let modal = bootstrap.Modal.getOrCreateInstance(myModalEl)
    modal.show()
  }
}
