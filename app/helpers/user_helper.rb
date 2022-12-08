module UserHelper
  def roles_seleccionables
    User.rols.reject { |rol| rol == 'cliente' }
  end

end