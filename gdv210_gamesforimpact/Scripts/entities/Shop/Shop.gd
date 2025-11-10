extends Node


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if GameManager.atShop == true && GameManager.inShop == false:
		if Input.is_key_pressed(KEY_E):
			print("Open Shop")
			GameManager.inShop = true;


func _on_shop_area_2d_body_entered(body: Node2D) -> void:
	if body.name == "Player":
		GameManager.atShop = true;


func _on_shop_area_2d_body_exited(body: Node2D) -> void:
	if body.name == "Player":
		GameManager.atShop = false;
		GameManager.inShop = false
