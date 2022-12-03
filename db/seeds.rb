require 'logger'

def crear_clientes
  20.times { FactoryBot.create(:user) }
end

def crear_personal_bancario
  5.times { FactoryBot.create(:user, :personal_bancario) }
end

def crear_administradores
  FactoryBot.create(:user, :administrador, email: 'administrador@email.com')
end

def crear_usuarios
  crear_clientes
  crear_personal_bancario
  crear_administradores
end

def crear_sucursales
  10.times { FactoryBot.create(:sucursal) }
end

###############################################################################
# Main
###############################################################################
logger = Logger.new(STDOUT)

logger.info("Eliminando todos los usuarios de la BD")
User.destroy_all

logger.info("Creando usuarios")
crear_usuarios

logger.info("Eliminando todas las sucursales de la BD")
Sucursal.destroy_all

logger.info("Creando sucursales")
crear_sucursales