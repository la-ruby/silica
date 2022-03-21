import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = [ 'zip' ]

  connect() {
    this.initAutocomplete()
  }

  initAutocomplete() {
    var that = this
    var ac1631831975 = new google.maps.places.Autocomplete(
      (document.getElementById('a1631804549')),
      {types: ['geocode'], componentRestrictions: { country: "us" }}
    );
    ac1631831975.addListener('place_changed', function() {
      var place = ac1631831975.getPlace();
      var address = place.address_components;
      var city, state, zip, street_number, route;
      address.forEach(function(component) {
	var types = component.types;
	if (types.indexOf('locality') > -1) {
	  city = component.long_name;
	}
	if (types.indexOf('administrative_area_level_1') > -1) {
	  state = component.short_name;
	}
	if (types.indexOf('route') > -1) {
	  route = component.short_name;
	}
	if (types.indexOf('street_number') > -1) {
	  street_number = component.short_name;
	}
	if (types.indexOf('postal_code') > -1) {
	  zip = component.long_name;
	}
      });
      $('#id1641254485 #project_state').val(state)
      $('#id1641254485 #project_city').val(city)
      $('#id1641254485 #project_zip').val(zip)
      $('#id1641254485 #project_street').val(street_number + ' ' + route)
      $('#segmented-address').removeClass('d-none')
      $('#a1631804549').addClass('d-none')
    })

    // clears when garbage entered
    // https://stackoverflow.com/a/55395323
    $("#a1631804549")[0].addEventListener("change", function(){
      $("#a1631804549")[0].value = ""
    })

    $('#clear-address-button').on('click', function() {
      // reset google cnotrolled field
      $("#a1631804549")[0].value = ''
      $('#id1641254485 #project_state').val('')
      $('#id1641254485 #project_city').val('')
      $('#id1641254485 #project_zip').val('')
      $('#id1641254485 #project_street').val('')
      $('#segmented-address').addClass('d-none')
      $('#a1631804549').removeClass('d-none')
    })
  }
  

}
