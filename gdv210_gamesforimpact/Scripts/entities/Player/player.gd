extends CharacterBody2D
class_name Player

@export var speed = 400

@export var accel = 1500

@export var friction = 600

@export var rotation_speed = 10.0

var input = Vector2.ZERO

var last_angle = 0.0;

func _physics_process(delta):
	get_input()
	if input == Vector2.ZERO:
		if velocity.length() > friction * delta:
			velocity -= velocity.normalized() * friction * delta
		else:
			velocity = Vector2.ZERO
	else:
		velocity += input * accel * delta
		#velocity = velocity.limit_length(speed)
		velocity = velocity.limit_length(GameManager.SealSpeed)

	
	
	var target_angle = last_angle
	# updates the player's rotation acording to the velocity angle
	if velocity.length() > 1:
		target_angle = velocity.angle()
	elif input != Vector2.ZERO:
		target_angle = input.angle()
		
	last_angle = target_angle
	rotation = lerp_angle(rotation, target_angle, rotation_speed * delta)

		
		
		
	move_and_slide()

func get_input():
	input.x = int(Input.is_action_pressed("Right")) - int(Input.is_action_pressed("Left"))
	input.y = int(Input.is_action_pressed("Down")) - int(Input.is_action_pressed("Up"))
	input = input.normalized()
