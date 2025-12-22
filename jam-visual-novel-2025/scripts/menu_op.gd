extends Control

@export_group("Objects")
@export var animacion: AnimationPlayer
@onready var option_button = $PanelContainer/opciones/TabContainer/idioma/OptionButton

func _ready():
	hide()
	selectorIdiomas()

func show_option_menu(show_menu: bool):
	if show_menu:
		show()
		animacion.play("animacionOpciones")
		$PanelContainer/opciones/exit.grab_focus()
	else:
		animacion.play_backwards("animacionOpciones")
		await animacion.animation_finished
		hide()

func _on_exit_pressed() -> void:
	Audio.pulsar_btn()
	show_option_menu(false)  # Cierra el menú de opciones con animación
	get_parent()._on_options_menu_closed()  #Notifica al menú principal para restaurar foco


func selectorIdiomas():
	if not option_button:
		return
	
	option_button.clear()
	option_button.add_item("Español", 0)
	option_button.add_item("English", 1)
	
	option_button.selected = 0 if IdiomaManager.idioma_actual == "es" else 1
	
	# Conectar señal (si no está conectada ya)
	if not option_button.item_selected.is_connected(_on_idioma_seleccionado):
		option_button.item_selected.connect(_on_idioma_seleccionado)

func _on_idioma_seleccionado(index: int):
	var idiomas := ["es", "en"]
	if index < idiomas.size():
		IdiomaManager.cambiar_idioma(idiomas[index])
		Audio.pulsar_btn()
