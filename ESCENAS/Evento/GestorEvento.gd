extends Node

func _ready() -> void:
	$"../InterfazEstadoEvento".Evento_Terminado.connect(_recopilar_evento)
	
func _recopilar_evento():
	AdaptadorRecursoHabito._actualizar_progreso($"..".Recurso)
	
