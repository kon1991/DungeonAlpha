extends "res://Scenes/Buttons/ActionButton.gd"


func _ready():
	
	pass # Replace with function body.

func _on_pressed():
	._on_pressed()
#	player.player_turn = false
	print(enemy)
	player.set_text("You clobber the "+enemy.mname)
	enemy.set_hp(-(player.damage + player.damage_mod))
	print("YOU DID DAMAGE = " + str(player.damage + player.damage_mod))
	yield(textBox, "end_player_text")
	emit_signal("end_turn")
	