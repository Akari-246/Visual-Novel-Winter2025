extends Control

@export_group("Objects")
@export var animacion: AnimationPlayer

func _ready():
	hide()

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
