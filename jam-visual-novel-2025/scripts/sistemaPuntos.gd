extends Node

var puntosNegativos = 0
var maxPuntos = 6
var puntos = { #eto para la relacion con los personajes
	"mateo": 0,
	"kristine": 0
}

#señales para notificar cambios :3
signal puntosCambian(personaje, cantidad, total)
signal puntoNegativo(total, max)
signal maxPuntosNegativos()

func _ready():
	print ("El sistema de puntos comenzó :D")

func cambiarPuntos(personaje: String, cantidad: int):
	if puntos.has(personaje):
		puntos[personaje] += cantidad
#		para emitir la señal que creaste:
		puntosCambian.emit(personaje, cantidad, puntos[personaje])
		if cantidad > 0:
			print ("💙" + str(cantidad) + " puntos con " + personaje + "(Total: " + str(puntos[personaje]) + ")")
		else:
			print ("💔" + str(cantidad) + " puntos con " + personaje + "(Total: " + str(puntos[personaje]) + ")")
	else:
		push_warning("El personaje no existe " + personaje)

#ps esto para obtener los puntos de x personaje (y te devuelve el int)
func obtenerPuntos(personaje: String) -> int:
	if puntos.has(personaje):
		return puntos[personaje]
	return 0

func agregarPersonaje(nombre: String, puntosInicio: int = 0):
	if not puntos.has(nombre):
		puntos[nombre] = puntosInicio
		print("Nuevo personaje: " + nombre + ":D")
	
func restarPunto() -> bool:
	puntosNegativos += 1
	puntoNegativo.emit(puntosNegativos, maxPuntos)
	print("Punto negativo: " + str(puntosNegativos) + "/" + str(maxPuntos))
	
	if puntosNegativos >= maxPuntos:
		print("Acumulaste demasiadas malas decisiones")
		maxPuntosNegativos.emit()
		return true
	return false

func obtenerPuntosNegativos() -> int:
	return puntosNegativos

func cambiarMaxNegativo(nuevoMax: int):
	maxPuntos = nuevoMax
	print("El máximo de puntos negativos ahora es de " + str(nuevoMax))

func resetearPuntos():
	for personaje in puntos:
		puntos[personaje] = 0
	puntosNegativos = 0
	print("puntos reseteados :D")

func resetearPersonaje(personaje: String):
	if puntos.has(personaje):
		puntos[personaje] =0
		print("Los puntos de " + personaje + "fueron reseteados")

func resetearNegativos():
	puntosNegativos =0
	print("Los puntos negativos fueron reseteados")

func obtenerTodosPuntos() -> Dictionary:
	return puntos.duplicate()

func puntosSufi(personaje: String, min: int) -> bool:
	return obtenerPuntos(personaje) >= min

func mostrar_estado():
	print("=== ESTADO DE PUNTOS ===")
	for personaje in puntos:
		print(personaje + ": " + str(puntos[personaje]))
	print("Puntos negativos: " + str(puntosNegativos) + "/" + str(maxPuntos))
	print("========================")
