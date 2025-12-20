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
@onready var characterIzq = $personajeIzq
@onready var characterDrcha = $personajeDerecha
@onready var characterCentro = $personajeCentro

# ====== fondos ======
var backgrounds = {
	"habitacion1": "res://assets/imagenes/fondos/habitacion1.jpeg",
	"habitacionMasOscura": "res://assets/imagenes/fondos/habitacion2.jpeg",
	"habitacionAtardecer": "res://assets/imagenes/fondos/habitacion atardecer.jpeg",
	"habitacionNoche": "res://assets/imagenes/fondos/habitacion noche.jpeg",
	"clase": "res://assets/imagenes/fondos/clase.jpeg",
	"habitacionHospital": "res://assets/imagenes/fondos/habitacion hospi.jpeg",
	"negroo": "res://assets/imagenes/fondos/negro.jpeg",
	"parque": "res://assets/imagenes/fondos/parqueDia.jpeg",
	"parqueNoche": "res://assets/imagenes/fondos/parqueNoche.jpeg",
	"calleDia": "res://assets/imagenes/fondos/calleDia.jpeg",
	"calleNoche": "res://assets/imagenes/fondos/calleNoche.jpeg",
	"fucsiaMuyOscuro": "res://assets/imagenes/fondos/fucsia muy oscuro.jpeg",
	"fucsiaOscuro": "res://assets/imagenes/fondos/fucsia oscuro.jpeg",
	"rosa": "res://assets/imagenes/fondos/rosa.jpeg",
	"entradaPortal": "res://assets/imagenes/fondos/portal.jpeg"
}

# ====== personajes ======
var personajes = {
	"kristine": {
		"seria": "res://assets/imagenes/personajes/kristineSeria.png",
		"feliz": "res://assets/imagenes/personajes/krisFeliz.png",
		"avergonzada": "res://assets/imagenes/personajes/kristineSonrojada2.png",
		"hablaNormal": "res://assets/imagenes/personajes/krisHablaNormañ.png",
		"hablaAlegre": "res://assets/imagenes/personajes/krisHablaAlegre.png",
		"hablaPreocupada": "res://assets/imagenes/personajes/krisHablaMal.png",
		"hablaTrite": "res://assets/imagenes/personajes/krisHablaPreocupada.png",
		"intentoSonrisa": "res://assets/imagenes/personajes/krisIntentoSonrie.png",
		"sinHablar": "res://assets/imagenes/personajes/kristine sin hablar.png",
		"sonrojada": "res://assets/imagenes/personajes/kristineAvergonzada.png",
		"sonrojadaHabla": "res://assets/imagenes/personajes/kristineSonrojadaHablando.png",
		"sonrojadaHabla2": "res://assets/imagenes/personajes/kristineSonrojadaHablando2.png"
	},
	"mateo": {
		"serio": "res://assets/imagenes/personajes/mateo serio.png",
		"feliz": "res://assets/imagenes/personajes/Mateo sonrie.png",
		"trite": "res://assets/imagenes/personajes/mateo trite.png",
		"avergonzado": "res://assets/imagenes/personajes/mateo sonrojo serio2.png",
		"hablaNormal": "res://assets/imagenes/personajes/Mateo habla1.png",
		"hablaAlegre": "res://assets/imagenes/personajes/mateo habla2.png",
		"sinHablar": "res://assets/imagenes/personajes/mateo sin hablar.png",
		"hablaPreocupado": "res://assets/imagenes/personajes/mateo habla preocupado.png",
		"sonrojado": "res://assets/imagenes/personajes/mateo sonrojo serio.png"
	},
	"mama" : "res://assets/imagenes/personajes/secundarios/madre.png",
	"mamaNoHabla": "res://assets/imagenes/personajes/secundarios/mama sin hablar.png",
	"papa": "res://assets/imagenes/personajes/secundarios/padre.png",
	"papaNoHabla": "res://assets/imagenes/personajes/secundarios/padre sin hablar.png",
	"felix": "res://assets/imagenes/personajes/secundarios/felix.png",
	"felixNoHabla": "res://assets/imagenes/personajes/secundarios/felix sin hablar.png"
}

var posicionCharacter = {
	"izq": {"nom": "", "expresion": ""},
	"centro": {"nom": "", "expresion": ""},
	"derecha": {"nom": "", "expresion": ""}
}

var bad_ending = false
var dialogue_resource: DialogueResource
var balloon_actual = null
var skip_activo = false
var velocidad_skip = 0.05

func _ready():
	Game.manager = self
	
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
func set_background(bg_name: String): #optimizar esta cosa
	if bg_name == "negro":
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

# Mostrar personaje con o sin expresiones
func show_character(nom: String, posicion: String = "centro", expre: String = "neutral"):
	print("Mostrando: " + nom + " en " + posicion)
	# Verificar si el personaje existe
	if not personajes.has(nom):
		push_error("Personaje no encontrado: " + nom)
		return
	var ruta = ""
	# Verificar si el personaje tiene expresiones (es un diccionario)
	if personajes[nom] is Dictionary:
		# El personaje tiene expresiones
		if not personajes[nom].has(expre):
			push_error("Expresión no encontrada: " + expre + " para " + nom)
			return
		ruta = personajes[nom][expre]
		#print("  -> Con expresión: " + expre)
	else:
		# El personaje es una ruta directa (sin expresiones)
		ruta = personajes[nom]
		print("  -> Sin expresiones")
	
	var texture = load(ruta)
	if not texture:
		push_error("No se pudo cargar: " + ruta)
		return
	var sprite: Sprite2D
	match posicion:
		"izq", "izquierda":
			sprite = characterIzq
		"centro":
			sprite = characterCentro
		"derecha":
			sprite = characterDrcha
		_:
			sprite = characterCentro
	sprite.texture = texture
	sprite.visible = true
	sprite.modulate = Color(1.0, 1.0, 1.0, 1.0)
	characters_container.visible = true
	
	# Guardar info del personaje
	#posicionCharacter[posicion] = {"nom": nom, "expresion": expre}
	
# Ocultar un personaje específico
func hide_character(posicion: String = "centro"):
	var pos_key = ""
	match posicion.to_lower(): #determinar la clave correcta
		"izq", "izquierda", "left":
			pos_key = "izq"
		"centro", "center":
			pos_key = "centro"
		"derecha", "dcha", "right":
			pos_key = "derecha"
		_:
			push_error("Posición no válida: " + posicion)
			return
	
	var sprite = getSpritePosition(pos_key)
	if sprite:
		sprite.visible = false
	posicionCharacter[pos_key] = {"nom": "", "expresion": ""}

#para obtener sprite por posición
func getSpritePosition(posicion: String) -> Sprite2D:
	match posicion:  # CAMBIAR 'position' por 'posicion'
		"izq":
			return characterIzq
		"centro":
			return characterCentro
		"derecha":
			return characterDrcha
		_:
			return null

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
	
	print("EVALUANDO: \n Mateo: %d | Kristine %d | Negativos: %d" % [puntosMateo, puntosKris, puntosNegativos])
	if puntosNegativos >= 4:
		cargarFinal("finalMalo")
	elif puntosKris >= -2 and puntosMateo >= -3:
		cargarFinal("demasiadasMentiras")
	else: 
		cargarFinal("finalCanon")

func puede_final_canon() -> bool: # Verificar si puede acceder al final canon
	var mateo = SistemaPuntos.obtenerPuntos("mateo")
	var neg = SistemaPuntos.obtenerPuntosNegativos()
	return mateo >= 3 and neg < 4

func obtener_final() -> String: #Obtener el nombre del final actual
	var neg = SistemaPuntos.obtenerPuntosNegativos()
	var mateo = SistemaPuntos.obtenerPuntos("mateo")
	var kris = SistemaPuntos.obtenerPuntos("kristine")
	
	if neg >= 5:
		return "finalMalo"
	elif kris >= 2 and mateo >= 3:
		return "demasiadasMentiras"
	else:
		return "finalCanon"

func mostrar_medidor_mateo():
	if has_node("MedidorPuntos"):
		$MedidorPuntos.mostrar_medidor("mateo")

func ocultar_medidor_mateo():
	if has_node("MedidorPuntos"):
		$MedidorPuntos.ocultar_medidor()
