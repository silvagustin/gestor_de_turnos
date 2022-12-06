import { Controller } from "@hotwired/stimulus"

export default class extends Controller {

  static targets = ['rol', 'sucursal'];

  mostrarSucursales() {
    this.sucursalTarget.hidden = this.rolTarget.value != 'personal_bancario';
  }

  connect() {
    this.mostrarSucursales();
  }

}
