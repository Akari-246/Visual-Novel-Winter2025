extends VBoxContainer

@export_group("Basics")
@export var vol: float = 5.0

@export_group("Objects")
@export var general: HSlider
@export var musica: HSlider
@export var efectos: HSlider
@export var testSonido: AudioStream  # Sonido de prueba para SFX
@export var audioPlayer: AudioStreamPlayer  # Player para reproducir el sonido de prueba
@export var sonidoBarra: AudioStream  # Sonido continuo para barras de volumen (e.g., tono)
@export var barraPlayer: AudioStreamPlayer  # Player dedicado para sonido de barra

@onready var menosG = $mainBox/menosG
@onready var masG = $mainBox/masG
@onready var menosM = $musicaBox/menosM
@onready var masM = $musicaBox/masM
@onready var menosS = $sfxBox/menosSFX
@onready var masS = $sfxBox/masSFX

const minDeci = -60.0
const maxDeci = 0.0

var barra_timer: Timer  # Timer para detener el sonido de barra automáticamente

func _ready():
	sliders()
	general.value_changed.connect(volGeneral)
	musica.value_changed.connect(volMusica)
	efectos.value_changed.connect(volSfx)
	
	# Conexiones para botones
	menosG.pressed.connect(btnMenosG)
	masG.pressed.connect(btnMasG)
	menosM.pressed.connect(btnMenosM)
	masM.pressed.connect(btnMasM)
	menosS.pressed.connect(btnMenosS)
	masS.pressed.connect(btnMasS)
	
	# Timer para detener sonido de barra (0.5s después de cambio)
	barra_timer = Timer.new()
	barra_timer.one_shot = true
	barra_timer.timeout.connect(_stop_barra_sound)
	add_child(barra_timer)

func sliders():
	general.value = deci_to_slider(AudioServer.get_bus_volume_db(AudioServer.get_bus_index("Master")))
	musica.value = deci_to_slider(AudioServer.get_bus_volume_db(AudioServer.get_bus_index("Musica")))
	efectos.value = deci_to_slider(AudioServer.get_bus_volume_db(AudioServer.get_bus_index("SFX")))

func slider_to_deci(value: float) -> float:
	if value <= 0.0:
		return minDeci
		
	var lin = value / 100.0
	var deci = linear_to_db(lin)
	return clamp(deci, minDeci, maxDeci)
	
func deci_to_slider(deci: float) -> float:
	if deci <= minDeci:
		return 0.0
	var lin = db_to_linear(deci)
	return clamp(lin * 100.0, 0.0, 100.0)
	
func volumen(busNom: String, value: float):
	var deci = slider_to_deci(value)
	var busI = AudioServer.get_bus_index(busNom)
	AudioServer.set_bus_volume_db(busI, deci)
	AudioServer.set_bus_mute(busI, deci <= minDeci)
	
func volGeneral(value: float):
	volumen("Master", value)
	#play_barra_sound(value)  # Reproduce sonido de barra con volumen dinámico

func volMusica(value: float):
	volumen("Musica", value)
	#play_barra_sound(value)  # Reproduce sonido de barra con volumen dinámico
	
func volSfx(value: float):
	volumen("SFX", value)
	#playSfx()  # Sonido de prueba único para SFX
	play_barra_sound(value)  # También sonido de barra dinámico para SFX

func btnMenosG():
	general.value = clamp(general.value - vol, 0.0, 100.0)
func btnMasG():
	general.value = clamp(general.value + vol, 0.0, 100.0)

func btnMenosM():
	musica.value = clamp(musica.value - vol, 0.0, 100.0)
func btnMasM():
	musica.value = clamp(musica.value + vol, 0.0, 100.0)
	
func btnMenosS():
	efectos.value = clamp(efectos.value - vol, 0.0, 100.0)
func btnMasS():
	efectos.value = clamp(efectos.value + vol, 0.0, 100.0)

# Método para reproducir sonido de prueba al cambiar SFX
func playSfx():
	if audioPlayer and testSonido:
		audioPlayer.stream = testSonido
		audioPlayer.play()

# Función para reproducir sonido de barra con volumen dinámico
func play_barra_sound(slider_value: float):
	if barraPlayer and sonidoBarra:
		barraPlayer.stream = sonidoBarra
		barraPlayer.volume_db = slider_to_deci(slider_value)  # Volumen baja/sub con el slider
		barraPlayer.play()
		barra_timer.start(0.5)  # Detiene después de 0.5s

func _stop_barra_sound():
	if barraPlayer:
		barraPlayer.stop()
