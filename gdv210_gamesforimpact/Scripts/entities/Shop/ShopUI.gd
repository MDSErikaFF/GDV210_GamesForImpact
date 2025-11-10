extends Control

@onready var LabelTrashSpacePrice = $"Panel/PriceHBoxContainer2/TrashSpacePrice"
@onready var LabelVacuumAreaPrice = $"Panel/PriceHBoxContainer2/VacuumAreaPrice"
@onready var LabelSealSpeedPrice = $"Panel/PriceHBoxContainer2/SealSpeedPrice"
@onready var LabelNotEnoughShells = $"Panel/NotEnoughLabel"

@onready var ButtonBuyTrashSpace = $"Panel/BuyButtonsHBoxContainer/TrashSpaceButton"
@onready var ButtonBuyVacuumArea = $"Panel/BuyButtonsHBoxContainer/VacuumAreaButton"
@onready var ButtonBuySealSpeed = $"Panel/BuyButtonsHBoxContainer/TrashSpaceButton"

@onready var NEShellsVisibleTimer = 0;


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	LabelNotEnoughShells.visible = false;
	


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	LabelTrashSpacePrice.text = str(10*GameManager.TrashSpaceLevel)
	LabelVacuumAreaPrice.text = str(15*GameManager.VacuumAreaLevel)
	LabelSealSpeedPrice.text = str(20*GameManager.SealSpeedLevel)
	
	if NEShellsVisibleTimer > 0:
		NEShellsVisibleTimer -= 1
	else:
		LabelNotEnoughShells.visible = false;


func _on_trash_space_button_pressed() -> void:
	print(GameManager.TrashCollected)
	print("GameManager.TrashSpaceLevel")
	if GameManager.TrashCollected >= (10*GameManager.TrashSpaceLevel):
		GameManager.TrashCollected -= 10*GameManager.TrashSpaceLevel
		GameManager.MaxTrashStorage += 10
		GameManager.TrashSpaceLevel += 1
		print(GameManager.TrashSpaceLevel)


func _on_vacuum_area_button_pressed() -> void:
	print("GameManager.VacuumAreaLevel")
	if GameManager.TrashCollected >= (15*GameManager.VacuumAreaLevel):
		GameManager.TrashCollected -= 15*GameManager.VacuumAreaLevel
		GameManager.VacuumSizeLevel += 0.5
		GameManager.VacuumAreaLevel += 1
		
		print(GameManager.VacuumAreaLevel)


func _on_seal_speed_button_pressed() -> void:
	print("GameManager.SealSpeedLevel")
	if GameManager.TrashCollected >= (20*GameManager.SealSpeedLevel):
		GameManager.TrashCollected -= 20*GameManager.SealSpeedLevel
		GameManager.SealSpeed += 50
		GameManager.SealSpeedLevel += 1
		print(GameManager.SealSpeedLevel)


func _on_next_level_button_pressed() -> void:
	if GameManager.ShellsCollected == GameManager.MaxShells:
		print("NextLevelLogic")
	else:
		NEShellsVisibleTimer = 180;
		LabelNotEnoughShells.visible = true


func _on_leave_shop_button_pressed() -> void:
	GameManager.inShop = false
