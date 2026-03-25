extends Panel

var Recurso = null

func _recibir_recurso(RecursoRef):
	Recurso = RecursoRef
	print(Recurso)
	await get_tree().process_frame
	$InterfazEstadoEvento._inicializar_interfaz()
	
func _inicializar_idioma():
	$InterfazEstadoEvento.TraduccionTerminar = ServicioLenguaje._obtener_traduccion("Terminar")
	$InterfazEstadoEvento.TraduccionCompletado = ServicioLenguaje._obtener_traduccion("Completado")
	$CancelarEvento.text = ServicioLenguaje._obtener_traduccion("Cancelar")
	$InterfazEstadoEvento.AdvertenciaEvento = ServicioLenguaje._obtener_traduccion("AdvertenciaEvento")
	
	
