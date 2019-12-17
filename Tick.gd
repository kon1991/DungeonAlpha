extends "res://Scenes/EnemyStats.gd"

onready var monsterName = "Tick"
onready var monsterDamage = 3
onready var monsterMood = "Calm"
onready var monsterHP = 10

func _ready():
	set_stats(monsterName, monsterDamage, monsterHP, monsterMood)
	greet()
	yield(textBox, "end_enemy_text")
	pass

func take_turn():
	if(mood=="Hungry"):
		suck()
	else:
		attack()
	pass
	
func attack():
	player.set_hp(-damage)
	set_text("The tick slaps you")
	yield(textBox, "end_enemy_text")
	emit_signal("end_turn")
	
func suck():
	player.set_hp(-(damage-1))
	set_hp(2)
	set_text("The tick sucks your blood!")
	yield(textBox, "end_enemy_text")
	emit_signal("end_turn")
	
func set_hp(new_hp):
	.set_hp(new_hp)
	if(hp <=5):
		set_mood("Hungry")
		print(mood)
		moodLabel.set("custom_colors/font_color", '9c0b0b') #red
		
func greet():
	set_text("The Tick wiggles his proboscis enticingly")
	