extends Node

@onready var ControladorDisenoHabito = $"../../.."
@onready var Cuando = $"../../../HABITO/CUANDO/Cuando"
@onready var Hora = $"../Hora"
@onready var Minuto = $"../Minuto"
@onready  var Tanda = $"../Tanda"

@onready var Colocar = $"../Colocar"
@onready var InterfazCuando = $".."

var TandaActiva = false

func _inicializar_interfaz():
	InterfazCuando.visibility_changed.connect(_procesar)
	Colocar.pressed.connect(_colocar_cuando)
	var Configuracion : RecursoConfiguracion = ControladorDisenoHabito._recibir_configuracion()
	
	if Configuracion.FormatoHorario == "12H":
		TandaActiva = true
		
	if Configuracion.FormatoHorario == "24H":
		Hora.MaximoArriba = 23
		TandaActiva = false
		$"../Tanda".queue_free()
		InterfazCuando.size = Vector2(148.0,103.0)
		InterfazCuando.PosicionBotonCerrar = Vector2(152.0,0.0)
		Colocar.position = Vector2(152.0,34.0)
		
func _colocar_cuando():
	if TandaActiva:
		Cuando.text = Hora.text + ":" + Minuto.text + " " + Tanda.text
		Cuando._ajustar_tamano()
		InterfazCuando.cerrar_panel()
	else:
		Cuando.text = " " + Hora.text + ":" + Minuto.text
		InterfazCuando.cerrar_panel()
		
func _process(_delta: float) -> void:
	if TandaActiva:
		if Hora.text != "00":
			Colocar.disabled = false
		else:
			Colocar.disabled = true
			
func _procesar():
	set_process(InterfazCuando.visible)
	
	if not InterfazCuando.visible:
		Hora._resetear()
		Minuto._resetear()
	if TandaActiva:
		Tanda._resetear()
		
