extends Node

@onready var Guardar = $"../Fondo/Guardar"

@onready var Senal = $"../HABITO/SEÑAL/Señal"
@onready var Que = $"../HABITO/QUE/Que"
@onready var ComplementoCuando = $"../HABITO/CUANDO/Complemento"
@onready var Cuando = $"../HABITO/CUANDO/Cuando"
@onready var ComplementoDonde = $"../HABITO/DONDE/Complemento"
@onready var Donde = $"../HABITO/DONDE/Donde"

func _ready() -> void:
	Guardar.pressed.connect(_recopilar_escena)
	$"../Fondo/Volver".pressed.connect(_cambiar_escena)
	
func _cambiar_escena():
	get_tree().change_scene_to_file("res://ESCENAS/Inicio/Inicio.tscn")
	
func _process(_delta: float) -> void:
	var TieneSenal = Senal.text != ""
	var TieneQue = Que.text != ""
	var TieneCuando = Cuando.text != ""
	var TieneDonde = Donde.text != ""
	Guardar.disabled = not (TieneQue and TieneCuando and TieneDonde and TieneSenal)

func _recopilar_escena():
	var Diccionario = {
		"Senal": Senal.text,
		"Que": Que.text,
		"ComplementoCuando": ComplementoCuando.text,
		"Cuando": Cuando.text,
		"ComplementoDonde": ComplementoDonde.text,
		"Donde": Donde.text
	}
	$"../InterfazVerificador/Script".Validaciones = AdaptadorRecursoHabito._recibir_diccionario(Diccionario)
	$"../InterfazVerificador/Script"._aparicion()
	
	
	
	
