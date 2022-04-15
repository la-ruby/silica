import { Controller } from "@hotwired/stimulus"
import AutoNumeric from 'autonumeric'

export default class extends Controller {
  static targets = [ "sum", "part_a", "part_b", "part_c", "part_d", "label", "percentage" ]

  connect() {
    this.recalculate()
  }

  toggle(event) {
    let autonumericOptions = { currencySymbol : '$', allowDecimalPadding: false, showWarnings: false }
    if (event.currentTarget.checked) {
      $(this.labelTarget).removeClass('d-none')

      $('#addon-1647449466').addClass('d-none')
      $('#addon-1647449471').addClass('d-none')

      window.apollo_1644949508.remove()
       $('#submission_service_fee').val(  $('#submission_service_fee').val().replace(/\$|,/g, '')   )
    } else {
      $(this.labelTarget).addClass('d-none')

      $('#addon-1647449466').removeClass('d-none')
      $('#addon-1647449471').removeClass('d-none')


      window.apollo_1644949508 = new AutoNumeric('#submission_service_fee', autonumericOptions)
    }
    this.recalculate()
  }

  recalculate() {
    console.log("recalculating")
    let autonumericOptions = { currencySymbol : '$', allowDecimalPadding: false }
    let v = "0.0"
    let existed = false
    if ($(this.part_aTarget).val() != undefined && $(this.part_aTarget).val().length > 0) {
      existed = true
      v = (parseFloat(v) + parseFloat(
        AutoNumeric.unformat($(this.part_aTarget).val(), autonumericOptions)
      )).toString()
    }

    // needs refactoring
    if (this.percentageTarget.checked) {
      if ($(this.part_bTarget).val() != undefined && $(this.part_bTarget).val().length > 0) {
        existed = true
        let pct = parseFloat(
	    AutoNumeric.unformat($(this.part_aTarget).val(), autonumericOptions)
	) /100 * parseFloat(
          $(this.part_bTarget).val()
	)
        if (! isNaN(pct)) {
          v = (parseFloat(v) - pct).toString()
          $(this.labelTarget).html( AutoNumeric.format(pct, autonumericOptions))
	}
      }
    } else {
      if ($(this.part_bTarget).val() != undefined && $(this.part_bTarget).val().length > 0) {
        existed = true
        v = (parseFloat(v) - parseFloat(
                               AutoNumeric.unformat($(this.part_bTarget).val(), autonumericOptions)
                             )).toString()
      }
    }

    if ($(this.part_cTarget).val() != undefined && $(this.part_cTarget).val().length > 0) {
      existed = true
      v = (parseFloat(v) - parseFloat(
            AutoNumeric.unformat($(this.part_cTarget).val(), autonumericOptions)
          )).toString()
    }
    if ($(this.part_dTarget).val() != undefined && $(this.part_dTarget).val().length > 0) {
      existed = true
      v = (parseFloat(v) - parseFloat(
        AutoNumeric.unformat($(this.part_dTarget).val(), autonumericOptions)
      )).toString()
    }
    if (existed) {
      if (isNaN(v)) {
	console.log("was NaN")
      } else {
        $(this.sumTarget).val( AutoNumeric.format(v, autonumericOptions))
      }

    } else {
      $(this.sumTarget).val("")
    }
  }
}
