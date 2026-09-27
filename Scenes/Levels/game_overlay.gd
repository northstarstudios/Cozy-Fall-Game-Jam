extends MarginContainer

@export var WinScreen : PanelContainer;
@export var ReturnButton : PanelContainer;
@export var RestartButton : PanelContainer;

func _ready() -> void:
	WinScreen.visible = false;
	
func showWinScreen():
	WinScreen.visible = true;
	ReturnButton.visible = false;
	RestartButton.visible = false;
func hideWinScreen():
	WinScreen.visible = false;
	ReturnButton.visible = true;
	RestartButton.visible = true;
