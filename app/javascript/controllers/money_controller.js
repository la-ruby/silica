import { Controller } from "@hotwired/stimulus"
import AutoNumeric from 'autonumeric'

export default class extends Controller {
  connect() {
    let autonumericOptions = {
      allowDecimalPadding: false,
      showWarnings : false,
      modifyValueOnWheel: false
    }
    new AutoNumeric(this.element, autonumericOptions);
  }
}
