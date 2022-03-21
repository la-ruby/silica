import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  connect() {
    let that = this
    $(document).on("apolloSortBy", function(e, field){
      console.log(that.targets)
      let sort_byElement = $(that.element).find('input[name="sort_by"]').first()
      let sort_directionElement = $(that.element).find('input[name="sort_direction"]').first()
      $(sort_byElement).val(field)

      if ( $(sort_directionElement).val() == "asc" ) {
         $(sort_directionElement).val("desc")
      } else if ( $(sort_directionElement).val() == "desc" ) {
        $(sort_directionElement).val("")
      } else {
        $(sort_directionElement).val("asc")
      }
      $('#projects-bar-form')[0].dispatchEvent(new CustomEvent('submit', {bubbles: true}))
    });

  }
}

