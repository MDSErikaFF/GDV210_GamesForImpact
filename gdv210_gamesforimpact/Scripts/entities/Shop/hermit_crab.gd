extends Node2D


@onready var EnterShopSprite = $EnterShopSprite

# Called when the node enters the scene tree for the first time.
func _ready():
	EnterShopSprite.visible = false;


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	
	if GameManager.atShop == true:
		EnterShopSprite.visible = true
	else:
		EnterShopSprite.visible = false;
	
