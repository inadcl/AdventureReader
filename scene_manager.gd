extends Node2D

	
var actualScene
# Called when the node enters the scene tree for the first time.
var actualPosition = 0
var scene_manager_scene = preload("res://scenes/skell_scene.tscn")
var scene_level_1 = preload("res://scenes/level_1_scene.tscn") 
var scene_level_2 = preload("res://scenes/level_2_scene.tscn") 
var scene_level_3 = preload("res://scenes/level_3_scene.tscn") 
#todo Corregir orden
var scenes_by_order = [scene_level_1, scene_level_2, scene_level_3]
var actualScenePosition = 0
	
var	audioBackgroundSkell
var	backgroundTextureSkell
var	characterTextureSkell
var	textSkell
var	audioVoiceSkell

var last_mouse_position: Vector2 = Vector2()
var time_since_last_move: float = 0.0
var is_mouse_stopped: bool = false
var stop_threshold: float = 1  # 2 milisegundos
var texture_button_mouse_control : TextureButton
var path_de_la_textura = ""
var position_to_show_text: Vector2 = Vector2()
var mouseController:MouseController
var audioHitSkell:AudioStreamPlayer2D
	
func loadResources():
	audioBackgroundSkell = get_tree().get_root().get_node("SkellScene/CanvasLayer/AudioStreamPlayer")
	backgroundTextureSkell = get_tree().get_root().get_node("SkellScene/CanvasLayer/BackgroundTextureRect")
	characterTextureSkell = get_tree().get_root().get_node("SkellScene/CanvasLayer/ControlsPanel/CharacterTextureRect")
	textSkell = get_tree().get_root().get_node("SkellScene/CanvasLayer/ControlsPanel/CharacterRichText") 
	audioVoiceSkell = get_tree().get_root().get_node("SkellScene/CanvasLayer/AudioVoice")
	audioHitSkell = get_tree().get_root().get_node("SkellScene/CanvasLayer/clickSound")
	
	
func _ready():
	var skellScene = get_tree().get_root().get_node("SkellScene/CanvasLayer")
	print(skellScene)
	loadResources()
	mouseDelayInit()
	#recordar cambiar a escena 1
	cambiar_escena(scenes_by_order[actualScenePosition])

	
func mouseDelayInit():
	var image = get_tree().get_root().get_node("SkellScene/CanvasLayer/MouseTextureRect")
	mouseController = MouseController.new(image)
	
	
	
func cambiar_escena(scene):
	var new_scene = scene.instantiate()
	#get_tree().root.add_child(new_scene)  # Añadir la nueva escena al árbol
	# Opcional: eliminar la escena actual si ya no es necesaria
	if actualScene != null:
		actualScene.queue_free()  
	actualScene = new_scene  # Establecer la nueva escena como la actual
	nextStep(true)
	
func nextStep(isActive:bool):
	print(actualPosition)
	if actualScene.hasEnded(actualPosition):
		actualPosition=0
		actualScenePosition = actualScenePosition + 1
		cambiar_escena(scenes_by_order[actualScenePosition])
		
	actualPosition = actualScene.next_step(actualPosition, isActive, audioHitSkell)
	actualScene.mouseHit(mouseController)	
		

func buttonTimeout():
	actualScene.mouseTimeout(mouseController)
	
func renderStep(actualAction: Action): 
	var sound = actualAction.sound
	if actualAction.hasBackgroundSound():	
		var backgroundSound = actualAction.backgroundSound
		play_audio(audioBackgroundSkell, backgroundSound)
		#todo start audio
	var characterTexture = actualAction.character
	var backgroundTexture = actualAction.background
	#get_node(sound).play() 
	
	backgroundTextureSkell.texture = load(backgroundTexture)
	characterTextureSkell.texture = load(characterTexture)
	
	textSkell.text = actualAction.texto
	
	play_audio(audioVoiceSkell, sound)
	  

func play_audio(media, audio_path):
	var stream = load(audio_path)
	if stream:
		media.stream = stream
		media.play()
	


func _on_button_down():
	print("click1")
	nextStep(mouseController.isMouseActive())
#
#func _on_button_up():
	#var node = get_node("ImagenAmpliada")
	#node.visible = false
#
#func _on_mouse_entered(texturebutton : TextureButton):
	#print(texturebutton.name)
	#texture_button_mouse_control = texturebutton
	#
	#var textura_a = texturebutton.texture_normal
	#
	## Obtener la ruta de la textura
	#path_de_la_textura = textura_a.resource_path
	#
	#position_to_show_text = get_viewport().get_mouse_position()
#
 #
## Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
	#var current_mouse_position = get_viewport().get_mouse_position()
	#if current_mouse_position != last_mouse_position:
		#is_mouse_stopped = false
		#time_since_last_move = 0.0
		#last_mouse_position = current_mouse_position
	#else:
		#time_since_last_move += delta
		#if time_since_last_move >= stop_threshold:
			#is_mouse_stopped = true
			#if path_de_la_textura != "" && texture_button_mouse_control.get_rect().has_point(current_mouse_position):
				#var nueva_textura = load(path_de_la_textura)
							## Asignar la textura al nuevo nodo
				#var node = get_node("ImagenAmpliada")
#
#
				## Asigna la nueva textura al nodo TextureRect 
				#node.texture = nueva_textura
				##node.texture.sca(Vector2(nueva_textura.get_width() * 0.5, nueva_textura.get_height() * 0.5))
				#node.visible = true
			#
				#get_node("Timer").start()
				

func _on_mouse_exit():
	var node = get_node("ImagenAmpliada")
	node.visible=false

func _on_timer_timeout():
	var node = get_node("ImagenAmpliada")
	node.visible = false
