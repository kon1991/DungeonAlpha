extends Label
onready var timer = $Timer
func _process(delta):
	rect_position.y -= 0.5
	
func _on_DeltaLabel_tree_entered():
	set_process(true)
	pass # Replace with function body.


func _on_Timer_timeout():
	queue_free()
	pass # Replace with function body.
