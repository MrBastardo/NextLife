extends HBoxContainer

signal Eliminar_Habito
@onready var Habito = $Habito
var Recurso : RecursoHabito = null

func _recibir_recurso(RecursoRef):
	
	$Eliminar.pressed.connect(_eliminar_habito)
	$Habito.pressed.connect(_transferir_escena_progreso)
	Recurso = RecursoRef
	call_deferred("_inicializar_interfaz")
	
func _transferir_escena_progreso():
	var Progreso = preload("res://Progreso.tscn").instantiate()
	var EscenaActual = get_tree().current_scene
	get_tree().root.add_child(Progreso)
	get_tree().current_scene = Progreso
	Progreso._recibir_recurso(Recurso)
	EscenaActual.queue_free()
	
func _inicializar_interfaz():
	$CheckBox.mouse_filter = Control.MOUSE_FILTER_IGNORE
	Habito.add_theme_font_size_override("font_size", 12)
	
	_colocar_estado()
	
	Habito.text = "%s %s %s %s %s" % [
		Recurso.Que,
		Recurso.Cuando["Complemento"],
		Recurso.Cuando["Cuando"],
		Recurso.Donde["Complemento"],
		Recurso.Donde["Donde"]
	]
	
func _colocar_numero(Numero):
	$Numero.text = "#" + str(Numero)
	
func _eliminar_habito():
	emit_signal("Eliminar_Habito",get_path(),Recurso)
	
func _colocar_estado():
	var Boton = $EstadoHabito
	var Estilo = StyleBoxFlat.new()
	
	match Recurso.EstadoActualHabito:
		0: Estilo.bg_color = Color(0.5, 0.5, 0.5)
		1: Estilo.bg_color = Color(1, 0, 0)
		2: Estilo.bg_color = Color(1.0, 0.157, 0.0, 1.0)
		3: Estilo.bg_color = Color(0, 1, 0)
		4: Estilo.bg_color = Color(0.5, 0, 0.5)
		5: Estilo.bg_color = Color(0, 0, 1)
	
	Estilo.corner_radius_top_left = 10
	Estilo.corner_radius_top_right = 10
	Estilo.corner_radius_bottom_left = 10
	Estilo.corner_radius_bottom_right = 10
	Boton.custom_minimum_size = Vector2(8, 20)
	
	for Estado in ["normal", "hover", "pressed", "disabled", "focus"]:
		Boton.add_theme_stylebox_override(Estado, Estilo)
