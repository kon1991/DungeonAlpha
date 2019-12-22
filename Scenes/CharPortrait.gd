extends PanelContainer

onready var texture = $TextureRect

func _ready():
	if(Global.player_character!=null):
		var player_texture = load("res://Images/SelectImages/Portraits/"+Global.player_character+".png")
		print("XXXXXXXXXXXXXXXXXX")
		texture.texture = player_texture
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
