extends AudioStreamPlayer

const musicaMenu = preload("res://assets/audio/musica/menu/stress-relief-piano-117013.mp3")
const SFX_BTN = preload("res://assets/Audio/SFX/recogeObjetoAgudo.wav")
const inicio = preload("res://assets/audio/musica/inicio/a-moment-like-this-172295.mp3")
const momentoDecidir = preload("res://assets/audio/musica/decidiendo/soft-piano-music-312509.mp3")
const notificacion = preload("res://assets/audio/SFX/notificacion/sfxNoti.wav")
const hospi = preload("res://assets/audio/musica/escenaHospi/relaxing-piano-music-248868.mp3")
const noviembre = preload("res://assets/audio/musica/escenaHospi/night-amsterdam-synth-pop-version-background-music-for-video-vlog-207300.mp3")

const finalEstupido2 = preload("res://assets/audio/musica/finales/estupido/cartoon-funny-comedy-background-music-326435.mp3")
const finalMalo = preload("res://assets/audio/musica/finales/malo/militant-amelia-dramatic-orchestral-background-music-for-video-34-sec-205319.mp3")
const finalAmigos = preload("res://assets/audio/musica/finales/amigos/thinking-of-good-time-soft-piano-music-201837.mp3")
const finalCobarde = preload("res://assets/audio/musica/finales/cobarde/evening-glow-soft-piano-music-243818.mp3")
const finalMentiras = preload("res://assets/audio/musica/finales/demasiadas mentiras/beyond-the-horizon-cinematic-background-music-for-video-short-2-413333.mp3")

var vel_fade = 1.0
var fade = false

#=======Funciones para usar en dialogue=======
#func musicMenu(vol = -1):
	#playMusic(musicaMenu, vol)

func _ready():
	bus = "Musica"
	finished.connect(_on_finished)  # Conecta la señal para loop manual

func _on_finished():
	play()

func playMusic(musica: AudioStream, vol = 0.0):
	if stream == musica:
		return
	stream = musica
	volume_db = vol
	play()

func music_nivel(vol = 0.0):
	playMusic(musicaMenu, vol)

func pulsar_btn():
	play_sfx(SFX_BTN)

func stop_music():  # con fade
	if fade:
		return
	fade = true
	var tween = create_tween()
	tween.tween_property(self, "volume_db", -80.0, vel_fade)
	tween.tween_callback(func(): stop(); volume_db = 0.0; fade = false)  # para y resetea

func music_fade(musica: AudioStream, vol = 0.0):  # para empezar con la musica suavito
	if stream == musica:
		return
	stream = musica
	volume_db = -70.0
	play()
	var tween = create_tween()
	tween.tween_property(self, "volume_db", vol, vel_fade)

func play_sfx(audio_stream: AudioStream, vol = 0.0):
	var sfx = AudioStreamPlayer.new()
	sfx.stream = audio_stream
	sfx.name = "SFX"
	sfx.volume_db = vol
	sfx.bus = "SFX"
	add_child(sfx)
	sfx.play()
	await sfx.finished
	sfx.queue_free()

# Nueva función para transiciones suaves entre músicas
func change_music(new_music: AudioStream, vol = 0.0):
	if fade or stream == new_music:  # Evita cambios si ya está fading o es la misma música
		return
	fade = true
	var tween = create_tween()
	tween.tween_property(self, "volume_db", -80.0, vel_fade)  # Fade out de la actual
	tween.tween_callback(func():
		stream = new_music
		volume_db = -70.0  # Inicia baja para fade in
		play()
		var tween_in = create_tween()
		tween_in.tween_property(self, "volume_db", vol, vel_fade)  # Fade in de la nueva
		tween_in.tween_callback(func(): fade = false)
	)
