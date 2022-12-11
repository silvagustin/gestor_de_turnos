Gestor de turnos
================

Stack
-----

- Ruby version: 3.0.2
- Rails version: 7.0.4
- DB: PostgreSQL

Instalación
-----------

1. Abra una terminal desde su equipo.
2. Clone el repositorio.
3. Posiciónese dentro del directorio de la aplicación y corra `bundle install` para instalar todas las dependencias necesarias para correr la aplicación.
4. Corra `rails db:setup` para que se cree la base de datos y posteriormente se ejecute el archivo de `seeds.rb`.
5. Para iniciar la aplicación corra `rails s`.
6. Abra un navegador y visite el sitio `localhost:3000`.
7. Puede registrarse como `Cliente` o utilizar alguna de las cuentas creadas:
    - email: `administrador_X@email.com`, siendo X los valores 0 y 1.
    - email: `personal_bancario_X@email.com`, siendo X los valores enteros comprendidos entre 0 y 4.
    - email: `cliente_X@email.com`, siendo X los valores enteros comprendidos entre 0 y 9.
    - password para todos los casos: `123123123`.

Features
--------

### Gestión de sucursales
El sistema debe permitir gestionar las sucursales del banco:
- [x] Dar de alta una sucursal.
- [x] Modificar una sucursal existente.
- [x] Visualizar una lista de todas las sucursales existentes.
- [x] Visualizar la información completa de una sucursal, incluidos sus **horarios de atención**.
- [x] Eliminar una sucursal, siempre y cuando **no tenga turnos pendientes de ser atendidos**.

### Gestión de horarios
- [x] Deberán permitir definir distintos horarios de atención para distintos días hábiles (lunes a viernes de 9 a 15 hs). Para simplificar la lógica, se puede asumir que por día de la semana se definirá un único rango horario de atención.

### Gestión de turnos
- [x] Los usuarios tendrán una identificación (puede ser nombre de usuario o correo electrónico), una contraseña y un rol.

Los roles posibles son:
- Administrador, puede:
  - [x] Visualizar los datos de su perfil de usuario
  - [x] Modificar su contraseña
  - [x] Gestionar todas las sucursales
  - [x] Gestionar los horarios de atención de todas las sucursales
  - [x] Gestionar todos los usuarios

- Personal bancario (deberá tener una sucursal asignada), puede:
  - [x] Visualizar los datos de su perfil de usuario
  - [x] Modificar su contraseña
  - [x] Visualizar la información de cualquier sucursal
  - [x] Consultar y atender turnos de su sucursal (no puede acceder a ningún tipo de operación de los turnos de otras sucursales distintas de la propia). Al atender un turno, le deberá cargar al mismo un comentario que indique el resultado de la atención (requerido), y se cambiará el estado del turno a `atendido`, guardando la información que indique qué usuario `Personal bancario` fue el que atendió el turno
  - [x] Visualizar la información de los usuarios con rol `Cliente` (no puede acceder a ningún tipo de operación de los usuarios con rol `Administrador` o `Personal bancario`)

- Cliente, puede:
  - [x] Visualizar los datos de su perfil de usuario
  - [x] Modificar su contraseña
  - [x]   Solicitar un turno para ser atendido en una sucursal (seleccionando la sucursal, el día y el horario de atención, y un motivo de la solicitud). Al solicitar un turno, el mismo deberá quedar en estado `pendiente`.
  - [x] Modificar un turno propio con estado `pendiente`, lo cual puede o bien cambiar el estado del mismo a `cancelado`, o bien eliminarlo por completo del sistema. Cualquiera sea el mecanismo de cancelación que elijas, el turno cancelado no deberá aparecer más en ninguna parte del sistema
  - [x] Visualizar los propios turnos (pasados y futuros), en los cuales podrá ver la información referente a la atención (qué usuario atendió el turno y el comentario de resultado que ingresó) en los turnos que hayan sido atendidos

- [x] Los usuarios con rol `Administrador` y `Personal bancario` solo deberán poder ser creados por un usuario con rol `Administrador`, desde la interfaz de gestión de usuarios; en cambio los usuarios con rol `Cliente` podrán registrarse desde la interfaz pública del sistema.

### Gestión de turnos
- [x] Los usuarios `Cliente` podrán solicitar turnos.
- [x] Los usuarios `Personal bancario` podrán atenderlos.