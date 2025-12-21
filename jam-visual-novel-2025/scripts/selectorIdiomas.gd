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


## **Paso 6: Estructura de carpetas**
#dialogos/
#├── es/
#│   ├── inicio.dialogue
#│   ├── cap2.dialogue
#│   └── finales.dialogue
#└── en/
	#├── inicio.dialogue
	#├── cap2.dialogue
	#└── finales.dialogue

## **Paso 7: Traducir diálogos manualmente**
#**dialogos/es/inicio.dialogue:**
#~ start
#do set_background("habitacion1")
#Un día como otro cualquiera me preparé para ir a clases.
#
#**dialogos/en/inicio.dialogue:**
#~ start
#do set_background("habitacion1")
#Just another day, I prepared to go to class.
