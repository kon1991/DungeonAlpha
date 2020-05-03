extends "res://Scenes/Buttons/ActionButton.gd"


func _on_pressed():
	._on_pressed()
	main.disable_buttons(main.actionContainer)
	player.set_text("You open your third eye, to see the nature of your enemy...")
	player.set_array_text(Scry.get_scry(enemy.mname))
	yield(textBox, "end_player_text")
	emit_signal("end_turn")
	main._on_BackButton_pressed()