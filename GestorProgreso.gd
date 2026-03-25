extends Node

@onready var ControladorProgreso = $".."
@onready var Guardar = $"../Fondo/Guardar"
@onready var Volver = $"../Fondo/Volver"

func _ready() -> void:
	Guardar.pressed.connect(_recopilar_progreso)
	Volver.pressed.connect(func():get_tree().change_scene_to_file("res://ESCENAS/Inicio/Inicio.tscn"))
	
func _recopilar_progreso():
	var Diccionario = {
		"Dias" : $"../InterfazOpciones/InterfazDias/Contenedor/Label".text
	}
	
	for Hijo in $"../InterfazOpciones/InterfazDiasActivos/DiasActivos".get_children():
		var Check = Hijo.get_node("CheckBox")
		if ControladorProgreso.Recurso.DiasSemana.has(Hijo.name):
			ControladorProgreso.Recurso.DiasSemana[Hijo.name] = Check.button_pressed
			
	ServicioRecursos._guardar_recurso(ControladorProgreso.Recurso)
	print(ControladorProgreso.Recurso.DiasSemana)
	
	AdaptadorRecursoHabito._recibir_progreso(Diccionario,$"..".Recurso)
	get_tree().change_scene_to_file("res://ESCENAS/Inicio/Inicio.tscn")
	
