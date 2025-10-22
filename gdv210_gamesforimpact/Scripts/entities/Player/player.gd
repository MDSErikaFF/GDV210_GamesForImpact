extends CharacterBody2D
class_name Player

@export var speed = 400

@export var accel = 1500

@export var friction = 600

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
		velocity = velocity.limit_length(speed)
		
	# updates the player's rotation acording to the velocity angle
	if velocity.length() > 1:
		last_angle = velocity.angle()
		rotation = last_angle
	else: # when not moving, stay rotated at the last angle 
		rotation = last_angle
	move_and_slide()

func get_input():
	input.x = int(Input.is_action_pressed("Right")) - int(Input.is_action_pressed("Left"))
	input.y = int(Input.is_action_pressed("Down")) - int(Input.is_action_pressed("Up"))
	input = input.normalized()
