extends Control

@export var player : Player;

@onready var LableTrash = $"MarginContainer/HBoxContainer/Panel/Label Trash Count"
@onready var LableShell = $"MarginContainer/HBoxContainer/Panel2/Label Shell Count"
@onready var LableInventoryFull = $"Lable Inventory Full"
@onready var LableAllShellColected = $"Lable All Shells Collected"

@onready var DebugUI = $"../DebugUI"
@onready var LableStats = $"../DebugUI/Label Stats"
@onready var LableControls = $"../DebugUI/Label Controls"

@onready var PauseMenu = $"../Pause Menu"



# Called when the node enters the scene tree for the first time.
func _ready():
	LableInventoryFull.visible = false;
	LableAllShellColected.visible = false;
	DebugUI.visible = false;
	PauseMenu.visible = false;


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	
	if player:
		global_position = player.global_position
	
	LableTrash.text = "Trash: " + str(GameManager.TrashCollected) + " / " + str(GameManager.MaxTrashStorage)
	LableShell.text = "Shells: " + str(GameManager.ShellsCollected) + " / " + str(GameManager.MaxShells)
	
	
	if GameManager.TrashCollected >= GameManager.MaxTrashStorage:
		LableInventoryFull.visible = true;
	else:
		LableInventoryFull.visible = false;
		
	if GameManager.ShellsCollected >= GameManager.MaxShells:
		LableAllShellColected.visible = true;
	else:
		LableAllShellColected.visible = false;

	
	if GameManager.debugOn == true:
		DebugUI.visible = true
		
		LableStats.text = "-Stats-
							-Seal Upgrades-
							.Trash Vacum Upgrade: " + str(GameManager.VacuumSizeLevel) + "
							.Seal Speed Upgrade: " + str(GameManager.SealSpeed) + "
							.Seal Dangerous Trash Resistance: " + str(1) + "
							.Current ocean trash level: " + str(1) + "\n "
	else:
		DebugUI.visible = false

	if GameManager.isPaused:
		PauseMenu.visible = true
	else:
		PauseMenu.visible = false;

	


func _on_button_continue_pressed():
	GameManager.toggle_pause();


func _on_button_to_main_menu_pressed():
	GameManager.toggle_pause();
	get_tree().change_scene_to_file("res://UI/main_menu.tscn")
	pass
