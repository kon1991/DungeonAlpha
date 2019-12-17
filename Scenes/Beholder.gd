extends "res://Scenes/EnemyStats.gd"

onready var monsterName = "Beholdey"
onready var monsterDamage = 3
onready var monsterMood = "Gazey"
onready var monsterHP = 18

func _ready():
	set_stats(monsterName, monsterDamage, monsterHP, monsterMood)
	sprite.scale = Vector2(1,1)
	greet()
	pass # Replace with function body.
