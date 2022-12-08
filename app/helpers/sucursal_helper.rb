module SucursalHelper
  def sucursales_seleccionables
    Sucursal.all.map { |s| [s.nombre, s.id] }
  end

end