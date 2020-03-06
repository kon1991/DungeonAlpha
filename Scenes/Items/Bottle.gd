extends "res://Scenes/Buttons/ActionButton.gd"

var itemName = "Bottle"

func _ready():
	pass # Replace with function body.

func _on_pressed():
	#._on_pressed(main.itemContainer)
	main.disable_buttons(main.itemContainer)
	#chance for powerful effect
	player.set_array_text(["You try to drink but alas...", "The bottle is empty"])
	yield(textBox, "end_player_text")
	main._on_BackButton_pressed()
	emit_signal("end_turn")
