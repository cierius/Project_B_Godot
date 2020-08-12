extends KinematicBody2D

export (int) var speed = 200

var velocity = Vector2()

onready var cam = get_node("Camera2D")

func _process(_delta):
	input_detection()
	velocity = move_and_slide(velocity)
	#print (get_node("Camera2D").get_camera_position())
	

func input_detection():
	# Need to zero out the vector otherwise it keeps going the same direction
	velocity = Vector2()
	
	# Basic input
	if(Input.is_action_pressed("move_up")):
		velocity.y += -1
	if(Input.is_action_pressed("move_down")):
		velocity.y += 1
	if(Input.is_action_pressed("move_right")):
		velocity.x += 1
	if(Input.is_action_pressed("move_left")):
		velocity.x += -1
	
	# Normalized makes it so that velocity clamps to 1
	velocity = velocity.normalized() * speed 
	
