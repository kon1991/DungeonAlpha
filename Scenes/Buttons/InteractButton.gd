extends "res://Scenes/Buttons/ActionButton.gd"

signal interaction

func _on_pressed():
	._on_pressed()
	emit_signal("interaction", text)
#	player.player_turn = false
