extends Node2D

# ====== Referencias a nodos ======
@onready var background: Sprite2D = $Fondo
@onready var discord_screen: CanvasLayer = $DiscordScreen
@onready var discord_panel: Panel = $DiscordScreen/Panel
@onready var messages_container: VBoxContainer = $DiscordScreen/Panel/Mensajes
@onready var info_panel: CanvasLayer = $InfoPanel
@onready var info_label: RichTextLabel = $InfoPanel/Panel/InfoLabel
@onready var close_button: Button = $InfoPanel/Panel/Button
@onready var characters_container: Node2D = $Character
@onready var boton_skip: Button = $SkipBtn 

# ====== Recursos de fondos ======
var backgrounds = {
	"habitacion": "",
	"clase": "",
	"habitacion_hospital": "",
	"negro": ""
}

var bad_ending = false
var dialogue_resource: DialogueResource
var balloon_actual = null
var skip_activo = false
var velocidad_skip = 0.05

func _ready():
	dialogue_resource = load("res://dialogos/inicio.dialogue")
	
	DialogueManager.dialogue_ended.connect(_on_dialogue_ended)
	close_button.pressed.connect(_on_close_info_panel)
	SistemaPuntos.maxPuntosNegativos.connect(inicioMaxNegativos)

	
	# Ocultar elementos al inicio
	discord_screen.visible = false
	info_panel.visible = false
	characters_container.visible = false
	
	start_dialogue()

# ====== DIALOGO ======
func start_dialogue():
	balloon_actual = DialogueManager.show_example_dialogue_balloon(dialogue_resource, "start")
	configBalloon()

func configBalloon():
	await get_tree().process_frame

# ====== FUNCIONES DE DIALOGO ======
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
	print("Mostrar info sobre: " + info_type)

func show_discord_screen():
	for child in messages_container.get_children():
		child.queue_free()
	discord_screen.visible = true

func hide_discord_screen():
	discord_screen.visible = false

func add_discord_message(text: String, is_player: bool = false):
	await get_tree().create_timer(0.1).timeout
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

func set_bad_ending(value: bool):
	bad_ending = value

func retry_game():
	SistemaPuntos.resetearPuntos()
	get_tree().reload_current_scene()

func go_to_main_menu():
	get_tree().change_scene_to_file("res://escenas/menu.tscn")

func _on_close_info_panel():
	info_panel.visible = false

func _on_dialogue_ended(_resource: DialogueResource):
	print("Diálogo terminado")
	balloon_actual = null

func cargarSiguienteCap(nombreCap: String):
	await get_tree().create_timer(0.5).timeout
	dialogue_resource = load("res://dialogos/" + nombreCap + ".dialogue")
	balloon_actual = DialogueManager.show_example_dialogue_balloon(dialogue_resource, "start")
	configBalloon()

func inicioMaxNegativos():
	print("Se alcanzó el máximo de los puntos negativos")

func cargarFinal(nombreFinal: String):
	await get_tree().create_timer(0.5).timeout
	dialogue_resource = load("res://dialogos/finales.dialogue")
	balloon_actual = DialogueManager.show_example_dialogue_balloon(dialogue_resource, nombreFinal)
	configBalloon()

func mostrarFinal():
	var puntosNegativos = SistemaPuntos.obtenerPuntosNegativos()
	var puntosMateo = SistemaPuntos.obtenerPuntos("mateo")
	var puntosKris = SistemaPuntos.obtenerPuntos("kristine")
	
	if puntosNegativos >= 4:
		cargarFinal("finalMalo")
	elif puntosKris >= 2 and puntosMateo >= 4:
		cargarFinal("demasiadasMentiras")
	else: 
		cargarFinal("finalCanon")

func mostrar_medidor_mateo():
	if has_node("MedidorPuntos"):
		$MedidorPuntos.mostrar_medidor("mateo")

func ocultar_medidor_mateo():
	if has_node("MedidorPuntos"):
		$MedidorPuntos.ocultar_medidor()
