extends Control

var Recurso : RecursoHabito = null

func _recibir_recurso(RecursoRef):
	ServicioLenguaje._agregar_escena_actual()
	Recurso = RecursoRef
	$HistorialHabitoActual._inicializar_interfaz()
	_inicializar_idioma()
	
func _inicializar_idioma():
	$InterfazOpciones/InterfazDiasActivos/DiasActivos/Lunes/Texto.text = ServicioLenguaje._obtener_traduccion("Lunes")
	$InterfazOpciones/InterfazDiasActivos/DiasActivos/Martes/Texto.text = ServicioLenguaje._obtener_traduccion("Martes")
	$InterfazOpciones/InterfazDiasActivos/DiasActivos/Miercoles/Texto.text = ServicioLenguaje._obtener_traduccion("Miercoles")
	$InterfazOpciones/InterfazDiasActivos/DiasActivos/Jueves/Texto.text = ServicioLenguaje._obtener_traduccion("Jueves")
	$InterfazOpciones/InterfazDiasActivos/DiasActivos/Viernes/Texto.text = ServicioLenguaje._obtener_traduccion("Viernes")
	$InterfazOpciones/InterfazDiasActivos/DiasActivos/Sabado/Texto.text = ServicioLenguaje._obtener_traduccion("Sabado")
	$InterfazOpciones/InterfazDiasActivos/DiasActivos/Domingo/Texto.text = ServicioLenguaje._obtener_traduccion("Domingo")

	$InterfazOpciones/InterfazDias/Contenedor/Texto.text = ServicioLenguaje._obtener_traduccion("Dias")
