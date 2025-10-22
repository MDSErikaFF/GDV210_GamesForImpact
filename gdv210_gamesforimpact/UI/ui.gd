extends Control

@export var player : Player;

@onready var LableTrash = $"HBoxContainer/Panel/Label Trash Count"
@onready var LableShell = $"HBoxContainer/Panel2/Label Shell Count"

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	
	if player:
		global_position = player.global_position
	
	LableTrash.text = "Trash: " + str(GameManager.TrashCollected) + " / " + str(GameManager.MaxTrashStorage)
	LableShell.text = "Shells: " + str(GameManager.ShellsCollected) + " / " + str(GameManager.MaxShells)
