module UserHelper
  def roles_seleccionables
    User.rols.reject { |rol| rol == 'cliente' }
  end

  def sucursales_seleccionables
    Sucursal.all.map { |s| [s.nombre, s.id] }
  end

end