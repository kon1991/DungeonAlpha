extends "res://Scenes/EnemyStats.gd"

onready var monsterName = "Beholdey"
onready var monsterDamage = 3
onready var monsterMood = "Gazey"
onready var monsterHP = 18
onready var specials = []
func _ready():
	set_stats(monsterName, monsterDamage, monsterHP, monsterMood)
	sprite.scale = Vector2(1,1)
	greet()
	yield(textBox, "end_enemy_text")

func take_turn():
	randomize()
	var rand_ray = randi()%5
	match rand_ray:
			0,1:
				poison_ray()
			2,3:
				fear_ray()
			4: 
				death_ray()
	pass
	
	
func poison_ray():
	player.new_conditions.append(["poison", 2, 2])
	set_text("A sickly green ray hits you!")
	yield(textBox, "end_enemy_text")
	emit_signal("end_turn")
	
func fear_ray():
	player.new_conditions.append(["fear", 2, 1])
	set_text("A cold purple ray hits you!")
	yield(textBox, "end_enemy_text")
	emit_signal("end_turn")
	
func death_ray():
	player.set_hp(-8)
	set_array_text(["A black ray hits you!","It hurts..."])
	yield(textBox, "end_enemy_text")
	emit_signal("end_turn")
	
func greet():
	set_text("The Beholder gazes at you pensively..")
	yield(textBox, "end_enemy_text")
	emit_signal("greet_over")