extends KinematicBody2D

const MOVEMENT_SPEED = 100
const GRAVITY = 25
const JUMP_POWER = -300
const FLOOR = Vector2(0, -1)

var velocity = Vector2()

func _physics_process(delta):
	if Input.is_action_pressed("ui_left"):
		velocity.x = -MOVEMENT_SPEED
	elif Input.is_action_pressed("ui_right"):
		velocity.x = MOVEMENT_SPEED
	else:
		velocity.x = 0
	
	if Input.is_action_pressed("ui_up"):
		velocity.y = JUMP_POWER
		
		
	velocity.y += GRAVITY
	
	velocity = move_and_slide(velocity)
