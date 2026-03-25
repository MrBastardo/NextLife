extends LineEdit
class_name ClaseEditorTexto

@export_enum("Bloqueado","Interactuable") var Interaccion
@export var Editable : bool
@export var TextoMaximo : int

@export var PermitirTexto : bool

func _ready() -> void:
	text_changed.connect(_escribiendo_texto)
	editable = Editable
	max_length = TextoMaximo
	selecting_enabled = false
	context_menu_enabled = false
	
	match Interaccion:
		0 : focus_mode = FOCUS_NONE
		1 : focus_mode = FOCUS_ALL
		
func _escribiendo_texto(NuevoTexto: String) -> void:
	
	if PermitirTexto:
		var PosicionCursor = caret_column
		var Filtrado = ""
		var MayusculasEncontradas = 0
		var EspacioPrevio = false
		var PrimerCaracter = true
		
		for Caracter in NuevoTexto:
			if PrimerCaracter:
				if Caracter == " ":
					continue
				PrimerCaracter = false
				
			if Caracter == " ":
				if EspacioPrevio:
					continue
				EspacioPrevio = true
				Filtrado += Caracter
				continue
			else:
				EspacioPrevio = false
				
			if Caracter.to_lower() != Caracter.to_upper():
				if Caracter == Caracter.to_upper() and Caracter != Caracter.to_lower():
					if MayusculasEncontradas == 0:
						Filtrado += Caracter
						MayusculasEncontradas += 1
				else:
					Filtrado += Caracter
					
		if text != Filtrado:
			text = Filtrado
			caret_column = min(PosicionCursor, text.length())
		_ajustar_tamano()
		
func _ajustar_tamano() -> void:
	var TamanoTexto = get_theme_font("font").get_string_size(text)
	custom_minimum_size.x = TamanoTexto.x + 10
	
