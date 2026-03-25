extends Node

signal Eliminacion_Total
var Nodo = null
var Recurso = null
var ClaveEliminacion = "Si"

func _ready() -> void:
	$"../Panel/EscribirClave".text_changed.connect(_escribiendo_clave)
	$"../Panel/EscribirClave/OK".visible = false
	$"../Panel/EscribirClave/OK".pressed.connect(_eliminacion_total)
	$"../Panel/Cerrar".pressed.connect(_resetear_interfaz)
	
func _escribiendo_clave(Texto):
	if Texto == ClaveEliminacion and Texto == $"../Panel/EscribirClave".text:
		$"../Panel/EscribirClave/OK".visible = true
	else:
		$"../Panel/EscribirClave/OK".visible = false
	
func _eliminacion_total():
	emit_signal("Eliminacion_Total",Nodo,Recurso)
	_resetear_interfaz()
	
func _resetear_interfaz():
	Nodo = null
	Recurso = null
	$"..".visible = false
	await get_tree().create_timer(2.0).timeout
	$"../Panel/EscribirClave".text = ""
	$"../Panel/EscribirClave/OK".visible = false
	
