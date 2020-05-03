extends "res://Scenes/EnemyStats.gd"

onready var monsterName = "Skelly"
onready var monsterDamage = 4
onready var monsterMood = "Boned"
onready var monsterHP = 10
onready var specials = []

func _ready():
	set_stats(monsterName, monsterDamage, monsterHP, monsterMood)
	sprite.scale = Vector2(1,1)
#	greet()

func take_turn():
	randomize()
#	if(randi()%3 <= 1):
	if(false):
		attack()
	else:
		spinwheel()
	
	pass
	
func attack():
	player.set_hp(-damage)
	set_text("The Skelly slashes you")
	animationPlayer.play("attack")
	yield(textBox, "end_enemy_text")
	animationPlayer.play("idle")
	emit_signal("end_turn")

func spinwheel():
	set_text("The Skelly launches spinning into you!")
	var hit = false
	randomize()
	for i in range(3):
		if randi()%2 == 0:
			player.set_hp(-damage/2)
			yield(get_tree().create_timer(0.2), "timeout")
			
			animationPlayer.play("attack")
			hit = true
	if hit:
		set_text("It slashes you as it goes by!")
	else:
		set_text("It misses and stuns itself!")
#		stun here
	yield(textBox,"end_enemy_text")
	emit_signal("end_turn")
	
func set_hp(new_hp, type="phys"):
	.set_hp(new_hp)
		
func greet():
	set_text("A skeleton warrior appears!")
	yield(textBox, "end_enemy_text")
	emit_signal("greet_over")