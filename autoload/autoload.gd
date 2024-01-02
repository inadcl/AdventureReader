extends Node

var my_timer = Timer.new()  # Crea una instancia de Timer.
var blockMouse = true
var arrowImage = true
var root = "/root/MainMenu/"


func changeScene():
	pass
	#nueva escena




func loadScene(Actions):
	pass

func createTimer():
	add_child(my_timer)  # Agrega el Timer como un hijo del autoload.
	my_timer.wait_time = 1  # Configura el tiempo de espera a 10 segundos.
	my_timer.autostart = true  # Inicia automáticamente el Timer.
	var callable2 = Callable(self, "_on_Timer_timeout")
	my_timer.connect("timeout", callable2)
	 
	 
	
func _ready():
	createTimer() 

func changeArrowVisibilityTo(visibility:bool):
	var image = get_node(root+"test")
	image.visible = visibility
	
func setArrowImage(arrowImage): 
	var texture_rect = get_node(root+"test")
	if arrowImage:
		texture_rect.texture = preload("res://images/ui/flecha.png")
	else:
		texture_rect.texture = preload("res://images/ui/lupa.png")
	
func _on_Timer_timeout():
	changeArrowVisibilityTo(true)
	blockMouse = false
