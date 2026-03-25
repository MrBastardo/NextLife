extends Node

@onready var GuardarConfiguracion = $"../InterfazConfiguracion/Fondo/GuardarConfiguracion"

func _ready() -> void:
	GuardarConfiguracion.pressed.connect(_recopilar_configuracion)
	$"../InterfazEliminacionHabito/Script".Eliminacion_Total.connect(_recopilar_eliminacion)
	
func _recopilar_eliminacion(Ruta,Recurso):
	var Nodo = get_node(Ruta)
	Nodo.queue_free()
	
	ServicioRecursos._eliminar_recurso(Recurso)
	for Hijo in $"../InterfazContenedorHabitos/ContenedorHabitos".get_children():
		if Hijo is HBoxContainer and Hijo.has_method("_colocar_numero"):
			Hijo.queue_free()
			
	await get_tree().create_timer(0.1).timeout
	$"../InterfazContenedorHabitos"._inicializar_habitos()
	
func _recopilar_configuracion():
	var Configuracion = ServicioRecursos._cargar_configuracion()
	
	for Hijo in $"../InterfazConfiguracion/Fondo/Panel/Lenguaje/ContenedorLenguaje".get_children():
		if Hijo.button_pressed == true:
			Configuracion.Lenguaje = Hijo.name
			
	for Hijo in $"../InterfazConfiguracion/Fondo/Panel/FormatoHorario/ContenedorFormatos".get_children():
		if Hijo.button_pressed == true:
			Configuracion.FormatoHorario = Hijo.name
			
			
	ServicioRecursos._guardar_recurso(Configuracion)
	ServicioLenguaje._agregar_lenguaje()
	ServicioDispositivo._cargar_formato()
	$".."._inicializar_configuracion()
	GuardarConfiguracion.disabled = true
	await get_tree().create_timer(1.0).timeout
	GuardarConfiguracion.disabled = false
