extends Node

var manager = null

func set_background(bg: String):
	if manager: manager.set_background(bg)

func show_character(n: String, p: String = "centro", e: String = "neutral"):
	if manager: manager.show_character(n, p, e)

func hide_character(p: String = "centro"):
	if manager: manager.hide_character(p)

func hide_all_characters():
	if manager: manager.hide_all_characters()

func mostrarFinal():
	if manager: manager.mostrarFinal()

func cargarSiguienteCap(cap: String):
	if manager: manager.cargarSiguienteCap(cap)

func cargarFinal(final: String):
	if manager: manager.cargarFinal(final)

func puede_final_canon() -> bool:
	return manager.puede_final_canon() if manager else false

func cual_final() -> String:
	return manager.cual_final() if manager else "finalCanon"
