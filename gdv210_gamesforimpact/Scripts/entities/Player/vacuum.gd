extends Node2D

@onready var vacuumEndPoint = $VacuumTexture2/endPoint
@onready var vacuumRangeCollisoon = $VacuumTexture2/endPoint/vacuumArea2D/CollisionPolygon2D

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if Input.is_action_pressed("LeftClick"):
		if not GameManager.CurrentlyVacuum:
			GameManager.CurrentlyVacuum = true
			SoundManager.play_vacuum_sfx()  
		GameManager.targetVacuumMarker = vacuumEndPoint.global_position
	else:
		if GameManager.CurrentlyVacuum:
			GameManager.CurrentlyVacuum = false
			SoundManager.stop_vacuum_sfx()  
#	
	#get_node("VacuumTexture2").look_at(get_global_mouse_position())
	look_at(get_global_mouse_position())
	vacuumRangeCollisoon.scale.x = GameManager.VacuumSizeLevel
	vacuumRangeCollisoon.scale.y = GameManager.VacuumSizeLevel
	if Input.is_action_just_pressed("ui_page_up"):
		if GameManager.VacuumSizeLevel <= GameManager.VacuumMaxSizeLevel:
			GameManager.VacuumSizeLevel += 0.1
			print("Vacuum size level: ", GameManager.VacuumSizeLevel)
			LevelUpVacuum()



func _on_vacuum_area_2d_area_entered(area):
	if GameManager.CurrentlyVacuum == true:
		print("Vacuum trash")

func LevelUpVacuum():
	vacuumRangeCollisoon.scale *= GameManager.VacuumSizeLevel
