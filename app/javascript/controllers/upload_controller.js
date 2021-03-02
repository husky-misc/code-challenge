import {
  Controller
} from "stimulus"

export default class extends Controller {
  static targets = ["filename", "fileInput", "uploadButton"]

  get fileInput() {
    return this.fileInputTarget.value
  }

  get filename() {
    return this.filenameTarget
  }

  get uploadButton() {
    return this.uploadButtonTarget
  }

  showFilename() {
    this.filename.innerHTML = this.fileInput
    this.uploadButton.disabled = false
  }
}
