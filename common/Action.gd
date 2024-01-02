class_name Action  # Esto registra la clase Accion para que sea accesible globalmente.

var texto := ""
var sound := ""  # Puede ser una ruta a un archivo de audio o una referencia a un AudioStream.
var background := ""  # Similarmente, puede ser una ruta o una referencia a un recurso de textura.
var character:= ""
var backgroundSound := ""

func _init(_texto: String, _sound : String, _character: String, _background : String, _backgroundSound:String):
	texto = _texto
	sound = _sound
	character = _character 
	background = _background
	backgroundSound =  _backgroundSound

func hasBackgroundSound():
	return backgroundSound != ""
