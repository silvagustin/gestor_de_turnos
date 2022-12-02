module ApplicationHelper
  def fecha_y_hora(datetime)
    datetime.strftime("%I:%M:%S %p - %d/%m/%Y")
  end
end
