extends KinematicBody2D

const ACCELERATION = 400
const MAX_SPEED = 250
var velocity = Vector2.ZERO
var item_name
var player = null
var being_picked_up = false

func _ready():
	item_name = "Health_Potion"

func _physics_process(delta):
	#Check if item is being picked up
	if being_picked_up == false:
		#If it isn't being picked up, apply gravity and wait until the player is close
		velocity = velocity.move_toward(Vector2(0, MAX_SPEED), ACCELERATION * delta)
	else:
		#If it is, move it toward the player and delete the item once it gets close enough
		var direction = global_position.direction_to(player.global_position)
		velocity = velocity.move_toward(direction * MAX_SPEED, ACCELERATION * delta)
		
		var distance = global_position.distance_to(player.global_position)
		if distance < 4:
			PlayerInventory.add_item(item_name, 1)
			queue_free()
	velocity = move_and_slide(velocity, Vector2.UP)

func pick_up_item(body):
	player = body
	being_picked_up = true
