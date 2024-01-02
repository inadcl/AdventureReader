extends Node
 
const pathBackgroundMusic = "res://sounds/background/"
const pathEffects = "res://sounds/effects/"
const pathImagesBackground="res://images/backgrounds/" #+level
const pathAvatars="res://images/avatars/"
const pathVoices="res://sounds/voices/"#+level + lang
const leveldir=""
  
const spanish = "es"
const asturian = "as"
const portuguesse = "pt"
const english = "en"
var activeLang= spanish

func loadActionList(levelpath: String, level: String):
	var listOfActions = {}
	var actions = filterLevel(load_csv_data("res://GameSources/actions.csv"), "action", level)
	var mappedActions = map_csv_to_dict_by_id(actions, "action")
	var actionDialogs = filterLevel(load_csv_data("res://GameSources/action_dialog.csv"),"action_dialog", level)
	var mappedActionDialogs = map_csv_to_dict_by_id(actionDialogs, "action_dialogs")
	
	var dialogs =  filterLevel(load_csv_data("res://GameSources/dialogs_"+activeLang+".csv"), "", level)
	var mappedDialogs = map_csv_to_dict_by_id(dialogs, "action_dialogs")
	
	#Ahora el action dialog esta funcionando con posiciones porque todo es 1,1, pero deberiamos de hacer un diccionario posicion,contenido segun el id.
	var count = 0
	for actionDialog in actionDialogs:
		var soundFilename = actionDialog[5]
		var actionSound = pathVoices+levelpath+"/"+activeLang+"/"+soundFilename
		
		var actionId = actionDialog[0]
		var textId = actionDialog[1] 
		var action = mappedActions[actionId]
		var dialog = mappedDialogs[textId]
		var avatar = action[0]
		var fondo = action[1]
		var hasBackgroundSound = action[2]
		var backgroundSound = action[3]
		var texto = dialog[0]
		
		var avatarActionPath = pathAvatars+avatar
		var fondoActionPath = pathImagesBackground+levelpath+"/"+fondo
		var backgroundSoundPath = ""
		if hasBackgroundSound:
			backgroundSoundPath = pathBackgroundMusic+backgroundSound
			
		
		
		var newAction = Action.new(texto, actionSound, avatarActionPath, fondoActionPath, backgroundSoundPath)
		listOfActions[count] = newAction
		count= count+1
		
	if(len(listOfActions)==0):
		print("error - no existen acciones")
	return listOfActions
	
	
func load_csv_data2(path):
	var data = []
	var file = FileAccess.open(path,FileAccess.READ)
	
	var lines = file.get_as_text().split("\n")  # Divide el texto del archivo en líneas
	var count = 0
	for line in lines:
		if count==0:
			count=count+1
			continue
		var row = line.split(";")  # Asumiendo que las comas son el separador
		data.append(row)

	file.close()  # No olvides cerrar el archivo
	return data 
	
func load_csv_data(path):
	var data = []
	var file = FileAccess.open(path, FileAccess.READ)
	
	var lines = file.get_as_text().split("\n")  # Divide el texto del archivo en líneas
	var count = 0
	for line in lines:
		if count==0:
			count=count+1
			continue
		var row = parse_csv_line(line)
		data.append(row)

	file.close()  # No olvides cerrar el archivo
	return data

func parse_csv_line(line):
	var inside_quotes = false
	var elements = []
	var current_element = ""
	
	for i in range(line.length()):
		var char = line[i]
		
		if char == '"' and (i == 0 or line[i-1] != '\\'):
			inside_quotes = !inside_quotes
			continue  # No añadir el carácter de comillas al elemento
		
		if char == ',' and not inside_quotes:
			# Fin del elemento actual
			elements.append(current_element)
			current_element = ""
		else:
			current_element += char
	
	# Añadir el último elemento
	elements.append(current_element)
	return elements

func filterLevel(data, type, level):
	var new_data = []
	for row in data:
		if type == "action":
			if row[7].replace("\r","") == level:
				new_data.append([row[0], row[1], row[2], row[3], row[4], row[5], row[6], row[7].replace("\r","")])
		elif type == "action_dialog":
			if row[4].replace("\r","") == level:
				new_data.append([row[0], row[1], row[2], row[3], row[4], row[5].replace("\r","")])
		else:
			if row[2].replace("\r","") == level:
				new_data.append([row[0], row[1].replace("\r","")])
	return new_data
		 
		
		
func map_csv_to_dict_by_id(data, type):
	var new_data = {}
	for row in data:
		if type == "action":
			new_data[row[0]] = [row[1], row[2], row[3], row[4], row[5], row[6], row[7]]
		elif type == "action_dialog":
			new_data[row[0]] = [row[1], row[2], row[3], row[4], row[5]]
		else:
			new_data[row[0]] = [row[1]]
	return new_data
