extends Node

#Vacuum global var
var CurrentlyVacuum : bool = false #so the rubbish can get picked up
var VacuumSizeLevel = 1 #for the level up of equipment. 1 is the lowest
var VacuumMaxSizeLevel = 1.4
var TrashCollected = 0
var MaxTrashStorage = 10
var targetVacuumMarker : Vector2

var ShellsCollected = 0;
var MaxShells = 3;

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	
	if Input.is_action_just_pressed("Quit"): # quit out of the game 
		get_tree().quit()
	
	
	
	
	
 
