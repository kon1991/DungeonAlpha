extends "res://Scenes/Buttons/ActionButton.gd"

func _ready():
	pass # Replace with function body.

func _on_pressed():
	._on_pressed()
	main.buttonContainer.visible = false
	main.actionContainer.visible = true
	main.backButton.visible = true
