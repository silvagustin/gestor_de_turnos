module UserHelper
  def opciones_sucursales
    Sucursal.all.map { |s| [s.nombre, s.id] }
  end

end