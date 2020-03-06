extends "res://Scenes/EnemyStats.gd"

onready var monsterName = "Devil"
onready var monsterDamage = 5
onready var monsterMood = "???"
onready var monsterHP = 20
onready var anim = $AnimationPlayer
onready var specials = [] #["DevilDealButton"]
onready var monsterTags = ["Kill_Immune"]
onready var i = 0
signal flash


func _ready():
	
	set_stats(monsterName, monsterDamage, monsterHP, monsterMood, monsterTags)
	greet()
	yield(textBox, "end_enemy_text")
	
func greet():
	set_text("There is something in the dark..")
	yield(textBox, "end_enemy_text")
	anim.play("appear")
	yield(get_tree().create_timer(0.6), "timeout")
	yield(anim, "animation_finished")
	emit_signal("flash")
	set_text("HE IS ARISEN")
	player.new_conditions.append(["penta", 5, 1])
	yield(textBox, "end_enemy_text")
	
	yield(get_tree().create_timer(0.6), "timeout")
	emit_signal("greet_over")

func take_turn():
	if(i%2==0):
		attack()
	else:	
		chant()
	i += 1

func attack():
	player.set_hp(-damage)
	set_array_text(["THE DEVIL LOOKS AT YOU", "RAYS OF FIRE BURN YOUR FLESH"])
	yield(textBox, "end_enemy_text")
	emit_signal("end_turn")
	
func chant():
	player.new_conditions.append(["penta", 5, 1])
	#more chants
	set_text("THE DEVIL WHISPERS DARK WORDS")
	yield(textBox, "end_enemy_text")
	emit_signal("end_turn")
