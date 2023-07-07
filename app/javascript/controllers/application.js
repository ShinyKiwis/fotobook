import { Application } from "@hotwired/stimulus"
import ToastController from "./toast_controller.js"

const application = Application.start()

// Configure Stimulus development experience
application.debug = false
window.Stimulus   = application

export { application }
