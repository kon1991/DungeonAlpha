extends "res://Scenes/Passive.gd"

signal passive_over

func _init(_player, _enemy,_main):
	set_stats("attack_end", _player, _enemy, _main)

func activate(damage_dealt):
	randomize()
	if randi()%100 >50:
		activated = true
		emit_signal("effect_activated")
		player.set_text("A specter of war appears and copies your attack!")
		main.animationPlayer.play("attack_war")
		enemy.set_hp(damage_dealt)
		yield(main.textBox, "end_player_text")
	emit_signal("passive_over")