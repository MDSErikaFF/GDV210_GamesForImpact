extends Node2D

@export var float_height: float = 10.0 # How high it floats up and down
@export var float_speed: float = 2.0 # How fast it floats 

var initial_y: float # Stores starting Y position
var time: float = 0.0 # Used to track how far along on the sine wave

func _ready():
	initial_y = position.y

func _process(delta):
	time += delta * float_speed
	position.y = initial_y + sin(time) * float_height

func _on_shell_object_area_2d_body_entered(body: Node2D) -> void:
	print("Collision with ", body.name)
	if body.name == "Player":
		GameManager.ShellsCollected += 1
		queue_free()
