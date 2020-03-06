extends Node

onready var Reward = load("res://Reward.gd")
var current_scene = null
var player_character = "Noi"
var item_rewards = { "Tick" : "S_Potion",
						"Magic Man" : "Magic_Dust",
						"Beholdey" : "S_Potion",
						"Blobby" : "S_Potion",
						"Bug Gang": "S_Potion"
						}
var xp_rewards = { "Tick" : 1, "Magic Man" : 5, "Beholdey" : 3, "Blobby" : 2, "Bug Gang": 2}
var gold_rewards = { "Tick" : 1, "Magic Man" : 5, "Beholdey" : 3, "Blobby" : 2, "Bug Gang": 5}
var xp = 0
var gold = 0
var inventory = []
var character_abilities = {"Noi" : ["Truth", "Seek"]}

func _ready():
	var root = get_tree().get_root()
	current_scene = root.get_child(root.get_child_count() - 1)
	print(current_scene)
	
func goto_scene(path):
    # This function will usually be called from a signal callback,
    # or some other function in the current scene.
    # Deleting the current scene at this point is
    # a bad idea, because it may still be executing code.
    # This will result in a crash or unexpected behavior.

    # The solution is to defer the load to a later time, when
    # we can be sure that no code from the current scene is running:

    call_deferred("_deferred_goto_scene", path)


func _deferred_goto_scene(path):
	current_scene.free()
	var sceneResource = ResourceLoader.load(path)
	var newscene = sceneResource.instance()
	newscene.connect("tree_entered", get_tree(), "set_current_scene", [newscene], CONNECT_ONESHOT)
	get_tree().get_root().add_child(newscene)
	
func get_actions(char_name):
	print(char_name)
	return character_abilities[char_name]
	
func determine_rewards(mname):
	var rewards = []
	var item_reward = Loot.get_item_reward(mname)
	var newReward = Reward.new(item_reward[0], 1, item_reward[1])
	rewards.append(newReward)
	var xp_reward = xp_rewards.get(mname)
	newReward = Reward.new(4, xp_reward, null)
	rewards.append(newReward)
	var gold_reward = gold_rewards.get(mname)
	newReward = Reward.new(5, gold_reward, null)
	rewards.append(newReward)
	return rewards