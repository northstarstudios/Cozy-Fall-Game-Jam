extends Node2D

@export var levels : Array[PackedScene];

@export var LevelMenu : MarginContainer;
@export var GameOverlay : MarginContainer;

var inMenu = true;
var currentLevelid = -1;
var currentlyUnlockedLevelId = 0;

func _on_level_selected(id : int) -> void:
	var l = levels[id-1].instantiate();
	add_child(l);
	LevelMenu.visible = false;
	GameOverlay.visible = true;
	currentLevelid = id-1;



func _ready() -> void:
	LevelMenu.visible = true;
	GameOverlay.visible = false;
	for child in LevelMenu.getLevels():
		child.connect("level_selected", _on_level_selected);

func _on_finished_level(event: InputEvent) -> void:
	if event is InputEventMouseButton and event.pressed:
		currentlyUnlockedLevelId = max(currentlyUnlockedLevelId, currentlyUnlockedLevelId+1);
		LevelMenu.unlockLevel(currentlyUnlockedLevelId);
		for child in get_children():
			child.queue_free();
		GameOverlay.visible = false;
		GameOverlay.hideWinScreen();
		LevelMenu.visible = true;
		currentLevelid = -1;
	

func _on_return_gui_input(event: InputEvent) -> void:
	if event is InputEventMouseButton and event.pressed:
		for child in get_children():
			child.queue_free();
		GameOverlay.visible = false;
		LevelMenu.visible = true;
		currentLevelid = -1;


func _on_restart_gui_input(event: InputEvent) -> void:
	if event is InputEventMouseButton and event.pressed:
		for child in get_children():
			child.queue_free();
			print(child.get_tree_string_pretty())
		var l = levels[currentLevelid].instantiate();
		add_child(l);
