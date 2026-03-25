extends Node

@onready var InterfazVerificador = $".."

@onready var QueVerificador = $"../QUE"
@onready var CuandoVerificador = $"../CUANDO"
@onready var DondeVerificador = $"../DONDE"

@onready var CheckQue = $"../QUE/Check"
@onready var CheckCuando = $"../CUANDO/Check"
@onready var CheckDonde = $"../DONDE/Check"

@onready var AdvertenciaQue = $"../QUE/Advertencia"
@onready var AdvertenciaCuando = $"../CUANDO/Advertencia"
@onready var AdvertenciaDonde = $"../DONDE/Advertencia"

@onready var GuiaEstado = $"../GuiaEstados"
@onready var GuiaTexto = $"../GuiaEstados/GuiaTexto"
@onready var CerrarGuia = $"../GuiaEstados/Cerrar"

var MensajeQue = ""
var MensajeCuando = "" 
var MensajeDonde = ""

var Validaciones = []

func _inicialiar_interfaz():
	CheckQue.mouse_filter = Control.MOUSE_FILTER_IGNORE
	CheckCuando.mouse_filter = Control.MOUSE_FILTER_IGNORE
	CheckDonde.mouse_filter = Control.MOUSE_FILTER_IGNORE
	
	AdvertenciaQue.pressed.connect(_visible_advertencia.bind("Que"))
	AdvertenciaCuando.pressed.connect(_visible_advertencia.bind("Cuando"))
	AdvertenciaDonde.pressed.connect(_visible_advertencia.bind("Donde"))
	CerrarGuia.pressed.connect(_visible_advertencia.bind("Reset"))
	CerrarGuia.pressed.connect(_invisible_guia)
	$"../GuiaEstados/Modificar".pressed.connect(_resetear_interfaz)
	_resetear_interfaz()
	
func _aparicion():
	for Hijo in $"../../Interfaces".get_children():
		if Hijo is Panel:
			Hijo.cerrar_panel()
			
	InterfazVerificador.visible = true
	await get_tree().create_timer(0.5).timeout
	
	QueVerificador.visible = true
	CheckQue.button_pressed = Validaciones[0]
	AdvertenciaQue.visible = not Validaciones[0]
	
	await get_tree().create_timer(0.5).timeout
	
	CuandoVerificador.visible = true
	CheckCuando.button_pressed = Validaciones[1]
	AdvertenciaCuando.visible = not Validaciones[1]
	
	await get_tree().create_timer(0.5).timeout
	
	DondeVerificador.visible = true
	CheckDonde.button_pressed = Validaciones[2]
	AdvertenciaDonde.visible = not Validaciones[2]
	
	await get_tree().create_timer(0.5).timeout
	if Validaciones == [true,true,true]:
		get_tree().change_scene_to_file("res://ESCENAS/Inicio/Inicio.tscn")
		_resetear_interfaz()
		InterfazVerificador.visible = false
		
func _invisible_guia():
	GuiaEstado.visible = false
	
func _visible_advertencia(Advertencia):
	GuiaEstado.visible = true
	AdvertenciaQue.visible = not Validaciones[0]
	AdvertenciaCuando.visible = not Validaciones[1]
	AdvertenciaDonde.visible = not Validaciones[2]
	
	match Advertencia:
		"Que":
			GuiaTexto.text = MensajeQue
			AdvertenciaQue.visible = false
		"Cuando":
			GuiaTexto.text = MensajeCuando
			AdvertenciaCuando.visible = false
		"Donde":
			GuiaTexto.text = "Nada"
			AdvertenciaDonde.visible = false
		"Reset" : pass
			
func _resetear_interfaz():
	QueVerificador.visible = false
	CuandoVerificador.visible = false
	DondeVerificador.visible = false
	
	InterfazVerificador.visible = false
	
	CheckQue.button_pressed = false
	CheckCuando.button_pressed = false
	CheckDonde.button_pressed = false
	
	AdvertenciaQue.visible = false
	AdvertenciaCuando.visible = false
	AdvertenciaDonde.visible = false
	
	GuiaEstado.visible = false
