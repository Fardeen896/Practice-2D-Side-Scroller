extends KinematicBody2D

const MOVEMENT_SPEED = 100
const GRAVITY = 25
const JUMP_POWER = -450
const FLOOR = Vector2(0, -1)

var velocity = Vector2()
var on_ground = false
var is_attacking = false
var is_dead = false


func _physics_process(delta):
	#Basic movement mechanics/animations being played
	if is_dead == false:
		if Input.is_action_pressed("ui_left"):
			velocity.x = -MOVEMENT_SPEED
			$AnimatedSprite.flip_h = true
			if is_attacking == false:
				$AnimatedSprite.play("run")
		elif Input.is_action_pressed("ui_right"):
			velocity.x = MOVEMENT_SPEED
			$AnimatedSprite.flip_h = false
			if is_attacking == false:
				$AnimatedSprite.play("run")
		else:
			velocity.x = 0
			if on_ground == true && is_attacking == false:
				$AnimatedSprite.play("idle")
		
		if Input.is_action_pressed("ui_up"):
			if on_ground == true:
				velocity.y = JUMP_POWER
				on_ground = false
				
		
		velocity.y += GRAVITY
		
		if Input.is_action_just_pressed("ui_focus_next") && is_attacking == false:
			#attack
			is_attacking = true
			$AnimatedSprite.play("attack")
			
		
		
		if is_on_floor():
			on_ground = true
		else:
			on_ground = false
			if is_attacking == false:
				if velocity.y < 0:
					$AnimatedSprite.play("jump")
				else:
					$AnimatedSprite.play("fall")
			
		
		velocity = move_and_slide(velocity, FLOOR)
		
		if get_slide_count() > 0:
			for i in range(get_slide_count()):
				if "Enemy" in get_slide_collision(i).collider.name:
					dead()

func dead():
	is_dead = true
	velocity = Vector2(0, 0)
	$AnimatedSprite.play("idle")
	$CollisionShape2D.disabled = true
	$Timer.start()

func _on_AnimatedSprite_animation_finished():
	is_attacking = false


func _on_Sword_Hitbox_body_entered(body):
	if "Enemy" in body.name && is_attacking == true:
		body.dead()

func _input(event):
	if event.is_action_pressed("ui_interact"):
		if $PickupZone.items_in_range.size() > 0:
			var pickup_item = $PickupZone.items_in_range.values()[0]
			pickup_item.pick_up_item(self)
			$PickupZone.items_in_range.erase(pickup_item)


func _on_Timer_timeout():
	get_tree().change_scene("res://Title_Screen.tscn")
