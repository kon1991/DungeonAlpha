extends Node

var current_scene = null
var player_character = null

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