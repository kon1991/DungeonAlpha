extends Node

onready var textBox = $UI/TextContainer/TextBox
onready var tween = $Tween
onready var UI = $UI
onready var shrineSprite = $Shrine
onready var fade = $FADE
onready var buttonContainer = $UI/CenterContainer/ButtonContainer
onready var yesButton = $UI/CenterContainer/ButtonContainer/YesButton
onready var noButton = $UI/CenterContainer/ButtonContainer/NoButton
onready var animationPlayer = $AnimationPlayer
onready var mapScreen = get_tree().current_scene.find_node("Map")
onready var background = $TextureRect
func _ready():
	pass
	
func shrineStart():
	textBox.text = ""
	animationPlayer.play("fadeIn")
	set_visible(true)
	yield(animationPlayer,"animation_finished")
	textBox.set_array_text(["You come across an ancient shrine.", "Ancient runes of an unknown language glow red in the light of the dungeon",
						"On closer inspection you realize they are written with fresh blood.", "As you look at them you hear War drums beat in your head",
						"Pray at the altar of War?"], "player")
	yield(textBox, "end_player_text")
	
	yesButton.set_disabled(false)
	noButton.set_disabled(false)
	tween.interpolate_property(buttonContainer, "modulate", 
  		null, Color(1, 1, 1, 1), 2.0, 
  		Tween.TRANS_LINEAR, Tween.EASE_IN)
	tween.start()


func _on_YesButton_pressed():
	tween.interpolate_property(buttonContainer, "modulate", 
      		null, Color(1, 1, 1, 0), 2.0, 
      		Tween.TRANS_LINEAR, Tween.EASE_OUT)
	tween.start()
	yesButton.set_disabled(true)
	noButton.set_disabled(true)
	textBox.set_array_text(["The Shrine pulses with crimson energy", "It demands the blood of your enemies!"], "player")
	yield(textBox, "end_player_text")
	animationPlayer.play("fadeOut")
	textBox.text = ""
	yield(animationPlayer, "animation_finished")
	go_to_map()
	pass # Replace with function body.


func _on_NoButton_pressed():
	tween.interpolate_property(buttonContainer, "modulate", 
      		null, Color(1, 1, 1, 0), 2.0, 
      		Tween.TRANS_LINEAR, Tween.EASE_OUT)
	tween.start()
	yesButton.set_disabled(true)
	noButton.set_disabled(true)
	textBox.set_array_text(["You leave the shrine alone and continue on your way"], "player")
	yield(textBox, "end_player_text")
	animationPlayer.play("fadeOut")
	textBox.text = ""
	
	yield(animationPlayer, "animation_finished")
	go_to_map()
	pass # Replace with function body.

func go_to_map():
	set_visible(false)
	mapScreen.animationPlayer.play("fadeIn")
	mapScreen.set_visible(true)
	yield(mapScreen.animationPlayer, "animation_finished")
	
func set_visible(value):
	UI.set_visible(value)
	fade.visible = value
	shrineSprite.visible = value
	background.visible = value
	print(value)
