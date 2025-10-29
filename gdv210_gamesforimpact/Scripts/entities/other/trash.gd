extends CharacterBody2D

@export var min_speed: float = 5.0
@export var max_speed: float = 10000.0
@export var lerp_base: float = 5000.0 #higher = faster pull when close

@export var reach_threshold: float = 5.0 # Distance at which target is considered reached
var has_reached_target: bool = false

var is_in_trash_area : bool = false

# Called when the node enters the scene tree for the first time.
func _ready():
	#add a random texture to the TrashSprite from the trash sprite folder
	var folder_path = "res://Assets/Images/trashSprites/" #gets the folder path
	var png_files = get_png_files(folder_path)
	
	if png_files.size() > 0:
		var random_file = png_files[randi() % png_files.size()]
		var tex = load(random_file)
		if tex is Texture2D:
			$TrashSprite.texture = tex
		else:
			print("Failed to load texture: ", random_file) #for debug
	else:
		print("No PNG files found in folder: ", folder_path) #for debug

#gets the png from the folder and returns with the png
func get_png_files(folder_path: String) -> Array:
	var dir = DirAccess.open(folder_path)
	var files = []
	
	if dir:
		dir.list_dir_begin()
		var file_name = dir.get_next()
		while file_name != "":
			if not dir.current_is_dir() and file_name.ends_with(".png"):
				files.append(folder_path + "/" + file_name)
			file_name = dir.get_next()
		dir.list_dir_end()
	
	return files

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if GameManager.CurrentlyVacuum && is_in_trash_area:
		#trash being vacuumed in a lerp
		var distance = global_position.distance_to(GameManager.targetVacuumMarker)
		var speed = clamp(lerp_base / distance, min_speed, max_speed)
		global_position = global_position.move_toward(GameManager.targetVacuumMarker, speed * delta)
		
		#when it gets to the target, the noosel of the vacuum, it goes to on_target_reached()
		if distance <= reach_threshold && !has_reached_target:
			has_reached_target = true
			print("Target reached!")
			on_target_reached()
	else:
		#idle water movement for trash here
		var wave = Vector2(sin(Time.get_ticks_msec() * 0.005) * 5, 0)
		global_position += wave * delta
	
	move_and_slide()


func _on_trash_area_2d_area_entered(area):
	print("Entered trash area")
	is_in_trash_area = true

func _on_trash_area_2d_area_exited(area):
	print("Exited trash area")
	is_in_trash_area = false

func on_target_reached():
	#checks if it can pick up any more
	if GameManager.TrashCollected <= GameManager.MaxTrashStorage - 1:
		GameManager.TrashCollected += 1 #adds the number to the backpack
		print("Trash amount collected: ", GameManager.TrashCollected)
		queue_free() #then removes the object
