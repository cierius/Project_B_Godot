extends KinematicBody2D

export (int) var speed = 200
export (int) var health = 100

var velocity = Vector2()
var is_moving = false

onready var cam = get_node("Camera2D")


func _process(_delta):
	if(health <= 0):
		death()
	
	input_detection()
	velocity = move_and_slide(velocity)
	
	if(velocity.x != 0 or velocity.y != 0):
		#print("moving")
		is_moving = true
	else:
		is_moving = false

func input_detection():
	# Need to zero out the vector otherwise it keeps going the same direction
	velocity = Vector2()
	
	# Keyboard input
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
	
	if(Input.is_action_pressed("lmb")):
		mouse_click(0)
	elif(Input.is_action_pressed("rmb")):
		mouse_click(1)
	
func mouse_click(button):
	if(button == 0):
		attack(get_viewport().get_mouse_position())
	elif(button == 1):
		print("RMB")

func attack(mouse_pos):
	look_at(mouse_pos)

# Just messing around with a death message and figuring out how to create
# instances using godot
func death():
	print("Death")
	var death_text = Label.new()
	death_text.set_position(Vector2(get_viewport().size.x/2, get_viewport().size.y/2))
	death_text.set_text("You have died")
	get_parent().add_child(death_text)
