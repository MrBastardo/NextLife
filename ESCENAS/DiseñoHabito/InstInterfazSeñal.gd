extends Control

signal Emitir_Senal
signal Quitar_Senal

@onready var NombreSonido = $NombreSonido
@onready var Reproductor : ClaseReproductorUnico = $Reproductor
@onready var ResetearSonido = $Contenedor/Contenedor/ResetearSonido
@onready var ReproducirSonido = $Contenedor/Contenedor/ReproducirSonido
@onready var Contador = $Contenedor/Contenedor/Label
@onready var SonidoSeleccionado = $CheckBox

const MAX_DURACION = 40.0
var Sonido = null

func _ready() -> void:
	ReproducirSonido.pressed.connect(_reproducir_sonido)
	ResetearSonido.pressed.connect(_resetear_sonido)
	Reproductor.finished.connect(_sonido_terminado)
	Reproductor.detenido.connect(_sonido_detenido)
	
	SonidoSeleccionado.toggled.connect(_emitir_senal)
	
func _emitir_senal(Activado):
	if Activado:
		emit_signal("Emitir_Senal",load(Sonido).resource_path)
	else:
		emit_signal("Quitar_Senal")
		
func _sonido_detenido():
	ReproducirSonido.text = "▶"
	
func _recibir_sonido(RutaSonido):
	Sonido = RutaSonido
	call_deferred("_inicializar_interfaz")

func _inicializar_interfaz():
	var NombreBase = Sonido.get_file().get_basename()
	if NombreBase.length() > 12:
		NombreBase = NombreBase.substr(0, 12)
	NombreSonido.text = NombreBase

func _sonido_terminado():
	ReproducirSonido.text = "▶"
	
func _resetear_sonido():
	Reproductor.stop()
	ReproducirSonido.text = "▶"

func _process(delta: float) -> void:
	if not is_visible_in_tree():
		return
	_mostrar_contador()
	
func _mostrar_contador():
	if Reproductor.stream:
		var TiempoActual = Reproductor.get_playback_position()
		if TiempoActual >= MAX_DURACION:
			Reproductor.stop()
			ReproducirSonido.text = "▶"
			Contador.text = _formatear_tiempo(MAX_DURACION)
		else:
			Contador.text = _formatear_tiempo(TiempoActual)
	else:
		Contador.text = "00:00"
	ResetearSonido.disabled = Contador.text == "00:00"
	
func _reproducir_sonido():
	if Reproductor.playing:
		Reproductor.stream_paused = true
		ReproducirSonido.text = "▶"
	else:
		Reproductor.reproducir_sonido(Sonido)
		ReproducirSonido.text = "II"
		
func _formatear_tiempo(segundos: float) -> String:
	var _Minutos = int(segundos) / 60
	var Segundos = int(segundos) % 60
	return "%02d:%02d" % [_Minutos, Segundos]
