extends CheckBox
class_name ClaseCheckBoxUnico

@export var Grupo : String

static var Activos = {}

func _ready() -> void:
	toggled.connect(_al_cambiar)

func _al_cambiar(Estado: bool):
	if not Estado:
		return
	
	if Activos.has(Grupo):
		var Anterior = Activos[Grupo]
		if Anterior != null and Anterior != self:
			Anterior.button_pressed = false
	
	Activos[Grupo] = self
