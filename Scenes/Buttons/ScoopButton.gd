extends "res://Scenes/Buttons/ActionButton.gd"


onready var Reward = load("res://Reward.gd")


func _on_pressed():
	._on_pressed()
	main.disable_buttons(main.specialContainer)
	if(player.inventory.has("Bottle")):
		enemy.set_hp(-5)
		var newReward
		if(enemy.mname == "Blobby"):
			player.set_array_text(["You scoop part of blobby in the bottle!", "It recoils in horror!"])
			enemy.change_sprite()
			yield(textBox, "end_player_text")
			main.change_inventory("Bottle")
			newReward = Reward.new(0, 1, "Acid_Vial")
		elif(enemy.mname == "DragonPoop"):
			player.set_array_text(["You scoop the poop in the bottle!", "It recoils in horror!"])
#			enemy.change_sprite()
			yield(textBox, "end_player_text")
			main.change_inventory("Bottle")
			newReward = Reward.new(0, 1, "Poop_Bottle")
		main.new_rewards.append(newReward)
	else:
		player.set_hp(-2)
		if(enemy.mname == "Blobby"):
			player.set_array_text(["You have nothing to scoop with!", "The slime burns your hands!"])
		elif(enemy.mname == "DragonPoop"):
			player.set_array_text(["You have nothing to scoop with!", "Your hands are full of poop", "Why did you do this?"])
		yield(textBox, "end_player_text")
	emit_signal("end_turn")
	main._on_BackButton_pressed()
