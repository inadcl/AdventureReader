extends Node2D
#personaje que habla, el texto, el sonido - cambia el background 
	# Crear una nueva instancia de Action con los recursos precargados. 
var listOfActions = []
var actualAction = 0
var listOfButtons = []
var alreadyDraw = false
var alreadyEnded= false
# Called when the node enters the scene tree for the first time.
func _ready():
	pass

func init():
	listOfActions = RM.loadActionList("level3", "3");
	
	if len(listOfActions) >0 and listOfActions[actualAction].hasEvent():
				print("PINTANDOIMAGEN_a")
				var event = listOfActions[actualAction].getEvent()
				print(event.nombre)
				for buttonAction in event.optionAction:
					if buttonAction is EventOption:
						var eventImage = buttonAction.eventImage 
						print("PINTANDOIMAGEN")
						if not buttonAction.completed:
							listOfButtons.append(buttonAction)
							var texture_button = TextureButton.new()
							var texture_path = "res://events/level3/"+ eventImage.imagePath
							var texture = load(texture_path)
							if texture:
								texture_button.texture_normal = texture
							else:
								print("La textura no pudo cargarse desde:", texture_path)
							
							texture_button.position = Vector2(eventImage.xPos, eventImage.yPos)  # Posición en x, y
							texture_button.custom_minimum_size  = Vector2(eventImage.xSize, eventImage.ySize)  # Ancho y alto

							# Ajusta la escala del TextureButton
							texture_button.scale = Vector2(eventImage.scale, eventImage.scale)
							texture_button.visible = true
							texture_button.set_visibility_layer(2)
							texture_button.z_index = 2
							texture_button.name = str(buttonAction.optionAction.id)
							var callable3 = Callable(self, "_on_button_down").bind(texture_button)
							texture_button.connect("button_down", callable3)
							SceneManager.addChildFromScene(texture_button)
							print(texture_button.is_visible_in_tree())
	
func mouseTimeout(controller:MouseController):
	print("desbloqueado")
	if listOfActions[actualAction].hasEvent():
		controller._on_action_timeout()
	else:
		controller._on_arrow_timeout() 

func allItemsCollected():
	var isNextSceneAllowed = true
	for button in listOfButtons:
		if not button.completed:
			isNextSceneAllowed = false
	return isNextSceneAllowed

func isSceneClickable(controller:MouseController):
	var isNextSceneAllowed = allItemsCollected()
	controller.setIsNextSceneAllowed(isNextSceneAllowed)
	
func mouseHit(controller:MouseController):
	print("blockear raton")
	controller.blockMouse()
	pass
	
func hasEnded(actualAction:int):
	if actualAction==0 and not alreadyDraw:
		return false
	elif (actualAction == 0) and allItemsCollected():
		return true
	
	
func next_step(_actualAction: int, isActive: bool, hitSound: AudioStreamPlayer2D):
	print("CLICK ON NEXT STEP"+ str(actualAction))
	actualAction = _actualAction 
	
	#if not alreadyDraw:
							#texture_button.rect_position = Vector2(imageXPos, imageYPos)
							#texture_button.rect_size = Vector2(1024, 1024)
							#texture_button.rect_scale = Vector2(imageScale, imageScale)
	
	if not alreadyDraw and isActive:
		hitSound.play()
		print("ActualAction: "+str(actualAction))
		var activeAction = listOfActions[actualAction]
		SceneManager.renderStep(activeAction) 
		if (allItemsCollected()):
			alreadyDraw = true
	return actualAction


func _on_button_down(texturebutton : TextureButton):
	texturebutton.visible = false
	var sceneAction
	for button in listOfButtons:
		if str(button.optionAction.id) == texturebutton.name:
			button.completed = true
			sceneAction = button.nextSceneAction
			SceneManager.updateAction(button.optionAction)
	
	isSceneClickable(SceneManager.mouseController)
		
	
	if (allItemsCollected()):
		listOfActions = []
		listOfActions.append(sceneAction)
	
		
	
