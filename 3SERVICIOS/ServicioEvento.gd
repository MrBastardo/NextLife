extends Node

var Depurar = false

func _ready() -> void:
	if Depurar:
		await get_tree().process_frame
		for Recurso : RecursoHabito in ServicioRecursos._obtener_todos_recursos("RecursoHabito"):
			_disparar_evento(Recurso)
		return
		
	var Contador = Timer.new()
	Contador.autostart = true
	Contador.wait_time = 1.0
	Contador.timeout.connect(_actualizar_evento)
	add_child(Contador)
	
func _actualizar_evento():
	var Tiempo = ServicioDispositivo._obtener_tiempo_24H(false)
	
	var Hora = Tiempo["Hora"]
	var Minuto = Tiempo["Minuto"]
	var Segundo = Tiempo["Segundo"]
	
	if Segundo != 0:
		return
		
	for Recurso : RecursoHabito in ServicioRecursos._obtener_todos_recursos("RecursoHabito"):
		if Recurso.Cuando["Hora"] == Hora and  Recurso.Cuando["Minuto"] == Minuto:
			if Recurso.EstadoActualHabito == Recurso.EstadosHabito.Activado:
				if get_tree().current_scene.scene_file_path.get_file().get_basename() == "Inicio":
					_disparar_evento(Recurso)
					
func _disparar_evento(Recurso):
	get_tree().current_scene.queue_free()
	var EventoEscena = preload("res://ESCENAS/Evento/Evento.tscn").instantiate()
	get_tree().root.add_child(EventoEscena)
	get_tree().current_scene = EventoEscena
	ServicioLenguaje._agregar_escena_actual()
	EventoEscena._recibir_recurso(Recurso)
	
	
