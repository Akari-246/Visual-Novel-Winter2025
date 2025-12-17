extends Button

var game_manager

func _ready():
	# Obtener el GameManager como padre
	game_manager = get_parent()
	# Conectar solo si no está conectado
	actualizar_apariencia()
	print("⭐ EL BOTÓN ESTÁ FUNCIONANDO")
	pressed.connect(_on_test_pressed)

func _on_test_pressed():
	print("🔘 BOTÓN PRESIONADO - FUNCIONA")
	
func _on_pressed() -> void:
	print("Botón Skip presionado")  # Esto debe aparecer en la consola
	if game_manager:
		game_manager.alternar_skip()
		actualizar_apariencia()

func actualizar_apariencia():
	if game_manager and game_manager.skip_activo:
		text = "Detener"
		modulate = Color(1,0.6,0.6)
	else:
		text = "Skip"
		modulate = Color.WHITE
