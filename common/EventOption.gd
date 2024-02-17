class_name EventOption  # Esto registra la clase Accion para que sea accesible globalmente.

var nombre := ""
var nextSceneId := ""  # Puede ser una ruta a un archivo de audio o una referencia a un AudioStream.
var completed:= false
var sceneActionTrigger = null
var nextSceneAction = null
var optionAction = null
var level:String
var type:String
var eventImage

func _init(_nombre: String, _sceneActionTrigger:Action, _nextSceneAction : Action,_type : String, 
_optionAction: Action,
 _level:String, 
_eventImage:EventImage):
	nombre = _nombre
	sceneActionTrigger = _sceneActionTrigger
	nextSceneAction = _nextSceneAction
	optionAction = _optionAction
	level = _level
	type = _type 
	eventImage = _eventImage
	

func hasEnded():
	return completed
