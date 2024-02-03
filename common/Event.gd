class_name Event  # Esto registra la clase Accion para que sea accesible globalmente.

var nombre := ""
var optionAction : Array

func _init(_nombre: String, _optionAction : Array):
	nombre = _nombre
	optionAction = _optionAction

func hasEnded():
	for item in optionAction:
		if not item.hasEnded():
			return false
	return true
