extends Resource
class_name RecursoHabito

@export var ClAVE : String

@export var Senal : String
@export var Que : String

@export var Cuando = {
	"Complemento" = "",
	"Cuando" = "",
	"Hora" = 0,
	"Minuto" = 0,
	"Tanda" = "",
}

@export var Donde = {
	"Complemento" = "",
	"Donde" = "",
}

@export var HistorialActualHabito = ["",0,[]]

enum EstadosHabito {Ninguno,Desactivado,Activado,Completado,Actualizar,Incompleto}
@export var  EstadoActualHabito = EstadosHabito.Ninguno

@export var DiasSemana = {
	"Lunes": false,
	"Martes": false,
	"Miercoles": false,
	"Jueves": false,
	"Viernes": false,
	"Sabado": false,
	"Domingo": false
}
