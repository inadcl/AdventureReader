class_name MouseController  # Esto registra tu clase para que esté disponible globalmente.
extends Timer
var isActive = true
var action = 0
var previous_time:int = 0 
var arrowImage = true 
var isMouseBlocked = true
var nodoImage 
var arrowTexture = preload("res://images/ui/flecha.png")
var actionTexture = preload("res://images/ui/lupa.png")
var nextSceneAllowed = true

func _init(nodo):
	nodoImage=nodo
	changeArrowVisibilityTo(false)
	setArrowImage()
	
func blockMouse():
	isMouseBlocked = true
	changeArrowVisibilityTo(false)
	
	
func changeArrowVisibilityTo(visibility:bool):
	nodoImage.visible = visibility

func setArrowImage(): 
	nodoImage.texture = arrowTexture
	
	
func setActionImage():
	nodoImage.texture = actionTexture
 
func isMouseActive():
	return !isMouseBlocked 

func _on_action_timeout():
	setActionImage()
	changeArrowVisibilityTo(true)
	isMouseBlocked = false

func _on_arrow_timeout():
	setArrowImage()
	changeArrowVisibilityTo(true)
	isMouseBlocked = false
	

func setIsNextSceneAllowed(value: bool):
	nextSceneAllowed = value
	
func isNextSceneAllowed():
	return nextSceneAllowed
	
func _on_ready():
	print("timer ready")
	pass # Replace with function body.
