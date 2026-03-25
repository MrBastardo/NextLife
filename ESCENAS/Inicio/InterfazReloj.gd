extends Button

func _inicializar_interfaz():
	focus_mode = FOCUS_NONE
	mouse_filter = MOUSE_FILTER_IGNORE
	
func _mostrar_tiempo(Tiempo):
	text = Tiempo
	
