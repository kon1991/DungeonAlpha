extends "res://Scenes/EnemyStats.gd"

onready var monsterName = "DragonPoop"
onready var monsterDamage = 1
onready var monsterMood = "Smelly"
onready var monsterHP = 10
onready var specials = ["ScoopButton"]

func _ready():
	set_stats(monsterName, monsterDamage, monsterHP, monsterMood)
	sprite.scale = Vector2(1.5,1.5)
#	greet()

func take_turn():
	attack()
	pass
	
func attack():
	var poop_count = 0
	var statuses = player.get_statuses()
	for status in statuses:
		if status.type == "poop":
			poop_count += 1
	player.set_hp(-(damage+poop_count))
	set_text("The Poop throws poop at you")
	player.new_conditions.append(["poop", 2, 2])
	yield(textBox, "end_enemy_text")
	emit_signal("end_turn")
	
	
func set_hp(new_hp, type="phys"):
	.set_hp(new_hp)
		
func greet():
	set_text("The stink of Dragon Poo fills the air")
	yield(textBox, "end_enemy_text")
	emit_signal("greet_over")