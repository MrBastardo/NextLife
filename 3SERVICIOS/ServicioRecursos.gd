extends Node

func _crear_recurso(TipoRecurso) -> Resource:
	match TipoRecurso:
		"RecursoHabito" : return RecursoHabito.new()
	return null
	
func _guardar_recurso(Recurso):
	if Recurso is RecursoHabito:
		DirAccess.make_dir_absolute("user://HABITOS")
		var Ruta = "user://HABITOS/" + Recurso.ClAVE + ".tres"
		ResourceSaver.save(Recurso,Ruta)
		
	if Recurso is RecursoConfiguracion:
		DirAccess.make_dir_absolute("user://CONFIGURACION")
		var Ruta = "user://CONFIGURACION/" + "Configuracion" + ".tres"
		ResourceSaver.save(Recurso, Ruta)
		
func _obtener_todos_recursos(Recurso) -> Array[Resource]:
	var RutaCarpeta = ""
	var ClaseRecurso = null
	var RecursosTotales : Array[Resource] = []
	
	match Recurso:
		"RecursoHabito":
			RutaCarpeta = "user://HABITOS"
			ClaseRecurso = RecursoHabito
		_:
			return []
		
	DirAccess.make_dir_absolute(RutaCarpeta)
	var Carpeta = DirAccess.open(RutaCarpeta)
	
	if Carpeta == null:
		return []
		
	Carpeta.list_dir_begin()
	var Archivo = Carpeta.get_next()
	
	while Archivo != "":
		if not Carpeta.current_is_dir() and Archivo.ends_with(".tres"):
			var Ruta = RutaCarpeta + "/" + Archivo
			var RecursoCargado = load(Ruta)
			if RecursoCargado != null and is_instance_of(RecursoCargado, ClaseRecurso):
				RecursosTotales.append(RecursoCargado)
		Archivo = Carpeta.get_next()
	Carpeta.list_dir_end()
	return RecursosTotales
	
func _cargar_configuracion():
	var RutaCarpeta = "user://CONFIGURACION"
	var RutaArchivo = RutaCarpeta + "/Configuracion.tres"
	
	DirAccess.make_dir_absolute(RutaCarpeta)
	
	if FileAccess.file_exists(RutaArchivo):
		var Recurso = load(RutaArchivo)
		if Recurso != null:
			return Recurso
	
	var Clase = preload("res://1RECURSOS/CLASES/RecursoConfiguracion.gd")
	var Nuevo = Clase.new()
	
	ResourceSaver.save(Nuevo, RutaArchivo)
	return Nuevo
	
func _eliminar_recurso(Recurso:Resource):
	DirAccess.remove_absolute(Recurso.resource_path)
	
	
