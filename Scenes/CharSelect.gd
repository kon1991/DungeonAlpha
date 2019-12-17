extends PanelContainer

export(Texture) var normalTexture
export(Texture) var hoverTexture
export(String) var charName
export(String) var description
onready var charButton = $CharButton

func _ready():
	charButton.texture_normal = normalTexture
	print("ready")
	charButton.texture_hover = hoverTexture

func _on_CharButton_pressed():
	Global.player_character = charName
	Global.goto_scene("res://Scenes/BattleScreen.tscn")
	pass # Replace with function body.


func _on_CharButton_mouse_entered():
	var main = get_tree().current_scene
	var charNameLabel = main.find_node("CharName")
	var charDescriptionLabel = main.find_node("CharDesc")
	charNameLabel.text = charName
	charDescriptionLabel.text = description
	pass # Replace with function body.
