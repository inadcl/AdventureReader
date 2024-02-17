class_name EventImage

var imagePath
var scale
var xPos
var yPos
var xSize
var ySize

func _init(
_imagePath: String, _xPos: int, _yPos:int, _scale:float, _xSize:int, _ySize:int):
	imagePath=_imagePath
	scale = _scale
	xPos = _xPos
	yPos = _yPos
	xSize = _xSize
	ySize = _ySize
