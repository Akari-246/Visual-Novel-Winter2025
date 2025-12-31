extends OptionButton

func _ready():
	clear()
	add_item("Español", 0)
	add_item("English", 1)
	
	# Seleccionar idioma actual
	selected = 0 if IdiomaManager.idioma_actual == "es" else 1
	
	item_selected.connect(_on_seleccionado)

func _on_seleccionado(index: int):
	var idiomas := ["es", "en"]
	IdiomaManager.cambiar_idioma(idiomas[index])
	Audio.pulsar_btn()
