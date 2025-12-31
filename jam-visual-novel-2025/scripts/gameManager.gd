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
@onready var pause_menu = $menuPausa
@onready var continuar = $menuPausa/Panel/VBoxContainer/continuar
@onready var salir = $menuPausa/Panel/VBoxContainer/salir
@onready var opciones = $menuPausa/Panel/VBoxContainer/op
@onready var opSubMenu = $menuPausa/MenuOp/PanelContainer/opciones
@onready var animacion = $menuPausa/MenuOp/AnimationPlayer

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
	"entradaPortal": "res://assets/imagenes/fondos/portal.jpeg",
	"calleDiaInvierno": "res://assets/imagenes/fondos/invierno/thumbnail_calleDia.jpg",
	"calleNocheInvierno": "res://assets/imagenes/fondos/invierno/calleNoche.jpeg",
	"parqueInvierno":"res://assets/imagenes/fondos/invierno/WhatsApp Image 2025-12-23 at 16.26.56.jpg",
	"claseInvierno": "res://assets/imagenes/fondos/invierno/fondo clase.jpg"
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
		"sonrojadaHabla2": "res://assets/imagenes/personajes/kristineSonrojadaHablando2.png",
		"seriaInvierno": "res://assets/imagenes/personajes/invierno/kristine/kristine seria.png",
		"felizInvierno" : "res://assets/imagenes/personajes/invierno/kristine/kris feliz.png",
		"avergonzadaInvierno" : "res://assets/imagenes/personajes/invierno/kristine/kristine sonrojada2.png",
		"hablaNormalInvierno":"res://assets/imagenes/personajes/invierno/kristine/kris habla normañ.png",
		"hablaAlegreInvierno":"res://assets/imagenes/personajes/invierno/kristine/kris habla alegre.png",
		"hablaPreocupadaInvierno":"res://assets/imagenes/personajes/invierno/kristine/kris habla mal.png",
		"hablaTriteInvierno": "res://assets/imagenes/personajes/invierno/kristine/kris habla preocupada.png",
		"intentoSonrisaInvierno":"res://assets/imagenes/personajes/invierno/kristine/kris intento sonrie.png",
		"sinHablarInvierno":"res://assets/imagenes/personajes/invierno/kristine/kristine sin hablar.png",
		"sonrojadaInvierno":"res://assets/imagenes/personajes/invierno/kristine/kristine avergonzada.png",
		"sonrojadaHablaInvierno":"res://assets/imagenes/personajes/invierno/kristine/kristine sonrojada hablando.png",
		"sonrojadaHabla2Invierno":"res://assets/imagenes/personajes/invierno/kristine/kristine sonrojada hablando 2.png"
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
		"sonrojado": "res://assets/imagenes/personajes/mateo sonrojo serio.png",
		"serioInvierno":"res://assets/imagenes/personajes/invierno/mateo/mateo serio.png",
		"felizInvierno": "res://assets/imagenes/personajes/invierno/mateo/Mateo sonrie.png",
		"triteInvierno":"res://assets/imagenes/personajes/invierno/mateo/mateo trite.png",
		"avergonzadoInvierno":"res://assets/imagenes/personajes/invierno/mateo/mateo sonrojo serio2.png",
		"hablaNormalInvierno":"res://assets/imagenes/personajes/invierno/mateo/Mateo habla1.png",
		"hablaAlegreInvierno":"res://assets/imagenes/personajes/invierno/mateo/mateo habla2.png",
		"sinHablarInvierno":"res://assets/imagenes/personajes/invierno/mateo/mateo sin hablar.png",
		"hablaPreocupadoInvierno":"res://assets/imagenes/personajes/invierno/mateo/mateo habla preocupado.png",
		"sonrojadoInvierno":"res://assets/imagenes/personajes/invierno/mateo/mateo sonrojo serio.png"
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
var is_paused = false
var skipActivo = false
var skipVel = 0.05 #cuanto + bajo + rapido
var cargando_capitulo = false  

func _ready():
	if pause_menu is CanvasLayer:
		pause_menu.layer = 10000
	Game.manager = self
	#dialogue_resource = w("res://dialogos/es/inicio.dialogue")
	
	IdiomaManager.idioma_cambiado.connect(_on_idioma_cambiado)
	var ruta_dialogo := IdiomaManager.obtener_ruta_dialogo("inicio")
	if not FileAccess.file_exists(ruta_dialogo):
		push_warning("Traducción no disponible. Estará el español por defecto.")
		ruta_dialogo = "res://dialogos/es/inicio.dialogue"
	dialogue_resource = load(ruta_dialogo)

	DialogueManager.dialogue_ended.connect(_on_dialogue_ended)
	close_button.pressed.connect(_on_close_info_panel)
	SistemaPuntos.maxPuntosNegativos.connect(inicioMaxNegativos)
	
	# Ocultar elementos al inicio
	discord_screen.visible = false
	info_panel.visible = false
	characters_container.visible = false
	pause_menu.visible = false
	$menuPausa/MenuOp.visible = false
	opSubMenu.hide()
	
	if has_node("SkipBtn"):
		$SkipBtn.toggled.connect(_on_skip_btn_toggled)

	#conectar cosos para submenu
	if not continuar.is_connected("pressed", _on_continuar_pressed):
		continuar.pressed.connect(_on_continuar_pressed)
	if not salir.is_connected("pressed", _on_salir_pressed):
		salir.pressed.connect(_on_salir_pressed)
	if not opciones.is_connected("pressed", _on_op_pressed):
		opciones.pressed.connect(_on_op_pressed)
	if opSubMenu.has_node("opciones/exit"):
		opSubMenu.get_node("opciones/exit").pressed.connect(_on_options_exit_pressed)
	if opSubMenu.has_node("TabContainer/idioma/OptionButton"):
		opSubMenu.get_node("TabContainer/idioma/OptionButton").item_selected.connect(_on_option_button_item_selected)
	if opSubMenu.has_node("opciones/audioControl"):
		var audio_ctrl = opSubMenu.get_node("opciones/audioControl")
		audio_ctrl.sliders()  # Llama a sliders() para sincronizar con el volumen actual
	
	start_dialogue()
	
# ====== para idioma ======
func _on_idioma_cambiado(nuevo_idioma: String):
	#actualizar textos del menu pa traducir bien
	continuar.text = tr("ui_continuar")
	salir.text = tr("ui_salir")
	opciones.text = tr("ui_opciones")
	
	if opSubMenu.has_node("opciones/exit"):
		opSubMenu.get_node("opciones/exit").text = tr("ui_volver")
	if opSubMenu.has_node("TabContainer"):
		var tabs = opSubMenu.get_node("TabContainer")
		for i in range(tabs.get_tab_count()):
			var tab_name = tabs.get_tab_control(i).name
			if tab_name == "idioma":
				tabs.set_tab_title(i, tr("MENU_IDIOMA"))
			elif tab_name == "audio":
				tabs.set_tab_title(i, tr("MENU_AUDIO"))

# ====== DIALOGO ======
func start_dialogue():
	crear_nuevo_balloon("start")

func crear_nuevo_balloon(titulo: String):
	if balloon_actual != null: #limpiar balloon anterior si existe del coso dialogo
		if balloon_actual.is_connected("response_selected", _on_balloon_response_selected):
			balloon_actual.response_selected.disconnect(_on_balloon_response_selected)
		balloon_actual = null
	#crear nuevo balloon
	balloon_actual = DialogueManager.show_example_dialogue_balloon(dialogue_resource, titulo)
	await get_tree().process_frame #esperar frame y conectar señales
	
	if balloon_actual and balloon_actual.has_signal("response_selected"):
		balloon_actual.response_selected.connect(_on_balloon_response_selected)
	print("Balloon creado y conectado: ", titulo)

func _on_balloon_response_selected(_response):
	detenerSkip()

# ====== FUNCIONES DE DIALOGO ======
func set_background(bg_name: String):
	if bg_name == "negro":
		background.modulate = Color.BLACK
	elif backgrounds.has(bg_name) and backgrounds[bg_name] != "":
		var texture = load(backgrounds[bg_name])
		if texture:
			background.texture = texture
			background.modulate = Color.WHITE
			
 #optimizar esta cosa
#func show_discord_screen():
	#for child in messages_container.get_children():
		#child.queue_free()
	#discord_screen.visible = true
#
#func hide_discord_screen():
	#discord_screen.visible = false
#
#func add_discord_message(text: String, is_player: bool = false):
	#await get_tree().create_timer(0.1).timeout
	#var message = RichTextLabel.new()
	#message.bbcode_enabled = true
	#message.fit_content = true
	#message.scroll_active = false
	#
	#if is_player:
		#message.text = "[right][color=cornflower_blue]" + text + "[/color][/right]"
	#else:
		#message.text = "[color=white]" + text + "[/color]"
#
	#message.custom_minimum_size = Vector2(400, 0)
	#messages_container.add_child(message)

#mostrar personaje con/sin expresiones
func show_character(nom: String, posicion: String = "centro", expre: String = "neutral"):
	print("Mostrando: " + nom + " en " + posicion)
	if not personajes.has(nom):
		push_error("Personaje no encontrado: " + nom)
		return
	var ruta = ""
	
	if personajes[nom] is Dictionary:
		if not personajes[nom].has(expre):
			push_error("Expresión no encontrada: " + expre + " para " + nom)
			return
		ruta = personajes[nom][expre]
	else:
		ruta = personajes[nom]
	
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

#ocultar personaje especifico
func hide_character(posicion: String = "centro"):
	var pos_key = ""
	match posicion.to_lower():
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
	match posicion:
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
	
func inicioMaxNegativos():
	print("Se alcanzó el máximo de los puntos negativos")

func _on_dialogue_ended(_resource: DialogueResource):
	print("Diálogo terminado - NO anular balloon_actual aquí")
	#NO PONER balloon_actual = null AQUÍ - para que cargarSiguienteCap lo maneje

func cargarSiguienteCap(nombreCap: String):
	cargando_capitulo = true 
	detenerSkip()
	await get_tree().create_timer(0.1).timeout
	
	var ruta := IdiomaManager.obtener_ruta_dialogo(nombreCap)
	if not FileAccess.file_exists(ruta):
		ruta = "res://dialogos/es/" + nombreCap + ".dialogue"
	
	dialogue_resource = load(ruta)
	
	#LIMPIAR BALLOON ANTERIOR
	if balloon_actual != null:
		if balloon_actual.has_signal("response_selected") and balloon_actual.is_connected("response_selected", _on_balloon_response_selected):
			balloon_actual.response_selected.disconnect(_on_balloon_response_selected)
		balloon_actual = null
	#CREAR NUEVO BALLOON
	balloon_actual = DialogueManager.show_example_dialogue_balloon(dialogue_resource, "start")
	#ESPERAR A QUE SE CREE 
	await get_tree().process_frame
	await get_tree().process_frame
	#RECONECTAR SEÑALES
	if balloon_actual and balloon_actual.has_signal("response_selected"):
		balloon_actual.response_selected.connect(_on_balloon_response_selected)
		print("Señal response_selected reconectada :D")
	
	cargando_capitulo = false  #TERMINAR CARGA
	print("Nuevo capítulo cargado: ", nombreCap, " | Balloon: ", balloon_actual != null)

func cargarFinal(nombreFinal: String):
	cargando_capitulo = true  #MARCAR QUE TA CARGANDO
	detenerSkip()
	await get_tree().create_timer(0.1).timeout

	var ruta := IdiomaManager.obtener_ruta_dialogo("finales")
	if not FileAccess.file_exists(ruta):
		ruta = "res://dialogos/es/finales.dialogue"
	dialogue_resource = load(ruta)
	if balloon_actual != null:
		if balloon_actual.has_signal("response_selected") and balloon_actual.is_connected("response_selected", _on_balloon_response_selected):
			balloon_actual.response_selected.disconnect(_on_balloon_response_selected)
		balloon_actual = null
	balloon_actual = DialogueManager.show_example_dialogue_balloon(dialogue_resource, nombreFinal)
	await get_tree().process_frame
	await get_tree().process_frame
	if balloon_actual and balloon_actual.has_signal("response_selected"):
		balloon_actual.response_selected.connect(_on_balloon_response_selected)
		print("Señal response_selected reconectada")
	cargando_capitulo = false  #TERMINAR CARGA
	print("Final cargado: ", nombreFinal, " | Balloon: ", balloon_actual != null)
	
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

func puede_final_canon() -> bool:
	var mateo = SistemaPuntos.obtenerPuntos("mateo")
	var neg = SistemaPuntos.obtenerPuntosNegativos()
	return mateo >= 3 and neg < 4

func obtener_final() -> String:
	var neg = SistemaPuntos.obtenerPuntosNegativos()
	var mateo = SistemaPuntos.obtenerPuntos("mateo")
	var kris = SistemaPuntos.obtenerPuntos("kristine")
	if neg >= 5:
		return "finalMalo"
	elif kris >= 2 and mateo >= 3:
		return "demasiadasMentiras"
	else:
		return "finalCanon"

#falta eto
func mostrar_medidor_mateo():
	if has_node("MedidorPuntos"):
		$MedidorPuntos.mostrar_medidor("mateo")

func ocultar_medidor_mateo():
	if has_node("MedidorPuntos"):
		$MedidorPuntos.ocultar_medidor()

func _input(event):
	if event.is_action_pressed("pause"):
		toggle_pause()
		return
	
	if is_paused:
		return
	if event.is_action_pressed("skip"):
		if cargando_capitulo:
			print("Esperando a que termine de cargar el capítulo...")
			return
		print("Skip presionado | Balloon: ", balloon_actual != null)
		skipActivo = !skipActivo
		if has_node("SkipBtn"):
			$SkipBtn.button_pressed = skipActivo
		if skipActivo:
			iniciarSkip()

func toggle_pause():
	is_paused = !is_paused
	pause_menu.visible = is_paused
	if is_paused:
		detenerSkip()
		if balloon_actual:
			balloon_actual.hide()
		get_viewport().set_input_as_handled()
	else:
		if balloon_actual:
			balloon_actual.show()
		opSubMenu.hide()
		$menuPausa/MenuOp.visible = false

func _on_op_pressed() -> void:
	mostrarOpciones(true)

func _on_continuar_pressed() -> void:
	toggle_pause()

func _on_salir_pressed() -> void:
	if balloon_actual and balloon_actual.has_method("end_dialogue"):
		balloon_actual.end_dialogue()
	get_tree().change_scene_to_file("res://escenas/menu.tscn")
	
func mostrarOpciones(show_menu: bool):
	if show_menu:
		$menuPausa/MenuOp.visible = true
		opSubMenu.show()
		if animacion:
			animacion.play("animacionOpciones")
		if opSubMenu.has_node("exit"):
			opSubMenu.get_node("exit").grab_focus()
	else:
		if animacion:
			animacion.play_backwards("animacionOpciones")
			await animacion.animation_finished
		opSubMenu.hide()
		$menuPausa/MenuOp.visible = false

func _on_options_exit_pressed():
	Audio.pulsar_btn()
	mostrarOpciones(false)
	opciones.grab_focus()

func _on_option_button_item_selected(index: int):
	var idiomas := ["es", "en"]
	if index < idiomas.size():
		IdiomaManager.cambiar_idioma(idiomas[index])

func change_language(index: int):
	print("Idioma cambiado a índice: " + str(index))

func _on_exit_pressed() -> void:
	Audio.pulsar_btn()
	mostrarOpciones(false)
	opciones.grab_focus()

#========= SKIP =========
func iniciarSkip():
	if cargando_capitulo:
		print("Esperando carga de capítulo...")
		skipActivo = false
		if has_node("SkipBtn"):
			$SkipBtn.button_pressed = false
		return
	
	if not balloon_actual:
		print("No hay balloon")
		skipActivo = false
		if has_node("SkipBtn"):
			$SkipBtn.button_pressed = false
		return
	print("Skip iniciado")
	skip_siguiente_linea()

func skip_siguiente_linea():
	if not skipActivo or is_paused or cargando_capitulo:
		return
	
	if not balloon_actual:
		print("Balloon perdido durante skip")
		detenerSkip()
		return
	await get_tree().create_timer(skipVel).timeout
	if not skipActivo or is_paused or cargando_capitulo:
		return
	if not balloon_actual:
		return
	if _hay_opciones():
		detenerSkip()
		print("Skip detenido: opciones")
		return
	# Intentar avanzar el diálogo
	if balloon_actual.has_method("_on_balloon_gui_input"):
		var click = InputEventMouseButton.new()
		click.button_index = MOUSE_BUTTON_LEFT
		click.pressed = true
		balloon_actual._on_balloon_gui_input(click)
		skip_siguiente_linea()
	else:
		print("Método no encontrado")
		detenerSkip()

func _hay_opciones() -> bool:
	if not balloon_actual:
		return false
	if balloon_actual.has_node("Responses"):
		var responses = balloon_actual.get_node("Responses")
		return responses.visible and responses.get_child_count() > 0
	if balloon_actual.has_method("get_responses"):
		var responses = balloon_actual.get_responses()
		return responses != null and responses.size() > 0
	return false

func detenerSkip():
	skipActivo = false
	if has_node("SkipBtn"):
		$SkipBtn.button_pressed = false
	print("Skip detenido")

func _on_skip_btn_toggled(toggled_on: bool) -> void:
	skipActivo = toggled_on
	if skipActivo:
		print("Skip ON")
		iniciarSkip()
	else:
		print("Skip OFF")
