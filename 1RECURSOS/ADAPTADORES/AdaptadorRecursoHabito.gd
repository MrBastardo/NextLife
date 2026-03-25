extends Node

func _actualizar_estados():
	for Recurso in ServicioRecursos._obtener_todos_recursos("RecursoHabito"):
		_activar_estado(Recurso)
		
func _activar_estado(Recurso:RecursoHabito):
	var DiaActual = ServicioDispositivo._obtener_dia()
	var Tiempo = ServicioDispositivo._obtener_tiempo_24H(false)
	
	if Recurso.EstadoActualHabito == Recurso.EstadosHabito.Activado:
		if Tiempo["Hora"] > Recurso.Cuando["Hora"] and Tiempo["Minuto"] > Recurso.Cuando["Minuto"]:
			Recurso.EstadoActualHabito = Recurso.EstadosHabito.Incompleto
			
	if Recurso.EstadoActualHabito in [
		Recurso.EstadosHabito.Activado,
		Recurso.EstadosHabito.Desactivado,
		Recurso.EstadosHabito.Ninguno
	]:
		if Recurso.HistorialActualHabito[1] > 0 \
		and Recurso.DiasSemana.has(DiaActual) \
		and Recurso.DiasSemana[DiaActual]:
			Recurso.EstadoActualHabito = Recurso.EstadosHabito.Activado
		else:
			Recurso.EstadoActualHabito = Recurso.EstadosHabito.Desactivado
			
	
	if Recurso.EstadoActualHabito == Recurso.EstadosHabito.Activado:
		if Recurso.HistorialActualHabito[2].size() > 0:
			var Ultimo = Recurso.HistorialActualHabito[2].back()
			if Ultimo[0] == ServicioDispositivo._obtener_fecha():
				print(Ultimo[0] + " " + ServicioDispositivo._obtener_fecha())
				Recurso.EstadoActualHabito = Recurso.EstadosHabito.Completado
				
	ServicioRecursos._guardar_recurso(Recurso)
			
func _recibir_progreso(Diccionario,Recurso:RecursoHabito):
	if Recurso.HistorialActualHabito[1] == 0:
		Recurso.HistorialActualHabito[1] = int(Diccionario["Dias"])
		
	ServicioRecursos._guardar_recurso(Recurso)
	_actualizar_estados()
	
		
func _actualizar_progreso(Recurso:RecursoHabito):
	var Fecha = ""
	var Tiempo = ""
	Fecha = ServicioDispositivo._obtener_fecha()
	Tiempo = ServicioDispositivo._obtener_tiempo()
	var Registro = [Fecha,Tiempo]
	Recurso.HistorialActualHabito[2].append(Registro)
	
	if Recurso.HistorialActualHabito[2].size() >= Recurso.HistorialActualHabito[1] and Recurso.HistorialActualHabito[1] != 0:
		Recurso.HistorialActualHabito[2].clear()
		Recurso.HistorialActualHabito[1] = 0
	
	ServicioRecursos._guardar_recurso(Recurso)
	
	_actualizar_estados()
func _recibir_diccionario(Diccionario) -> Array[bool]:
	for Clave in Diccionario:
		var Valor = Diccionario[Clave]
		if Valor is String:
			Diccionario[Clave] = Valor.strip_edges()
			
	var Hora = int(Diccionario["Cuando"].substr(0, 2))
	var Minuto = int(Diccionario["Cuando"].substr(3, 2))
	var Tanda = ""
	
	if Diccionario["Cuando"].length() > 5:
		Tanda = Diccionario["Cuando"].substr(6, 2)
		if Tanda == "PM" and Hora != 12:
			Hora += 12
		if Tanda == "AM" and Hora == 12:
			Hora = 0
			
	Diccionario["Hora"] = Hora
	Diccionario["Minuto"] = Minuto
	Diccionario["Tanda"] = Tanda
	
	var Validaciones : Array[bool] = [true,true,true]
	
	for Recurso in ServicioRecursos._obtener_todos_recursos("RecursoHabito"):
		if Recurso.Que == Diccionario["Que"]:
			Validaciones[0] = false
		var RecursoCuando = str(Recurso.Cuando["Hora"]).pad_zeros(2) + ":" + str(Recurso.Cuando["Minuto"]).pad_zeros(2)
		var RecursoCuandoActual = str(Diccionario["Hora"]).pad_zeros(2) + ":" + str(Diccionario["Minuto"]).pad_zeros(2)
		if RecursoCuando == RecursoCuandoActual:
			Validaciones[1] = false
			
	if Validaciones == [true,true,true]:
		_crear_habito(Diccionario)
	return Validaciones
	
func _crear_habito(Diccionario):
	var Recurso : RecursoHabito = ServicioRecursos._crear_recurso("RecursoHabito")
	
	Recurso.ClAVE = str(ResourceUID.create_id())
	Recurso.Senal = Diccionario["Senal"]
	Recurso.Que = Diccionario["Que"]
	
	Recurso.Cuando = {
		"Complemento": Diccionario["ComplementoCuando"],
		"Cuando": Diccionario["Cuando"],
		"Hora": Diccionario["Hora"],
		"Minuto": Diccionario["Minuto"],
		"Tanda": Diccionario["Tanda"]
	}
	
	Recurso.Donde = {
		"Complemento": Diccionario["ComplementoDonde"],
		"Donde": Diccionario["Donde"]
	}
	
	var Habito = " ".join([
	Diccionario["Que"],
	Diccionario["ComplementoCuando"],
	Diccionario["Cuando"],
	Diccionario["ComplementoDonde"],
	Diccionario["Donde"]
	])
	
	Recurso.HistorialActualHabito[0] = Habito
	ServicioRecursos._guardar_recurso(Recurso)
	_actualizar_estados()
	
