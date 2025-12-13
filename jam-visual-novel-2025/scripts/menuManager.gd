extends Control

@export_group("Objects")
@export var options_container: Control  # Asegúrate de asignar MenuOp aquí en inspector
@export var options: Control
@export var controls: Control

@onready var play_button: Button = $VBoxContainer/start
@onready var options_button: Button = $VBoxContainer/op

var change_control := ""
var change_button: Button

func _ready():
	#añadir para sonar musica
	#Audio.music_nivel(-3.0)
	if play_button:
		play_button.grab_focus()

func _on_start_pressed() -> void:
	Audio.pulsar_btn()
	get_tree().change_scene_to_file("res://escenas/game.tscn")

func _on_op_pressed() -> void:
	Audio.pulsar_btn()
	options_container.show_option_menu(true)
	if play_button:
		play_button.focus_mode = Control.FOCUS_NONE
	if options_button:
		options_button.focus_mode = Control.FOCUS_NONE

func _on_exit_pressed() -> void:
	Audio.pulsar_btn() #Audio aqui porue en la variable le metiste Audio jaja pringada
	await options_container.show_option_menu(false)
	if play_button:
		play_button.focus_mode = Control.FOCUS_ALL
	if options_button:
		options_button.focus_mode = Control.FOCUS_ALL
		options_button.grab_focus()
	get_tree().quit()

#función para restaurar foco al cerrar menú de opciones
func _on_options_menu_closed():
	if play_button:
		play_button.focus_mode = Control.FOCUS_ALL
	if options_button:
		options_button.focus_mode = Control.FOCUS_ALL
		options_button.grab_focus()  # Restaurar foco en el botón de opciones


func _on_option_button_item_selected(index: int) -> void:
	var game_manager = get_tree().get_root().get_node("Main/GameManager")
	game_manager.change_language(index)
