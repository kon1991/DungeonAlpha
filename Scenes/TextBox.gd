extends Label

var textQueue = []
var textOrigin
onready var timer = $Timer
signal end_text
signal end_player_text
signal end_enemy_text

func _ready():
	pass # Replace with function body.


func set_text_with_origin(new_text, origin):
	if(timer.is_stopped()):
		text  = new_text
		textOrigin = origin
		timer.start()
	else:
		textQueue.append([origin, new_text])
		
func set_text(new_text):
	if(timer.is_stopped()):
		text  = new_text
		timer.start()
	else:
		textQueue.append(new_text)

func set_array_text(array, origin):
	for text in array:
		set_text_with_origin(text, origin)
		
func _on_Timer_timeout():
	if(!textQueue.empty()):
		### CHECK FOR DUPLICATE MESSAGES
		## concat into "message x times"
		var text_arr = textQueue.pop_front()
#		text = textQueue.pop_front()
		text = text_arr[1]
		if(textOrigin!=text_arr[0]):
			emit_signal("end_"+textOrigin+"_text")
			print("change_origin end_"+textOrigin+"_text")
			
		textOrigin = text_arr[0]
		timer.start()
	else:
		print("EMPTY")
		if(textOrigin=="player"):
			emit_signal("end_player_text")
		elif(textOrigin=="enemy"):
			emit_signal("end_enemy_text")
	pass # Replace with function body.
