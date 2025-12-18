extends Button

func _ready() -> void:
	pressed.connect(_on_pressed)
	SistemaSkip.skip_activado.connect(_on_skip_activado)
	SistemaSkip.skip_desactivado.connect(_on_skip_desactivado)
	
	actualizar_apariencia()

func _on_pressed() -> void:
	SistemaSkip.alternar_skip()
	
func _on_skip_activado():
	actualizar_apariencia()

func _on_skip_desactivado():
	actualizar_apariencia()

func actualizar_apariencia():
	if SistemaSkip.esta_activo():
		text = "⏸️ Detener"
		modulate = Color(1.0, 0.6, 0.6)
	else:
		text = "⏩ Skip"
		modulate = Color.WHITE
