extends TextureRect
onready var anim = $AnimationPlayer
var type
var duration setget set_duration
var modifier
var applied = false

func init(condition, _duration=1, _modifier=1):
	var img = load("res://Images/Status/"+condition+".png")
	texture = img
	type = condition
	duration = _duration
	modifier = _modifier

func set_duration(delta):
	duration = duration + delta
	print(duration)
	if(duration<=0):
		end_status()

func end_status():
	anim.play("Fade")
	yield(anim,"animation_finished")
	queue_free()