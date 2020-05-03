extends "res://Scenes/EnemyStats.gd"

onready var monsterName = "MegaBox"
onready var monsterDamage = 1
onready var monsterMood = "???"
onready var monsterHP = 10
onready var specials = ["Pay2PlayButton"]
onready var Reward = load("res://Reward.gd")

var spin = false
var won = false
var lost = false

func _ready():
	set_stats(monsterName, monsterDamage, monsterHP, monsterMood)
	sprite.scale = Vector2(1,1)
#	greet()

func take_turn():
	if won or lost:
		if won:
			set_array_text(["The Box screams in unholy rage as it pukes treasure out and dies"])
			var newRewardData = Loot.get_item_reward("MegaBoxWon")
			var newReward = Reward.new(newRewardData[0], 1, newRewardData[1])
			main.new_rewards.append(newReward)
		else:
			set_array_text(["The Box laughs at you as it dissapears, your gold forever lost"])
		yield(textBox, "end_enemy_text")
		
		main._on_Enemy_died(false)
	elif spin == false:
		attack()
	else:
		begin_spin()
	pass
	
func attack():
	player.set_hp(-damage)
	set_text("The Box laughs at you")
	yield(textBox, "end_enemy_text")
	emit_signal("end_turn")

func begin_spin():
	animationPlayer.play("begin_spin")
	yield(animationPlayer, "animation_finished")
	animationPlayer.play("spin")
	set_array_text(["The Box starts spinning", "Feeling lucky?"])
	yield(textBox, "end_enemy_text")
	emit_signal("end_turn")
	
func set_hp(new_hp, type="phys"):
	if spin == true:
		randomize()
		
		if randi()%100 >50:
			animationPlayer.play("end_spin_good")
			won = true
		else:
			animationPlayer.play("end_spin_bad")
			lost = true
		spin == false
		
	else:
		.set_hp(new_hp)
	
		
func greet():
	set_array_text(["The dreaded box of loot","What could it hold inside?"])
	yield(textBox, "end_enemy_text")
	emit_signal("greet_over")