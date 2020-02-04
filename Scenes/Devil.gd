extends "res://Scenes/EnemyStats.gd"

onready var monsterName = "Devil"
onready var monsterDamage = 3
onready var monsterMood = "???"
onready var monsterHP = 20
onready var anim = $AnimationPlayer
signal flash

func _ready():
	set_stats(monsterName, monsterDamage, monsterHP, monsterMood)
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