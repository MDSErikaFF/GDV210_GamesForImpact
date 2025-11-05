extends Node

# Vacuum global vars
var CurrentlyVacuum : bool = false
var VacuumSizeLevel = 1
var VacuumMaxSizeLevel = 1.4

var TrashCollected = 0
var MaxTrashStorage = 10
var targetVacuumMarker : Vector2

var ShellsCollected = 0
var MaxShells = 3

var MaxSealSpeed = 500
var SealSpeed = 300

var debugOn = false
var isPaused = false

enum PollutionState {
	LEVEL_1,
	LEVEL_2,
	LEVEL_3
}

var currentPollutionState = PollutionState.LEVEL_2

# Preload the trash layouts for each level
var trash_scenes = {
	PollutionState.LEVEL_1: preload("res://Scenes/Levels/level1_trash_layout.tscn"),
	PollutionState.LEVEL_2: preload("res://Scenes/Levels/level2_trash_layout.tscn"),
	PollutionState.LEVEL_3: preload("res://Scenes/Levels/level3_trash_layout.tscn"),
}

# Keep track of the currently loaded trash instance
var current_trash_instance: Node = null


func _ready():
	process_mode = PROCESS_MODE_ALWAYS
	setup_trash()


# Called every frame
func _process(delta):
	if Input.is_action_just_pressed("Quit"):
		get_tree().quit()

	if Input.is_action_just_pressed("ActivateDebug"):
		debugOn = !debugOn

	if Input.is_action_just_pressed("Pause"):
		toggle_pause()

	if debugOn:
		if Input.is_action_just_pressed("ui_up"):
			SealSpeed += 100
			if SealSpeed >= MaxSealSpeed:
				SealSpeed = MaxSealSpeed

	if ShellsCollected >= MaxShells:
		print("All shells collected, game is done!")

	if TrashCollected >= MaxTrashStorage:
		print("Trash Inventory full, go trade it in the Shop!")


func toggle_pause():
	isPaused = !isPaused
	get_tree().paused = isPaused


# Loads the trash layout for the current pollution state
func setup_trash():
	# Remove the old trash layout
	if current_trash_instance:
		current_trash_instance.queue_free()

	# Instantiate the scene for the current pollution state
	var scene_to_load = trash_scenes.get(currentPollutionState, null)
	if scene_to_load == null:
		push_warning("No trash layout assigned for pollution state: %s" % str(currentPollutionState))
		return
	
	current_trash_instance = scene_to_load.instantiate()
	add_child(current_trash_instance)
	current_trash_instance.position = Vector2.ZERO
