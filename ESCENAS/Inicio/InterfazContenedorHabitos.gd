extends ScrollContainer

@onready var ControladorInicio = $".."
@onready var Contenedor = $ContenedorHabitos
@onready var CrearHabito = $ContenedorHabitos/Contenedor

func _inicializar_habitos():
	$ContenedorHabitos/Contenedor/CrearHabito.pressed.connect(_cambiar_escena)
	
	var InterfazHabitoEscena = preload("res://ESCENAS/Inicio/InterfazHabito.tscn")
	AdaptadorRecursoHabito._actualizar_estados()
	for Recurso in ControladorInicio._recibir_recursos_habito():
		var Instancia = InterfazHabitoEscena.instantiate()
		Instancia._recibir_recurso(Recurso)
		Instancia.Eliminar_Habito.connect(_paquete)
		Contenedor.add_child(Instancia)
		Contenedor.move_child(CrearHabito,Contenedor.get_child_count() - 1)
	_ordenar_habitos()
	
func _paquete(Nodo,Recurso):
	$"../InterfazEliminacionHabito/Script".Nodo = Nodo
	$"../InterfazEliminacionHabito/Script".Recurso = Recurso
	$"../InterfazEliminacionHabito".visible = true
	
func _cambiar_escena():
	get_tree().change_scene_to_file("res://ESCENAS/DiseñoHabito/DiseñoHabito.tscn")
	
func _ordenar_habitos():
	var ListaDeHabitos = Contenedor.get_children()
	ListaDeHabitos.sort_custom(func(HabitoA, HabitoB):
		var RecursoA = HabitoA.get("Recurso")
		var RecursoB = HabitoB.get("Recurso")
		
		if RecursoA == null or RecursoB == null:
			return false
		
		var TiempoEnMinutosA = RecursoA.Cuando["Hora"] * 60 + RecursoA.Cuando["Minuto"]
		var TiempoEnMinutosB = RecursoB.Cuando["Hora"] * 60 + RecursoB.Cuando["Minuto"]
		
		return TiempoEnMinutosA < TiempoEnMinutosB
	)
	
	for Indice in range(ListaDeHabitos.size()):
		var Habito = ListaDeHabitos[Indice]
		Contenedor.move_child(Habito, Indice)
		
		if Habito.has_method("_colocar_numero"):
			Habito._colocar_numero(Indice + 1)
			
