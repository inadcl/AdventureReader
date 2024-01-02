extends Node2D

#personaje que habla, el texto, el sonido - cambia el background 

	# Crear una nueva instancia de Action con los recursos precargados. 

var listOfActions = []
# Called when the node enters the scene tree for the first time.
func _ready():
	pass
	

func next_step(actualAction: int):
	listOfActions = RM.loadActionList("level1", "1");
	var activeAction = listOfActions[actualAction]
	SceneManager.renderStep(activeAction)

