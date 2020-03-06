extends "res://Scenes/Buttons/ActionButton.gd"

func _ready():
	pass # Replace with function body.

func _on_pressed():
	._on_pressed()
	player.set_hp(4)
	main.disable_buttons(main.actionContainer)
	player.set_text("You heal yourself")
	yield(textBox, "end_player_text")
	main._on_BackButton_pressed()
	emit_signal("end_turn")
