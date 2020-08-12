extends KinematicBody2D


export (int) var speed = 175

var target = Vector2()
var dir = Vector2()

func _ready():
	target = get_parent().get_node("Character")


func tracking_ai():
	dir = target.position - position
	
	print(dir)
	
	if(abs(dir.x) <= 32 or abs(dir.y) <= 32):
		dir = dir.normalized() * speed * 0.5
		
		get_node("CollisionShape2D").z_index = 1
	else:
		dir = dir.normalized() * speed
		


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	tracking_ai()
	
	move_and_slide(dir)
