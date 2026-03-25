extends Control

func _ready() -> void:
	ServicioLenguaje.Actualizar_Lenguaje.connect(_inicializar_lenguaje)
	_inicializar_escena()
	
func _inicializar_escena():
	$Interfaces/InterfazSeñal/Script._inicializar_interfaz()
	$Interfaces/InterfazCuando/Script._inicializar_interfaz()
	$InterfazVerificador/Script._inicialiar_interfaz()
	
func _recibir_configuracion() -> RecursoConfiguracion:
	return ServicioRecursos._cargar_configuracion()
	
func _inicializar_lenguaje():
	$Fondo/Volver.text = ServicioLenguaje._obtener_traduccion("Volver")
	$Fondo/Guardar.text = ServicioLenguaje._obtener_traduccion("Guardar")
	
	$"HABITO/SEÑAL/Texto".text = ServicioLenguaje._obtener_traduccion("SEÑAL")
	$HABITO/QUE/Texto.text = ServicioLenguaje._obtener_traduccion("QUE")
	$HABITO/CUANDO/Texto.text = ServicioLenguaje._obtener_traduccion("CUANDO")
	$HABITO/DONDE/Texto.text = ServicioLenguaje._obtener_traduccion("DONDE")
	
	$HABITO/QUE/Que.placeholder_text = ServicioLenguaje._obtener_traduccion("Accion")
	$HABITO/CUANDO/Cuando.placeholder_text = ServicioLenguaje._obtener_traduccion("Tiempo")
	$HABITO/DONDE/Donde.placeholder_text = ServicioLenguaje._obtener_traduccion("Lugar")
	
	$"HABITO/SEÑAL/Abrir".text = ServicioLenguaje._obtener_traduccion("Agregar")
	$HABITO/CUANDO/Abrir.text = ServicioLenguaje._obtener_traduccion("Abrir")
	
	$InterfazVerificador/QUE/Texto.text = ServicioLenguaje._obtener_traduccion("QUE")
	$InterfazVerificador/CUANDO/Texto.text = ServicioLenguaje._obtener_traduccion("CUANDO")
	$InterfazVerificador/DONDE/Texto.text = ServicioLenguaje._obtener_traduccion("DONDE")
	
	$InterfazVerificador/GuiaEstados/Modificar.text = ServicioLenguaje._obtener_traduccion("Modificar")
	$InterfazVerificador/GuiaEstados/Cerrar.text = ServicioLenguaje._obtener_traduccion("Cerrar")
	
	$InterfazVerificador/Script.MensajeQue = ServicioLenguaje._obtener_traduccion("MensajeQue")
	$InterfazVerificador/Script.MensajeCuando = ServicioLenguaje._obtener_traduccion("MensajeCuando")
	$InterfazVerificador/Script.MensajeDonde = ServicioLenguaje._obtener_traduccion("MensajeDonde")
