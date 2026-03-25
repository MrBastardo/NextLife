extends Node

signal Actualizar_Lenguaje
var Lenguaje = null
var EscenaActual : String = ""

func _ready() -> void:
	get_tree().scene_changed.connect(_agregar_escena_actual)
	_agregar_escena_actual()
	_agregar_lenguaje()
	
func _agregar_escena_actual():
	EscenaActual = get_tree().current_scene.scene_file_path.get_file().get_basename()
	emit_signal("Actualizar_Lenguaje")
	
func _agregar_lenguaje():
	var Configuracion = ServicioRecursos._cargar_configuracion()
	var RutaLenguaje = "res://1RECURSOS/LENGUAJES/" + Configuracion.Lenguaje + ".gd"
	Lenguaje = load(RutaLenguaje).new()
	emit_signal("Actualizar_Lenguaje")
	
func _obtener_traduccion(Clave) -> String:
	var DicTraducciones = Lenguaje.Traducciones[EscenaActual]
	return DicTraducciones.get(Clave, "Clave Incorrecta")
	
