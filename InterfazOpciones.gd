extends Panel

@onready var InterfazDias = $InterfazDias
@onready var InterfazDiasSemana = $InterfazDiasActivos
@onready var BotonDias = $Dias
@onready var BotonSemana = $Semana

func _ready() -> void:
	BotonDias.pressed.connect(_visible_contenedor.bind("Dia"))
	BotonSemana.pressed.connect(_visible_contenedor.bind("Semana"))

func _visible_contenedor(Parametro):
	InterfazDias.visible = false
	InterfazDiasSemana.visible = false
	
	BotonDias.disabled = false
	BotonSemana.disabled = false
	
	match Parametro:
		"Dia":
			InterfazDias.visible = true
			BotonDias.disabled = true
		
		"Semana":
			InterfazDiasSemana.visible = true
			BotonSemana.disabled = true
			
