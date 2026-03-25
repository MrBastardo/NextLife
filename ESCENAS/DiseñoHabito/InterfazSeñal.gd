extends Node

@onready var ContenedorSenales = $"../Desplazador/Contenedor"
@onready var InterfazSenal = $".."
@onready var Senal = $"../../../HABITO/SEÑAL/Señal"
@onready var Check = $"../../../HABITO/SEÑAL/CheckBox"

func _inicializar_interfaz():
	_instanciar_sonidos()
	Check.mouse_filter = Check.MOUSE_FILTER_IGNORE
	Senal.visible = false
	
func _instanciar_sonidos():
	var EscenaInterfazSenal = preload("res://ESCENAS/DiseñoHabito/InstInterfazSeñal.tscn")
	for Sonido in _obtener_sonidos():
		var InstSenal = EscenaInterfazSenal.instantiate()
		InstSenal._recibir_sonido(Sonido)
		InstSenal.Emitir_Senal.connect(_colocar_sonido)
		InstSenal.Quitar_Senal.connect(_quitar_sonido)
		
		InterfazSenal.visibility_changed.connect(_cambio_visibilidad)
		ContenedorSenales.add_child(InstSenal)
		
func _colocar_sonido(RutaSonido):
	Senal.text = RutaSonido
	Check.button_pressed = true
	
func _quitar_sonido():
	Senal.text = ""
	Check.button_pressed = false
	
func _cambio_visibilidad():
	if not InterfazSenal.is_visible_in_tree():
		for Hijo in ContenedorSenales.get_children():
			if Hijo.has_method("_resetear_sonido"):
				Hijo._resetear_sonido()
				
func _obtener_sonidos() -> Array:
	var Carpeta = DirAccess.open("res://1RECURSOS/SONIDOS/")
	var ListaSonidos : Array = []
	
	Carpeta.list_dir_begin()
	var Archivo = Carpeta.get_next()
	
	while Archivo != "":
		if not Carpeta.current_is_dir():
			if Archivo.ends_with(".mp3") or Archivo.ends_with(".wav") or Archivo.ends_with(".ogg"):
				var Ruta = "res://1RECURSOS/SONIDOS/" + Archivo
				ListaSonidos.append(Ruta)
		Archivo = Carpeta.get_next()
	
	Carpeta.list_dir_end()
	return ListaSonidos
