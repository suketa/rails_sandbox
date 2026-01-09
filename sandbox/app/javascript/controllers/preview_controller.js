import { Controller } from "@hotwired/stimulus"
import { post } from "@rails/request.js";

// Connects to data-controller="preview"
export default class extends Controller {
  connect() {
  }
  static targets = [ "editorContent" ]
  static values = { url: String }

  show() {
    post(this.urlValue, {
      body: {
        body: this.editorContentTarget.value
      },
      responseKind: "turbo-stream"
    });
  }
}
