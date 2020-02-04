extends "res://Scenes/Buttons/ActionButton.gd"

onready var textInput = main.textInput
var mp_enough = false

func _ready():
	
	textInput.connect("text_entered", self, "_on_text_entered")
	pass # Replace with function body.

func _on_pressed():
	._on_pressed()
	main.buttonContainer.visible = false
	main.actionContainer.visible = false
	main.textInput.visible = true
	main.textInput.grab_focus()
	main.backButton.visible = true

func _on_text_entered(text):
	main._on_BackButton_pressed()
	textInput.clear()
	text = text.to_upper()
	
	match text:
		"KILL":
			if(player.mp >= 10):
				mp_enough = true
				player.set_mp(-10)
				player.set_text("Dark Energy engulfs the " + enemy.mname)
				enemy.set_hp(-10)
		"HEAL":
			if(player.mp >= 3):
				mp_enough = true
				player.set_mp(-3)
				player.set_text("Your wounds mend themselves")
				player.set_hp(5)
		_:
			mp_enough = true
			player.set_text("You mumble gibberish")
	if(!mp_enough):
		player.set_text("You don't have enough mana")
	mp_enough = false
	yield(textBox, "end_player_text")
	emit_signal("end_turn")	
	