extends PanelContainer

onready var texture = $TextureRect

func _ready():
#	if(Global.player_character!=null):
#		var player_texture = load("res://Images/SelectImages/Portraits/"+Global.player_character+".png")
#		texture.texture = player_texture
	pass

func load_portrait():
	var player_texture = load("res://Images/SelectImages/Portraits/"+Global.player_character+".png")
	texture.texture = player_texture

