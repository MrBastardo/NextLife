extends AudioStreamPlayer
class_name ClaseReproductorUnico

signal detenido

static var InstanciaActual : ClaseReproductorUnico = null

func _ready() -> void:
	finished.connect(sonido_terminado)

func reproducir_sonido(Ruta: String):
	if InstanciaActual != null and InstanciaActual != self:
		InstanciaActual.stop()
		InstanciaActual.emit_signal("detenido")
	
	InstanciaActual = self
	stream = load(Ruta)
	play()

func sonido_terminado():
	if InstanciaActual == self:
		InstanciaActual = null
