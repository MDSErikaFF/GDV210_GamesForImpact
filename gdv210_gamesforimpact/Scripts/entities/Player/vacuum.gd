extends Node2D

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if Input.is_action_pressed("LeftClick"):
		GameManager.CurrentlyVacuum = true
		GameManager.targetVacuumMarker = $VacuumTexture/endPoint.global_position
	else:
		GameManager.CurrentlyVacuum = false
	
	get_node("VacuumTexture").look_at(get_global_mouse_position())
	
	if Input.is_action_just_pressed("ui_page_up"):
		if GameManager.VacuumSizeLevel <= GameManager.VacuumMaxSizeLevel:
			GameManager.VacuumSizeLevel += 0.1
			print("Vacuum size level: ", GameManager.VacuumSizeLevel)
			LevelUpVacuum()


func _on_vacuum_area_2d_area_entered(area):
	if GameManager.CurrentlyVacuum == true:
		print("Vacuum trash")

func LevelUpVacuum():
	$VacuumTexture/endPoint/vacuumArea2D/CollisionPolygon2D.scale *= GameManager.VacuumSizeLevel
