extends "res://Scenes/EnemyStats.gd"

onready var monsterName = "Magic Man"
onready var monsterDamage = 2
onready var monsterMood = "Trippi"
onready var monsterHP = 15
onready var specials = ["CounterSpellButton"]
onready var interactions = ["Yes", "No"]
onready var tween = $Tween
var up = true
var vanish = false
var stop_tween = false

func _ready():
	set_stats(monsterName, monsterDamage, monsterHP, monsterMood)
#	greet()
	tween.interpolate_property(sprite, "position",
        null, sprite.position + Vector2(0, -5), 1,
        Tween.TRANS_LINEAR, Tween.EASE_IN_OUT)
	tween.start()
	pass # Replace with function body.

func take_turn():
	if(vanish == true):
		set_text("The magic man poofs out of existence!")
		yield(textBox, "end_enemy_text")
		yield(get_tree().create_timer(0.8), "timeout")
		escape()
	elif(mood == "Sad"):
		sprite.get_material().set_shader_param("apply", false)
#		animationPlayer.play("cry")
		set_array_text(["The magic man starts crying...", "\"I'm sowwyyy, I just wanted to practice my magic, sniff sniff\"", 
		"\"Can I be your apprentice?\""])
		yield(textBox, "end_enemy_text")
		yield(get_tree().create_timer(0.8), "timeout")
		main._on_Enemy_died(false)
		
	elif(mood == "???"):
		sprite.get_material().set_shader_param("apply", true)
		set_array_text(["The magic man starts chanting a magic spell!", "Scabada-badi-dabado scoopty poopty poopty whoopty shamalaz"])
		vanish = true
		yield(textBox, "end_enemy_text")
		emit_signal("end_turn")
	else:
		attack()
	pass
	
func attack():
	player.set_hp(-damage)
#	potentionally debuffs you, scrambles letter and placement of buttons maybe?
	set_text("The magic man zaps you!")
	yield(textBox, "end_enemy_text")
	emit_signal("end_turn")

func greet():
	set_text("The magic man floats around")
	yield(textBox, "end_enemy_text")
	emit_signal("greet_over")
	
func set_hp(new_hp, type="phys"):
	.set_hp(new_hp)
	if(hp <=10):
		set_mood("Sad")
		
		
func escape(): 
	main._on_Enemy_died(false)



func _on_Tween_tween_all_completed():
	if stop_tween == false:
		if up:
			if mood != "Sad":
				tween.interpolate_property(sprite, "position", null, sprite.position + Vector2(0, 10), 1,
		        Tween.TRANS_LINEAR, Tween.EASE_IN_OUT)
				up = false
				tween.start()
			else: 
				tween.interpolate_property(sprite, "position", null, sprite.position + Vector2(0,15), 1,
				Tween.TRANS_LINEAR, Tween.EASE_IN_OUT)
				stop_tween = true
				tween.start()
		else:
			tween.interpolate_property(sprite, "position",
	        null, sprite.position + Vector2(0, -10), 1,
	        Tween.TRANS_LINEAR, Tween.EASE_IN_OUT)
			up = true
			tween.start()
	elif stop_tween == true:
		animationPlayer.play("cry")
	pass # Replace with function body.
