extends Panel

@onready var ControladorProgreso = $".."
@onready var Contenedor = $ContenedorRegistros/Desplazador/Contenedor
var Contador = 0



func _inicializar_interfaz():
	$HabitoActual.text = ControladorProgreso.Recurso.HistorialActualHabito[0]
	$"../InterfazOpciones/InterfazDias/Contenedor/Label".text = str(ControladorProgreso.Recurso.HistorialActualHabito[1]).pad_zeros(2)
	print(ControladorProgreso.Recurso.DiasSemana)
	
	for Hijo in $"../InterfazOpciones/InterfazDiasActivos/DiasActivos".get_children():
		var Dia  = Hijo.get_node("CheckBox")
		if ControladorProgreso.Recurso.DiasSemana.has(Hijo.name):
			Dia.button_pressed = ControladorProgreso.Recurso.DiasSemana[Hijo.name]
			
	if ControladorProgreso.Recurso.HistorialActualHabito[1] == 0:
		$"../InterfazOpciones/InterfazDias/Contenedor/Aumenta".pressed.connect(_colocar_registro)
		$"../InterfazOpciones/InterfazDias/Contenedor/Disminuye".pressed.connect(_quitar_registro)
	else:
		$"../InterfazOpciones/InterfazDias/Contenedor/Aumenta".disabled = true
		$"../InterfazOpciones/InterfazDias/Contenedor/Disminuye".disabled = true
		
	if ControladorProgreso.Recurso.HistorialActualHabito[1] == 0:
		return
	var Dia = 0
	for Registro in ControladorProgreso.Recurso.HistorialActualHabito[2]:
		var Registros = preload("res://Registros.tscn").instantiate()
		var DiaNodo = Registros.get_node("Dia")
		var Fecha = Registros.get_node("Fecha")
		var Tiempo = Registros.get_node("Tiempo")
		Contenedor.add_child(Registros)
		Dia += 1
		DiaNodo.text = "Dia" +  " " + "#" + str(Dia)
		Fecha.text = Registro[0]
		Tiempo.text = Registro[1]
		
	Contador += Dia
	for I in range(Dia,ControladorProgreso.Recurso.HistorialActualHabito[1]):
		_colocar_registro()
		
func _colocar_registro():
	if Contador == 30:
		return
	var Registros = preload("res://Registros.tscn").instantiate()
	var Dia = Registros.get_node("Dia")
	var Fecha = Registros.get_node("Fecha")
	var Tiempo = Registros.get_node("Tiempo")
	Contador += 1
	Dia.text = "Dia" +  " " + "#" + str(Contador)
	Dia.disabled = true
	Fecha.text = "Fecha"
	Fecha.disabled = true
	Tiempo.text = "Tiempo"
	Tiempo.disabled = true
	Contenedor.add_child(Registros)
	$ContenedorRegistros/Desplazador.scroll_vertical = $ContenedorRegistros/Desplazador.get_v_scroll_bar().max_value
	$"../InterfazOpciones/InterfazDias/Contenedor/Label".text = str(Contador).pad_zeros(2)
	
func _quitar_registro():
	if Contenedor.get_child_count() == 0:
		return
		9
	var Ultimo = Contenedor.get_child(Contenedor.get_child_count() - 1)
	Ultimo.queue_free()
	
	Contador -= 1
	if Contador < 0:
		Contador = 0
	$"../InterfazOpciones/InterfazDias/Contenedor/Label".text = str(Contador).pad_zeros(2)
	
