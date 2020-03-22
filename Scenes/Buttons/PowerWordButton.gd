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
	main.disable_buttons()
	textInput.clear()
	text = text.to_upper()
	
	match text:
		"KILL":
			if(player.mp >= 10):
				mp_enough = true
				player.set_mp(-10)
				if(!enemy.has_tag("Kill_Immune")):
					player.set_text("Dark Energy engulfs the " + enemy.mname)
					enemy.set_hp(-enemy.max_hp)
				else:
					player.set_array_text(["Your magic backfires!", "\"FOOL!\"", "\"THE DARK OBEYS ME\""])
					yield(textBox, "end_player_text")
					player.set_hp(-player.hp)
		"HEAL":
			if(player.mp >= 3):
				mp_enough = true
				player.set_mp(-3)
				player.set_text("Your wounds mend themselves")
				player.set_hp(5)
		"PAIN":
			if(player.mp >= 3):
				mp_enough = true
				player.set_mp(-3)
				player.set_text("The " + enemy.mname + " writhes in pain")
				enemy.set_hp(-7, "dark")
		_:
			mp_enough = true
			player.set_text("You mumble gibberish")
	if(!mp_enough):
		player.set_text("You don't have enough mana")
	mp_enough = false
	yield(textBox, "end_player_text")
	emit_signal("end_turn")	
	
