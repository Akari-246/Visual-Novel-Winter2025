extends Node2D

# Referencias a nodos
@onready var background: Sprite2D = $Fondo
@onready var discord_screen: CanvasLayer = $DiscordScreen
@onready var discord_panel: Panel = $DiscordScreen/Panel
@onready var messages_container: VBoxContainer = $DiscordScreen/Panel/Mensajes
@onready var info_panel: CanvasLayer = $InfoPanel
@onready var info_label: RichTextLabel = $InfoPanel/Panel/InfoLabel
@onready var close_button: Button = $InfoPanel/Panel/Button
@onready var characters_container: Node2D = $Character

# Recursos de fondos
var backgrounds = {
	"habitacion": "",
	"clase": "",
	"habitacion_hospital": "",
	"negro": ""
}

var bad_ending = false
var dialogue_resource: DialogueResource

func _ready():
	dialogue_resource = load("res://dialogos/inicio.dialogue")
	
	DialogueManager.dialogue_ended.connect(_on_dialogue_ended)
	close_button.pressed.connect(_on_close_info_panel)
	
	# Ocultar elementos al inicio
	discord_screen.visible = false
	info_panel.visible = false
	characters_container.visible = false
	
	start_dialogue() #iniciar dialogo :D

func start_dialogue():
	DialogueManager.show_example_dialogue_balloon(dialogue_resource, "start")

# ========== FUNCIONES PARA EL DIÁLOGO ==========
func set_background(bg_name: String):
	if bg_name == "negro":
		background.texture = null
		background.modulate = Color.BLACK
	elif backgrounds.has(bg_name) and backgrounds[bg_name] != "":
		var texture = load(backgrounds[bg_name])
		if texture:
			background.texture = texture
			background.modulate = Color.WHITE
	else:
		print("Fondo no encontrado: " + bg_name)

func show_info_icon(info_type: String):
	# Esta función se llamará desde el diálogo
	print("Mostrar info sobre: " + info_type)

func show_discord_screen():
	# Limpiar mensajes anteriores
	for child in messages_container.get_children():
		child.queue_free()
	discord_screen.visible = true

func hide_discord_screen():
	discord_screen.visible = false

func add_discord_message(text: String, is_player: bool = false):
	await get_tree().create_timer(0.1).timeout  #delay para efecto
	
	var message = RichTextLabel.new()
	message.bbcode_enabled = true
	message.fit_content = true
	message.scroll_active = false
	
	if is_player:
		message.text = "[right][color=cornflower_blue]" + text + "[/color][/right]"
	else:
		message.text = "[color=white]" + text + "[/color]"
	
	message.custom_minimum_size = Vector2(400, 0)
	messages_container.add_child(message)

func show_characters():
	characters_container.visible = true
	#aqui cargar sprites de personajes

func set_bad_ending(value: bool):
	bad_ending = value

func retry_game():
	get_tree().reload_current_scene()

func go_to_main_menu():
	get_tree().change_scene_to_file("res://escenas/menu.tscn")

func _on_close_info_panel():
	info_panel.visible = false

func _on_dialogue_ended(resource: DialogueResource):
	print("Diálogo terminado")

func cargarSiguienteCap(nombreCap: String):
	await get_tree().create_timer(0.5).timeout
	# Cargar el siguiente capítulo
	dialogue_resource = load("res://dialogos/" + nombreCap + ".dialogue")
	
	#iniciarlo
	DialogueManager.show_example_dialogue_balloon(dialogue_resource, "start")

#func cargar_escenaHospi():
	#dialogue_resource =load("res://dialogos/escenaHospi.dialogue")
	#DialogueManager.show_example_dialogue_balloon(dialogue_resource, "start")
