extends CharacterBody2D
class_name Player

@export var speed = 400

@export var accel = 1500

@export var friction = 600

@export var rotation_speed = 10.0

@export var gravity = 800.0
@export var jump_out_force = -400.0  
@export var gravity_ramp_speed = 4.0 

var vertical_velocity = 0.0
var current_gravity = 0.0
var in_water = true

var input = Vector2.ZERO

var last_angle = 0.0;

func _ready():
	# Find all 'out_of_water_area' nodes in the scene
	for area in get_tree().get_nodes_in_group("OutOfWaterArea"):
		connect_out_of_water_signals(area)


func _physics_process(delta):
	get_input()
	
	if in_water:
		current_gravity = 0.0
		vertical_velocity = 0.0
		
		if input == Vector2.ZERO:
			if velocity.length() > friction * delta:
				velocity -= velocity.normalized() * friction * delta
			else:
				velocity = Vector2.ZERO
		else:
			velocity += input * accel * delta
			velocity = velocity.limit_length(GameManager.SealSpeed)
	else:

		current_gravity = lerp(current_gravity, gravity, gravity_ramp_speed * delta)
		vertical_velocity += current_gravity * delta
		velocity.y = vertical_velocity
		velocity.x = lerp(velocity.x, 0.0, 0.05)
	
	# updates the player's rotation acording to the velocity angle 
	var target_angle = last_angle
	if velocity.length() > 1:
		target_angle = velocity.angle()
	elif input != Vector2.ZERO:
		target_angle = input.angle()
	
	last_angle = target_angle
	rotation = lerp_angle(rotation, target_angle, rotation_speed * delta)
	
	move_and_slide()


func connect_out_of_water_signals(area: Area2D):
	if not area.body_entered.is_connected(_on_out_of_water_body_entered):
		area.body_entered.connect(_on_out_of_water_body_entered)
	if not area.body_exited.is_connected(_on_out_of_water_body_exited):
		area.body_exited.connect(_on_out_of_water_body_exited)

func get_input():
	input.x = int(Input.is_action_pressed("Right")) - int(Input.is_action_pressed("Left"))
	input.y = int(Input.is_action_pressed("Down")) - int(Input.is_action_pressed("Up"))
	input = input.normalized()


func _on_out_of_water_body_entered(body):
	if body == self:
		in_water = false
		current_gravity = 0.0
		vertical_velocity = jump_out_force  


func _on_out_of_water_body_exited(body):
	if body == self:
		in_water = true
		vertical_velocity = 0.0
