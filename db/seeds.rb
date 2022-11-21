require 'logger'

def crear_usuarios
  users_attrs = [
    # User 1
    {
      email: "silva.agustinn@gmail.com",
      password: "123123123",
      password_confirmation: "123123123",
      rol: :administrador
    }
  ]

  for user_attrs in users_attrs
    User.create(user_attrs)
  end
end

logger = Logger.new(STDOUT)

logger.info("Eliminando todos los usuarios de la BD")
User.destroy_all

logger.info("Creando usuarios")
crear_usuarios()