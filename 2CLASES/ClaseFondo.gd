extends Panel
class_name ClaseFondo

@export var Abrir : Button
@export var Cerrar : Button
@export var PosicionBotonCerrar : Vector2

static var InstanciaAbierta : ClaseFondo = null

func _ready() -> void:
	Abrir.pressed.connect(abrir_panel)
	Cerrar.pressed.connect(cerrar_panel)
	Cerrar.position = PosicionBotonCerrar
	visible = false
	Cerrar.visible = false

func abrir_panel() -> void:
	if InstanciaAbierta != null and InstanciaAbierta != self:
		InstanciaAbierta.cerrar_panel()
	InstanciaAbierta = self
	visible = true
	Cerrar.position = PosicionBotonCerrar
	Cerrar.visible = true
	Abrir.visible = false
	

func cerrar_panel() -> void:
	if InstanciaAbierta == self:
		InstanciaAbierta = null
	visible = false
	Cerrar.visible = false
	Abrir.visible = true
	
