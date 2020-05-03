extends "res://Scenes/Buttons/ActionButton.gd"

onready var spell = ""

func _on_pressed():
	._on_pressed()
	if enemy.mood != "???":
		player.set_text("There is no spell to counter!")
		main._on_BackButton_pressed()
	else:
		
		main.disable_buttons(main.specialContainer)
		player.set_array_text(["You begin to chant a counter spell!"])
		yield(textBox, "end_player_text")
#		main.specialContainer.visible = false
#		enemy.interactions = ["Zho", "Vhag"]
#
#		main.interactContainer.visible = true
#		main.get_interactions()
#		yield(main, "interactionPropagation")
		main.animationPlayer.play("magic")
		yield(main.animationPlayer, "animation_finished")
#		main.disable_buttons(main.interactContainer)
#		textBox.set_text_with_origin(main.current_interact, "player")
#		spell += main.current_interact
#		yield(textBox, "end_player_text")
#		main.free_buttons(main.interactContainer)
#
#		enemy.interactions = ["Gha", "Nor"]
#		main.get_interactions()
#		yield(main, "interactionPropagation")
		main.animationPlayer.play("magic-2")
		
		yield(main.animationPlayer, "animation_finished")
#		main.disable_buttons(main.interactContainer)
#		textBox.set_text_with_origin(main.current_interact, "player")
#		spell += main.current_interact
#		yield(textBox, "end_player_text")
#		main.free_buttons(main.interactContainer)
#
#		enemy.interactions = ["LOR!", "ROG!"]
#		main.get_interactions()
#		yield(main, "interactionPropagation")
		main.animationPlayer.play("magic-3")
		
		yield(main.animationPlayer, "animation_finished")
#		main.disable_buttons(main.interactContainer)
#		textBox.set_text_with_origin(main.current_interact, "player")
#		spell += main.current_interact
#		yield(textBox, "end_player_text")
#		if spell == "ZhoGhaLOR!":
#			textBox.set_text_with_origin("\"ZhoGhalLor!\" you shout and counter the magical energies!", "player")
		enemy.mood = "Sad"
		enemy.vanish = false
#			yield(textBox, "end_player_text")
		main._on_BackButton_pressed()
		
		emit_signal("end_turn")
		