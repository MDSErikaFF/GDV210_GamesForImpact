extends Node2D;
class_name Level;

var ActivatePollution : bool = false;
@onready var CollisionLayer = $"CollisionPollution"
@onready var NonCollisionLayer = $"DecorationsLayerPollution"

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	
	## Create signal here for swapping between tilesets (SetPollution())
	
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if Input.is_action_just_pressed("ActivatePollution"):
		SetPollution(!ActivatePollution);

func SetPollution(_bool: bool) -> void:
	ActivatePollution = _bool;
	if (ActivatePollution):
		CollisionLayer.visible = true;
		NonCollisionLayer.visible = true;
		pass;
	else:
		CollisionLayer.visible = false;
		NonCollisionLayer.visible = false;
		pass;
