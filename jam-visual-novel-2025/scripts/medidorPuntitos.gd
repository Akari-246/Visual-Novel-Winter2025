extends CanvasLayer

@onready var panel = $Panel
@onready var barra = $Panel/VBoxContainer/BarraPuntitos
@onready var texto = $Panel/VBoxContainer/porcentaje
@onready var nombre_label = $Panel/VBoxContainer/Nombre

var personaje_actual = "mateo"
var confianza_maxima = 100.0
var visible_actualmente = false

func _ready():
	hide()
	if SistemaPuntos:
		SistemaPuntos.puntoNegativo.connect(puntosNegativo)
		SistemaPuntos.puntosCambian.connect(puntosCambia)
	actualizar()

func mostrar_medidor(personaje: String = "mateo"):
	personaje_actual = personaje
	nombre_label.text = personaje.capitalize()
	show()
	visible_actualmente = true
	actualizar()
	
	panel.modulate.a = 0
	var tween = create_tween()
	tween.tween_property(panel, "modulate:a", 1.0, 0.3)

func ocultar_medidor():
	visible_actualmente = false
	
	var tween = create_tween()
	tween.tween_property(panel, "modulate:a", 0.0, 0.3)
	tween.tween_callback(func(): hide())

func actualizar():
	if not visible_actualmente:
		return
	
	var puntos_negativos = SistemaPuntos.obtenerPuntosNegativos()
	var max_negativos = SistemaPuntos.maxPuntos
	
	var porcentaje_negativos = (puntos_negativos / float(max_negativos)) * 100.0
	var confianza_actual = confianza_maxima - porcentaje_negativos
	confianza_actual = clamp(confianza_actual, 0, confianza_maxima)
	
	barra.max_value = confianza_maxima
	barra.value = confianza_actual
	texto.text = str(int(confianza_actual)) + "/" + str(int(confianza_maxima))
	
	actualizar_color_barra(confianza_actual)

func actualizar_color_barra(confianza: float):
	var porcentaje = confianza / confianza_maxima
	
	if porcentaje > 0.7:
		barra.modulate = Color(0.3, 0.8, 0.3)  # Verde
	elif porcentaje > 0.4:
		barra.modulate = Color(0.9, 0.9, 0.3)  # Amarillo
	elif porcentaje > 0.2:
		barra.modulate = Color(0.9, 0.5, 0.2)  # Naranja
	else:
		barra.modulate = Color(0.9, 0.2, 0.2)  # Rojo

func puntosNegativo(_total, _maximo):
	if visible_actualmente:
		actualizar()
		shake_effect()

func puntosCambia(personaje, _cantidad, _total):
	if visible_actualmente and personaje == personaje_actual:
		actualizar()

func shake_effect():
	var original_pos = panel.position
	var tween = create_tween()
	tween.tween_property(panel, "position:x", original_pos.x + 5, 0.05)
	tween.tween_property(panel, "position:x", original_pos.x - 5, 0.05)
	tween.tween_property(panel, "position:x", original_pos.x, 0.05)
