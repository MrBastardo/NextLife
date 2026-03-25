extends Button
class_name ClaseContador

@export var Aumenta : Button
@export var Disminuye : Button

@export var MaximoArriba : int
@export var MaximoAbajo : int
@export var Tanda : bool

var Valor : int = 0
var AM : bool = true

var ManteniendoAumenta : bool = false
var ManteniendoDisminuye : bool = false
var Velocidad : float = 0.3
var TiempoActual : float = 0.0

func _ready() -> void:
	set_process(true)
	focus_mode = FOCUS_NONE
	mouse_filter = MOUSE_FILTER_IGNORE
	
	Aumenta.button_down.connect(_presiono_aumenta)
	Aumenta.button_up.connect(_suelto_aumenta)
	
	Disminuye.button_down.connect(_presiono_disminuye)
	Disminuye.button_up.connect(_suelto_disminuye)
	
	_actualizar_texto()
	_actualizar_botones()

func _process(delta):
	if ManteniendoAumenta:
		TiempoActual += delta
		if TiempoActual >= Velocidad:
			TiempoActual = 0.0
			Velocidad = max(0.05, Velocidad * 0.9)
			_al_aumentar()
	if ManteniendoDisminuye:
		TiempoActual += delta
		if TiempoActual >= Velocidad:
			TiempoActual = 0.0
			Velocidad = max(0.05, Velocidad * 0.9)
			_al_disminuir()

func _presiono_aumenta():
	ManteniendoAumenta = true
	Velocidad = 0.3
	TiempoActual = 0.0
	_al_aumentar()

func _suelto_aumenta():
	ManteniendoAumenta = false
	Velocidad = 0.3
	TiempoActual = 0.0

func _presiono_disminuye():
	ManteniendoDisminuye = true
	Velocidad = 0.3
	TiempoActual = 0.0
	_al_disminuir()

func _suelto_disminuye():
	ManteniendoDisminuye = false
	Velocidad = 0.3
	TiempoActual = 0.0

func _al_aumentar():
	if Tanda:
		AM = false
	else:
		if Valor < MaximoArriba:
			Valor += 1
	_actualizar_texto()
	_actualizar_botones()

func _al_disminuir():
	if Tanda:
		AM = true
	else:
		if Valor > MaximoAbajo:
			Valor -= 1
	_actualizar_texto()
	_actualizar_botones()

func _actualizar_texto():
	if Tanda:
		text = "AM" if AM else "PM"
	else:
		text = str(Valor).pad_zeros(2)

func _actualizar_botones():
	if Tanda:
		Aumenta.disabled = not AM == true
		Disminuye.disabled = AM == true
	else:
		Aumenta.disabled = Valor >= MaximoArriba
		Disminuye.disabled = Valor <= MaximoAbajo
		
func _resetear():
	Valor = MaximoAbajo
	AM = true
	ManteniendoAumenta = false
	ManteniendoDisminuye = false
	Velocidad = 0.3
	TiempoActual = 0.0
	_actualizar_texto()
	_actualizar_botones()
