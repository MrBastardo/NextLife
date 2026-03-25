extends Button

@onready var ControladorInicio = $".."
@onready var Lenguaje = $Fondo/Panel/Lenguaje
@onready var Formato = $Fondo/Panel/FormatoHorario

@onready var ContenedorLenguaje = $Fondo/Panel/Lenguaje/ContenedorLenguaje
@onready var ContenedorFormato = $Fondo/Panel/FormatoHorario/ContenedorFormatos

func _incializar_interfaz():
	pressed.connect(_visible_configuracion)
	Lenguaje.pressed.connect(_visible_parametro.bind("Lenguaje"))
	Formato.pressed.connect(_visible_parametro.bind("Formato"))
	$Fondo/CerrarConfiguracion.pressed.connect(_resetear_interfaz)
	
	_inicializar_configuracion()
	
func _resetear_interfaz():
	$Fondo.visible = false
	_visible_parametro("Nada")
	
func _visible_configuracion():
	$Fondo.visible = true
	
func _visible_parametro(Parametro):
	ContenedorLenguaje.visible = false
	ContenedorFormato.visible = false
	Lenguaje.disabled = false
	Formato.disabled = false
	
	_inicializar_configuracion()
	
	match Parametro:
		"Lenguaje" :
			ContenedorLenguaje.visible = true
			Lenguaje.disabled = true
		"Formato" :
			ContenedorFormato.visible = true
			Formato.disabled = true
		"Nada" : pass
			
func _inicializar_configuracion():
	var Configuracion = ControladorInicio._recibir_configuracion()
	
	for Hijo in ContenedorLenguaje.get_children():
		if Hijo.name == Configuracion.Lenguaje:
			Hijo.button_pressed = true
			
	for Hijo in ContenedorFormato.get_children():
		if Hijo.name == Configuracion.FormatoHorario:
			Hijo.button_pressed = true
			
