extends Control

func _ready() -> void:
	ServicioLenguaje.Actualizar_Lenguaje.connect(_inicializar_lenguaje)
	_inicializar_escena()
	_inicializar_lenguaje()
	
func _inicializar_escena():
	$InterfazContenedorHabitos._inicializar_habitos()
	_inicializar_configuracion()
	
func _inicializar_configuracion():
	ServicioDispositivo.Devolver_Tiempo.connect($InterfazReloj._mostrar_tiempo)
	$InterfazReloj._inicializar_interfaz()
	$InterfazConfiguracion._incializar_interfaz()
	
func _recibir_recursos_habito() -> Array:
	return ServicioRecursos._obtener_todos_recursos("RecursoHabito")
	
func _recibir_configuracion():
	return ServicioRecursos._cargar_configuracion()
	
func _inicializar_lenguaje():
	$InterfazContenedorHabitos/ContenedorHabitos/Contenedor/Texto.text = ServicioLenguaje._obtener_traduccion("CrearNuevoHabito")
	
	$InterfazConfiguracion/Fondo/CerrarConfiguracion.text = ServicioLenguaje._obtener_traduccion("Cerrar")
	$InterfazConfiguracion/Fondo/GuardarConfiguracion.text = ServicioLenguaje._obtener_traduccion("Guardar")
	
	$InterfazConfiguracion/Fondo/Panel/Lenguaje.text = ServicioLenguaje._obtener_traduccion("Lenguaje")
	$InterfazConfiguracion/Fondo/Panel/FormatoHorario.text = ServicioLenguaje._obtener_traduccion("Formato")
	$"InterfazConfiguracion/Fondo/Panel/FormatoHorario/ContenedorFormatos/12H".text = ServicioLenguaje._obtener_traduccion("12H")
	$"InterfazConfiguracion/Fondo/Panel/FormatoHorario/ContenedorFormatos/24H".text = ServicioLenguaje._obtener_traduccion("24H")
	$InterfazConfiguracion/Fondo/Panel/Lenguaje/ContenedorLenguaje/Ingles.text = ServicioLenguaje._obtener_traduccion("Ingles")
	$"InterfazConfiguracion/Fondo/Panel/Lenguaje/ContenedorLenguaje/Español".text = ServicioLenguaje._obtener_traduccion("Español")
	$InterfazEliminacionHabito/Script.ClaveEliminacion = ServicioLenguaje._obtener_traduccion("ClaveEliminacion")
	$InterfazEliminacionHabito/Panel/EscribirClave.placeholder_text = ServicioLenguaje._obtener_traduccion("ClaveEliminacion")
	$InterfazEliminacionHabito/Panel/Panel/Texto.text = ServicioLenguaje._obtener_traduccion("MensajeEliminacion")
	
	
