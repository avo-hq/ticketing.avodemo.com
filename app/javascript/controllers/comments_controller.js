import { Controller } from '@hotwired/stimulus'

export default class extends Controller {
  static targets = [ "textArea", "form", "submitButton" ]

  connect() {
    this.submitButtonTarget.onclick = (event) => {
      event.preventDefault()
      this.submit()
      event.stopPropagation()
    }

    this.textAreaTarget.onkeydown = (event) => {
      if (event.keyCode == 13) {
        event.preventDefault()
        this.submit()
      }
    }
  }

  submit() {
    this.formTarget.requestSubmit()
    this.textAreaTarget.value = ''
  }
}