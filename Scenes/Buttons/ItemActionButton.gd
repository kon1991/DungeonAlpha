extends "res://Scenes/Buttons/ActionButton.gd"

# Declare member variables here. Examples:
# var a = 2
# var b = "text"

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

func _on_pressed():
	main.buttonContainer.visible = false
	main.itemContainer.visible = true
	main.backButton.visible = true