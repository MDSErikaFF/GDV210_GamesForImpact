extends Node2D

@onready var particles: CPUParticles2D = $CPUParticles2D
@export var target: Node2D  # assign your nozzle or target point in the editor

func _process(delta):
	if not target:
		return

	var dir = (target.global_position - global_position).normalized()

	particles.rotation = dir.angle()

	particles.direction = dir  

	particles.initial_velocity = 100
