###############################################################################
# Metodos auxiliares
###############################################################################
def crear_sucursales_con_horarios
  10.times do
    sucursal = FactoryBot.create(:sucursal, :con_horarios_habilitados)
  end
end

def crear_clientes
  10.times do |i|
    FactoryBot.create(:user, :cliente, email: "cliente_#{i}@email.com")
  end
end

def crear_personal_bancario
  5.times do |i|
    personal_bancario_user = FactoryBot.build(:user, :personal_bancario, email: "personal_bancario_#{i}@email.com")
    personal_bancario_user.sucursal = Sucursal.all.sample
    personal_bancario_user.save
  end
end

def crear_administradores
  2.times do |i|
    FactoryBot.create(:user, :administrador, email: "administrador_#{i}@email.com")
  end
end

def crear_usuarios
  crear_clientes
  crear_personal_bancario
  crear_administradores
end

def crear_turnos_pendientes
  User.clientes.each do |user|
    Sucursal.all.each do |sucursal|
      FactoryBot.create(:turno, cliente_id: user.id, sucursal_id: sucursal.id)
    end
  end
end

###############################################################################
# Main
###############################################################################
require 'logger'

logger = Logger.new(STDOUT)

logger.info('INICIO: limpieza de la DB')

User.destroy_all
logger.info('--> Usuarios eliminados')

Horario.destroy_all
logger.info('--> Horarios eliminadas')

Turno.destroy_all
logger.info('--> Turnos eliminados')

Sucursal.destroy_all
logger.info('--> Sucursales eliminadas')



logger.info('INICIO: carga de datos en la DB')

crear_sucursales_con_horarios
logger.info('--> Sucursales con horarios creadas')

crear_usuarios
logger.info('--> Usuarios creados')

crear_turnos_pendientes
logger.info('--> Turnos pendientes creados')