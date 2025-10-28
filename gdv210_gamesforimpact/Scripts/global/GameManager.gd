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

var MaxSealSpeed = 500
var SealSpeed = 300

var debugOn = false;

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	
	if Input.is_action_just_pressed("Quit"): # quit out of the game 
		get_tree().quit()
	
	if Input.is_action_just_pressed("ActivateDebug"):
		debugOn = !debugOn
	
	if debugOn:
		
		if Input.is_action_just_pressed("ui_up"):
			SealSpeed += 100
			if SealSpeed >= MaxSealSpeed:
				SealSpeed = MaxSealSpeed
	
	
	
	if ShellsCollected >= MaxShells:
		print("All shels colected, game is done!")
	
	if TrashCollected >= MaxTrashStorage:
		print("Trash Inventory full, go trade it in the Shaop!")
	
 
