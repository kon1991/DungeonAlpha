extends "res://Scenes/Buttons/ActionButton.gd"

onready var Reward = load("res://Reward.gd")

func _process(delta):
	if(enemy.mood == "Hungry"):
		text = "Feed"

func _on_pressed():
	._on_pressed()
	main.disable_buttons(main.specialContainer)
	if(text == "Pet"):
		player.set_array_text(["You pet the Tick", "It kinda likes it"])
		yield(textBox, "end_player_text")
		emit_signal("end_turn")
	else:
		if(player.inventory.has("S_Potion")):
			enemy.hearts.set_emitting(true)
			player.set_array_text(["You feed the Tick", "It's attached now..."])
			yield(textBox, "end_player_text")
			main.change_inventory("S_Potion")
			#player.inventory.append("Tick")
			### create_custom reward in main
			var newReward = Reward.new(0, 1, "Tick")
			main.new_rewards.append(newReward)
			main.change_inventory("Bottle", false)
			main._on_Enemy_died(false)
		else:
			player.set_text("You have nothing to feed the Tick")
			yield(textBox, "end_player_text")
			emit_signal("end_turn")
	main._on_BackButton_pressed()
	
