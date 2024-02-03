extends Node2D
#personaje que habla, el texto, el sonido - cambia el background 
	# Crear una nueva instancia de Action con los recursos precargados. 
var listOfActions = []
var actualAction = 0
# Called when the node enters the scene tree for the first time.
func _ready():
	pass
	
func mouseTimeout(controller:MouseController):
	print("desbloqueado")
	if listOfActions[actualAction].hasEvent():
		controller._on_action_timeout()
	else:
		controller._on_arrow_timeout() 
	
func mouseHit(controller:MouseController):
	print("blockear raton")
	controller.blockMouse()
	pass
	
func hasEnded(actualAction:int):
	if actualAction==0:
		return false
	return actualAction == len(listOfActions)
	
	
func next_step(_actualAction: int, isActive: bool, hitSound: AudioStreamPlayer2D):
	actualAction = _actualAction
	if isActive:
		if len(listOfActions) >0 and listOfActions[actualAction].hasEvent():
			print(listOfActions[actualAction].getEvent().nombre)
		else:
			hitSound.play()
			listOfActions = RM.loadActionList("level3", "3");
			var activeAction = listOfActions[actualAction]
			SceneManager.renderStep(activeAction)
			actualAction=actualAction+1
	return actualAction

