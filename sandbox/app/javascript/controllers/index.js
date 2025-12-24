// Import and register all your controllers from the importmap via controllers/**/*_controller
import { application } from "controllers/application"
import { eagerLoadControllersFrom } from "@hotwired/stimulus-loading"
eagerLoadControllersFrom("controllers", application)

function initializeConfirmDialog() {
  Turbo.config.forms.confirm = (message, element, submitter) => {
    const confirmDialog = document.getElementById('turbo-confirm-dialog');
    const confirmMessage = document.getElementById('turbo-confirm-message');
    const confirmButton = confirmDialog?.querySelector('button[value="confirm"]');

    if (!confirmDialog) return Promise.resolve(confirm(message));

    confirmMessage.textContent = message;
    const buttonText = submitter?.dataset?.turboConfirmButton || 'OK';
    confirmButton.textContent = buttonText;

    confirmDialog.showModal();

    return new Promise((resolve) => {
      confirmDialog.addEventListener('close', () => {
        resolve(confirmDialog.returnValue === 'confirm');
      }, { once: true });
    });
  }
}
initializeConfirmDialog();
