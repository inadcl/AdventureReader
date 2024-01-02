extends Node2D

	
var actualScene
# Called when the node enters the scene tree for the first time.
var actualPosition = 0
var scene_manager_scene = preload("res://scenes/skell_scene.tscn")
var scene_level_1 = preload("res://scenes/level_1_scene.tscn") 
func _ready():
	var skellScene = get_tree().get_root().get_node("SkellScene/CanvasLayer")
	print(skellScene)
	
	cambiar_escena(scene_level_1)
	pass
	#var new_scene_resource: PackedScene
	#new_scene_resource = preload("res://scenes/level_1_scene.tscn")
	#var first_scene = new_scene_resource.instantiate()
	#loaded_scene = first_scene
	#nextStep()
	
	
func cambiar_escena(scene):
	var new_scene = scene.instantiate()
	#get_tree().root.add_child(new_scene)  # Añadir la nueva escena al árbol
	# Opcional: eliminar la escena actual si ya no es necesaria
	if actualScene != null:
		actualScene.queue_free()  
	actualScene = new_scene  # Establecer la nueva escena como la actual
	nextStep()
	
func nextStep():
	print(actualPosition)
	actualScene.next_step(actualPosition)
	actualPosition = actualPosition+1
	
	
func renderStep(actualAction: Action):
	var sound = actualAction.sound
	if actualAction.hasBackgroundSound():	
		var audioBackgroundSkell = get_tree().get_root().get_node("SkellScene/CanvasLayer/AudioStreamPlayer")
		var backgroundSound = actualAction.backgroundSound
		play_audio(audioBackgroundSkell, backgroundSound)
		#todo start audio
	var characterTexture = actualAction.character
	var backgroundTexture = actualAction.background
	#get_node(sound).play() 
	
	var backgroundTextureSkell = get_tree().get_root().get_node("SkellScene/CanvasLayer/BackgroundTextureRect")
	backgroundTextureSkell.texture = load(backgroundTexture)
	
	var characterTextureSkell = get_tree().get_root().get_node("SkellScene/CanvasLayer/ControlsPanel/CharacterTextureRect")
	characterTextureSkell.texture = load(characterTexture)
	
	var textSkell = get_tree().get_root().get_node("SkellScene/CanvasLayer/ControlsPanel/CharacterRichText")
	textSkell.text = actualAction.texto
	
	var audioBackgroundSkell = get_tree().get_root().get_node("SkellScene/CanvasLayer/AudioStreamPlayer")
	var audioVoiceSkell = get_tree().get_root().get_node("SkellScene/CanvasLayer/AudioVoice")
	play_audio(audioVoiceSkell, sound)
	  

func play_audio(media, audio_path):
	var stream = load(audio_path)
	if stream:
		media.stream = stream
		media.play()
	


func _on_button_down():
	print("click")
	nextStep()
	


func _on_button_up():
	print("click")
	nextStep()
