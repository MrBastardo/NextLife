extends Button

signal Evento_Terminado

@onready var ControladorEvento = $".."
@onready var Reproductor = $"../Reproductor"
@onready var TimerContador = $"../Timer"

enum EstadosEvento {Ninguno,Terminar,Completado}
var EstadoActualEvento = EstadosEvento.Ninguno

var TraduccionTerminar = ""
var TraduccionCompletado = ""
var AdvertenciaEvento = ""

func _inicializar_interfaz():
	$"../CancelarEvento".pressed.connect(_cancelar_evento)
	TimerContador.timeout.connect(_cancelar_evento)
	pressed.connect(_habito_terminado)
	
	
	$"../Habito".text = ControladorEvento.Recurso.Que
	Reproductor.stream = load(ControladorEvento.Recurso.Senal)
	Reproductor.stream.loop = true
	Reproductor.play()
	EstadoActualEvento = EstadosEvento.Terminar
	_estado_evento()
	$".."._inicializar_idioma()
	
func _cancelar_evento():
	ControladorEvento.queue_free()
	get_tree().change_scene_to_file("res://ESCENAS/Inicio/Inicio.tscn")
	
func _process(delta: float) -> void:
	_estado_evento()
	
func _estado_evento():
	match EstadoActualEvento:
		EstadosEvento.Ninguno : pass
		
		EstadosEvento.Terminar:
			text = TraduccionTerminar
			$"../Contador".text = AdvertenciaEvento + str(int(TimerContador.time_left))
			
		EstadosEvento.Completado:
			text = TraduccionCompletado
			disabled = true
			_habito_completado()
			set_process(false)
			
func _habito_terminado():
	EstadoActualEvento = EstadosEvento.Completado
	_estado_evento()
	
func _habito_completado():
	Reproductor.stream = load("res://1RECURSOS/SONIDOS/RECOMPENSA/universfield-level-up-08-402152.mp3")
	Reproductor.stream.loop =  false
	Reproductor.play()
	emit_signal("Evento_Terminado")
	await Reproductor.finished
	_cancelar_evento()
