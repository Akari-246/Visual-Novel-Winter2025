extends Node

var skip_activo = false
var velocidad_skip = 0.05

signal skip_activado()
signal skip_desactivado()

func _ready():
	print("✅ Sistema de Skip inicializado")

func activar_skip():
	skip_activo = true
	skip_activado.emit()
	print("⏩ Skip activado")

func desactivar_skip():
	skip_activo = false
	skip_desactivado.emit()
	print("⏸️ Skip desactivado")

func alternar_skip():
	if skip_activo:
		desactivar_skip()
	else:
		activar_skip()

func esta_activo() -> bool:
	return skip_activo

func marcar_punto_decision(id_decision: String):
	if skip_activo:
		desactivar_skip()
		print("🛑 Skip detenido en: " + id_decision)
