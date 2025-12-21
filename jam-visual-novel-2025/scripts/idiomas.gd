extends Node

# Sistema de gestión de idiomas para toda la aplicación
signal idioma_cambiado(nuevo_idioma: String)

var idioma_actual: String = "es"
var idiomas_disponibles := ["es", "en"]

# Carpetas de diálogos por idioma
const CARPETA_DIALOGOS := "res://dialogos/"

func _ready():
	cargar_idioma_guardado()

# Cambiar idioma
func cambiar_idioma(codigo: String):
	if codigo not in idiomas_disponibles:
		push_error("Idioma no disponible: " + codigo)
		return
	
	idioma_actual = codigo
	TranslationServer.set_locale(codigo)
	guardar_idioma()
	idioma_cambiado.emit(codigo)
	print("✓ Idioma cambiado a: " + codigo)

# Obtener ruta de diálogo según idioma
func obtener_ruta_dialogo(nombre: String) -> String:
	return CARPETA_DIALOGOS + idioma_actual + "/" + nombre + ".dialogue"

# Guardar preferencia
func guardar_idioma():
	var config := ConfigFile.new()
	config.set_value("config", "idioma", idioma_actual)
	config.save("user://config.cfg")

# Cargar idioma guardado
func cargar_idioma_guardado():
	var config := ConfigFile.new()
	var err := config.load("user://config.cfg")
	
	if err == OK:
		idioma_actual = config.get_value("config", "idioma", "es")
	else:
		# Detectar idioma del sistema
		var locale := OS.get_locale().substr(0, 2)
		idioma_actual = locale if locale in idiomas_disponibles else "es"
	
	TranslationServer.set_locale(idioma_actual)
	print("✓ Idioma cargado: " + idioma_actual)

# Obtener nombre del idioma
func obtener_nombre_idioma(codigo: String) -> String:
	match codigo:
		"es": return "Español"
		"en": return "English"
		_: return codigo

# Obtener lista de idiomas
func obtener_lista_idiomas() -> Array:
	var lista := []
	for codigo in idiomas_disponibles:
		lista.append({
			"codigo": codigo,
			"nombre": obtener_nombre_idioma(codigo)
		})
	return lista
