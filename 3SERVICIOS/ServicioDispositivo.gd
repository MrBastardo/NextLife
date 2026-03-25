extends Node

signal Devolver_Tiempo
var Formato = ""
var DiaActual = ["Domingo","Lunes","Martes","Miercoles","Jueves","Viernes","Sabado"][Time.get_datetime_dict_from_system().weekday]

func _ready() -> void:
	_cargar_formato()
	var Contador = Timer.new()
	Contador.autostart = true
	Contador.wait_time = 0.5
	Contador.timeout.connect(_emitir_tiempo)
	add_child(Contador)
	
func _cargar_formato():
	Formato = ServicioRecursos._cargar_configuracion().FormatoHorario
	
func _emitir_tiempo():
	emit_signal("Devolver_Tiempo",_obtener_tiempo())
	
func _obtener_dia() -> String:
	return DiaActual
	
func _obtener_fecha() -> String:
	var Fecha = Time.get_date_dict_from_system()
	var Dia = str(Fecha.day).pad_zeros(2)
	var Mes = str(Fecha.month).pad_zeros(2)
	var Ano = str(Fecha.year)
	
	return Dia + "/" + Mes + "/" + Ano
	
func _obtener_tiempo() -> String:
	match Formato:
		"12H" : return _obtener_tiempo_12H(true)
		"24H" : return _obtener_tiempo_24H(true)
		_: return "Incorrecto"
		
func _obtener_tiempo_12H(Envio: bool) -> Variant:
	var Tiempo = Time.get_time_dict_from_system()
	var Hora24 = Tiempo.hour
	var Tanda = "AM"
	var Hora12 = Hora24
	
	if Hora24 == 0:
		Hora12 = 12
		Tanda = "AM"
	elif Hora24 == 12:
		Hora12 = 12
		Tanda = "PM"
	elif Hora24 > 12:
		Hora12 = Hora24 - 12
		Tanda = "PM"
	else:
		Tanda = "AM"
		
	if Envio:
		return str(Hora12).pad_zeros(2) + ":" + str(Tiempo.minute).pad_zeros(2) + ":" + str(Tiempo.second).pad_zeros(2) + " " + Tanda
	else:
		return {
			"Hora": Hora12,
			"Minuto": Tiempo.minute,
			"Segundo": Tiempo.second,
			"Tanda": Tanda
		}
		
func _obtener_tiempo_24H(Envio: bool) -> Variant:
	var Tiempo = Time.get_time_dict_from_system()
	
	if Envio:
		return str(Tiempo.hour).pad_zeros(2) + ":" + str(Tiempo.minute).pad_zeros(2) + ":" + str(Tiempo.second).pad_zeros(2)
	else:
		return {
			"Hora": Tiempo.hour,
			"Minuto": Tiempo.minute,
			"Segundo": Tiempo.second
		}
