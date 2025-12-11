class ClickCounter extends HTMLElement {
  connectedCallback() {
    this.count = 0;

    this.addEventListener('click', () => this.#increment());
  }

  #increment() {
    this.count ++;

    this.querySelector('span').textContent = this.count;
  }
}
customElements.define('click-counter', ClickCounter);
