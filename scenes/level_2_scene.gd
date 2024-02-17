extends Node2D
#personaje que habla, el texto, el sonido - cambia el background 
	# Crear una nueva instancia de Action con los recursos precargados. 
var listOfActions = []
# Called when the node enters the scene tree for the first time.
func _ready():
	pass
	
func init():
	listOfActions = RM.loadActionList("level2", "2");
	
func mouseTimeout(controller:MouseController):
	print("desbloqueado")
	controller._on_arrow_timeout() 
	
func mouseHit(controller:MouseController):
	print("blockear raton")
	controller.blockMouse()
	pass
	
func hasEnded(actualAction:int):
	if actualAction==0:
		return false
	return actualAction == len(listOfActions)
	
	
func next_step(actualAction: int, isActive: bool, hitSound: AudioStreamPlayer2D):
	if isActive:
		hitSound.play()
		print("ActualAction: "+str(actualAction))
		var activeAction = listOfActions[actualAction]
		SceneManager.renderStep(activeAction)
		return actualAction+1
	return actualAction

