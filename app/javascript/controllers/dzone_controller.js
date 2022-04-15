import { Controller } from "@hotwired/stimulus"


export default class extends Controller {
  static values = {
    project: String
  }

  connect() {
    $(this.element).addClass('dropzone')
    let that = this

    const dropzone = new Dropzone(
      "div#dzone",
      {
	url: "/kodaks",
	dictDefaultMessage: "<div class='mt-2 text-muted'><i class='fas fa-upload'></i></div>",
        maxFilesize: 4,
        params: function params(files, xhr, chunk) { return { 'project' : that.projectValue }; }
      });
    
  }
}
