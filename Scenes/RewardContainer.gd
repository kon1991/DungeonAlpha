extends HBoxContainer

onready var label = $Label
onready var button = $CenterContainer/Button
onready var main = get_tree().current_scene
onready var player = main.find_node("PlayerStats")
enum {ITEM, PASS, WEAP, ARM}
var cat
var num
var message
var item_name

func init(_cat, _item_name):
	cat = _cat
	item_name = _item_name
	
func set_reward_text(message):
	label.text = message

func _on_Button_pressed():
	button.set_disabled(true)
	button.text = "Taken"
	if(cat == ITEM):
		if player.inventory.size() == 4:
			main.replaceItem = item_name
			main.toggle_rewards()
		else:
			player.inventory.append(item_name)
	elif(cat == PASS):
		player.passive.append(item_name)
	elif(cat == WEAP):
		player.set_weapon(item_name)
	elif(cat == ARM):
		player.set_armor(item_name)