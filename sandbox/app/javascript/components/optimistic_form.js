class OptimisticForm extends HTMLElement {
  connectedCallback() {
    this.form = this.querySelector('form');
    this.template = this.querySelector('template[response]');
    this.target = document.querySelector('#messages');
    this.form.addEventListener('submit', () => this.#submit());
    this.form.addEventListener("turbo:submit-end", () => this.#reset())
  }

  #submit() {
    if (!this.form.checkValidity()) return;

    const formData = new FormData(this.form);
    const optimisticElement = this.#render(formData);
    this.target.prepend(optimisticElement);
  }

  #render(formData) {
    const element = this.template.content.cloneNode(true).firstElementChild;

    element.id = 'optimistic-message';

    for(const [name, value] of formData.entries()) {
      const field = element.querySelector(`[data-field="${name}"]`);
      if (field) field.textContent = value;
    }
    return element;
  }

  #reset() {
    this.form.reset();
  }
}

customElements.define('optimistic-form', OptimisticForm);
