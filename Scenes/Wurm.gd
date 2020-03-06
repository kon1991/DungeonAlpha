extends "res://Scenes/EnemyStats.gd"

onready var monsterName = "Wurm"
onready var monsterDamage = 3
onready var monsterMood = "Hungry"
onready var monsterHP = 50
onready var specials = []
onready var Reward = load("res://Reward.gd")
var charging = false

func _ready():
	set_stats(monsterName, monsterDamage, monsterHP, monsterMood)
	sprite.scale = Vector2(1,1)
	greet()
	yield(textBox, "end_enemy_text")

func take_turn():
	if(mood=="Curious"):
		set_array_text(["You are a strange creature...", "Grow stronger before I consume you little meat", "The Wurm retreats silenty into the darkness..."])
		var newReward = Reward.new(1, 1, "Wurm_Scale")
		main.new_rewards.append(newReward)
		main._on_Enemy_died(false)
	if(!charging):
		randomize()
		if(randi()%3 <= 1):
			attack()
		else:
			set_array_text(["The Wurm's face starts to glow", "as energy courses through it's body"])
			charging = true
			yield(textBox, "end_enemy_text")
			emit_signal("end_turn")
	else:
		hyper_beam()
	pass
	
func attack():
	set_text("The Wurm's massive body slams into you")
	player.set_hp(-5)
	yield(textBox, "end_enemy_text")
	emit_signal("end_turn")

func hyper_beam():
	set_array_text(["The Wurm fires a brilliant beam of energy", "The whole dungeon shakes from its power!"])
	player.set_hp(-12)
	
	yield(textBox, "end_enemy_text")
	emit_signal("end_turn")
	
func set_hp(new_hp, type="phys"):
	.set_hp(new_hp)
	if(hp <=30):
		set_mood("Curious")
	
	
func greet():
	set_array_text(["The enormous Wurm appears","it's massive body slithering", "through the darkness..", 
					"\"Mortal refuse, I shall set you free\"", "It whispers..."])
	yield(textBox, "end_enemy_text")
	emit_signal("greet_over")