extends "res://Scenes/EnemyStats.gd"

onready var monsterName = "Doug"
onready var monsterDamage = 2
onready var monsterMood = "Friend"
onready var monsterHP = 20
onready var specials = []
onready var monsterTags = []
onready var interactions = ["Shake", "Refuse"]

onready var Reward = load("res://Reward.gd")

var appear = false
var hurt = false

func _ready():
	set_stats(monsterName, monsterDamage, monsterHP, monsterMood)
#	greet()
	sprite.scale = Vector2(1,1)

func take_turn():
	attack()
	
func attack():
	set_text("DOG")
	yield(textBox, "end_enemy_text")
	emit_signal("end_turn")
	
# text order gets fucked.
func set_hp(new_hp, type="phys"):
	.set_hp(new_hp)
	
func greet():
	set_text("A totally normal person appears from the darkness!")
	yield(textBox, "end_enemy_text")
	set_text("\"Hello, I'm Doug, how are you?\"")
	animationPlayer.play("talk")
	yield(textBox, "end_enemy_text")
	animationPlayer.stop()
	set_text("Shake his hand?")
	main.buttonContainer.visible = false
	main.interactContainer.visible = true
	main.get_interactions()
	player.player_turn = true
	yield(main, "interactionPropagation")
	player.player_turn = false
	main.disable_buttons()
	if(main.current_interact == "Shake"):
		
		player.set_hp(-8)
		set_array_text(["As you move to shake his hand Doug splits in half and bites you!", "Doug is a mimic!"])
		yield(textBox, "end_enemy_text")
		animationPlayer.play("appear")
		appear = true
	elif(main.current_interact == "Refuse"):
		set_text("You refuse. Doug looks sad")
		yield(textBox, "end_enemy_text")
		set_text("\"Why friend? :(\"")
		animationPlayer.play("talk")
		yield(textBox, "end_enemy_text")
		animationPlayer.stop()
	
	main.buttonContainer.visible = true
	main.interactContainer.visible = false
	emit_signal("greet_over")