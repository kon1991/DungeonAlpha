extends Sprite
onready var timer = $Timer
var SPEED = 40
var motion
var acc = 0.05

func _ready():
	set_process(true)

func _process(delta):
	motion = Vector2(0,-1) * SPEED
	set_position(get_position() + motion*delta)
	if(get_position().y < -50):
		print("im free_")
		queue_free()
