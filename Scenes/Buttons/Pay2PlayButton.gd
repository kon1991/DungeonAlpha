extends "res://Scenes/Buttons/ActionButton.gd"

func _on_pressed():
	._on_pressed()
	main.disable_buttons(main.specialContainer)
	if enemy.spin == false:
		player.gold -= 10
		player.set_array_text(["You feed the Box some gold"])
		enemy.spin = true
		yield(textBox, "end_player_text")
	else:
		player.set_text("The box is already sated")
		yield(textBox, "end_player_text")
	emit_signal("end_turn")
	main._on_BackButton_pressed()