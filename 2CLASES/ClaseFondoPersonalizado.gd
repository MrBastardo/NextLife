extends Panel
class_name ClaseFondoPersonalidad

enum TipoColor
{
	Negro,
	Gris,
	Blanco
}

enum TipoBorde
{
	Puntiagudo,
	Redondo
}

@export var ColorFondo : TipoColor
@export var ColorBordeArriba : TipoBorde
@export var ColorBordeAbajo : TipoBorde

func _ready() -> void:
	_aplicar_estilo()

func _aplicar_estilo() -> void:
	var Fondo = _obtener_color(ColorFondo)
	
	var Estilo = StyleBoxFlat.new()
	Estilo.bg_color = Fondo
	
	add_theme_stylebox_override("panel", Estilo)
func _obtener_color(Tipo : TipoColor) -> Color:
	match Tipo:
		TipoColor.Negro:
			return Color.BLACK
		TipoColor.Gris:
			return Color.GRAY
		TipoColor.Blanco:
			return Color.WHITE
		_:
			return Color.WHITE

func _obtener_estilo_borde(Tipo : TipoBorde) -> String:
	match Tipo:
		TipoBorde.Puntiagudo:
			return "square"
		TipoBorde.Redondo:
			return "rounded"
		_:
			return "square"
