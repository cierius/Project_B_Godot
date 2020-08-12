extends KinematicBody2D

export (int) var health = 100
export (int) var speed = 125
export (float) var absorb_rate = 1.05
export (int) var attack_rate = 2


var dist = 0
var target = Vector2()
var dir = Vector2()

var has_attacked = false
var attack_timer = 0

func _ready():
	target = get_parent().get_node("Character")


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	tracking_ai()
	dir = move_and_slide(dir)


func tracking_ai():
	dir = target.position - position
	
	dist = global_position.distance_to(target.position)
	
	# Close to the player the enemy will match the speed and "absorb" the player
	if(dist <= 64):
		if(dist <= 10):
			if(has_attacked == false):
				target.health -= 25
				print("Attacked player hp remaining: ", target.health)
				has_attacked = true
				attack_timer = OS.get_unix_time()
			else:
				attack_timer()
			
			
		if(target.is_moving == true):
			dir = dir.normalized() * target.speed * absorb_rate
		else:
			# 25 seems like a good amount so that it absorbs quicker when the
			# player is standing still
			dir = dir.normalized() * absorb_rate * 25
		
		# Enemies will not collide with each other
		set_collision_mask_bit(1, false)
	else:
		dir = dir.normalized() * speed
		set_collision_mask_bit(1, true)
		

func attack_timer():
	var elapsed = OS.get_unix_time() - attack_timer
	if(elapsed >= attack_rate):
		has_attacked = false
		print("attack reset")
