extends Node2D;
class_name Level;

var ActivatePollution : bool = false;
@onready var CollisionLayer : TileMapLayer = $"Level-Collision"
@onready var NonCollisionLayer : TileMapLayer = $"Level-DecorationsLayer"

@onready var Col : TileSet = preload("res://Scripts/Levels/Other/CollisionOnTS.tres");
@onready var NonCol : TileSet = preload("res://Scripts/Levels/Other/CollisionOffTS.tres");
@onready var PollutionNonCol : TileSet = preload("res://Scripts/Levels/Other/CollisionOffTSPollution.tres");
@onready var PollutionCol : TileSet = preload("res://Scripts/Levels/Other/CollisionOnTSPollution.tres");

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if Input.is_action_just_pressed("ActivatePollution"):
		ActivatePollution != ActivatePollution;
		if (ActivatePollution):
			var Pollution = load("res://Scripts/Levels/Other/CollisionOnTSPollution.tres");
			CollisionLayer.tile_set = Pollution;
			Pollution = load("res://Scripts/Levels/Other/CollisionOffTSPollution.tres");
			NonCollisionLayer.tile_set = Pollution;
			CollisionLayer.force_update_transform();
			NonCollisionLayer.force_update_transform();
		else:
			CollisionLayer.tile_set = Col;
			NonCollisionLayer.tile_set = NonCol;
