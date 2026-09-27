extends Node2D

@export var levels : Array[PackedScene];

@export var LevelMenu : MarginContainer;
@export var GameOverlay : MarginContainer;
# Called when the node enters the scene tree for the first time.

var inMenu = true;
var currentLevelid = -1;

func _on_level_box_level_selected(id : int) -> void:
	var l = levels[id].instantiate();
	add_child(l);
	LevelMenu.visible = false;
	GameOverlay.visible = true;
	currentLevelid = id;



func _ready() -> void:
	LevelMenu.visible = true;
	GameOverlay.visible = false;


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
		var l = levels[currentLevelid].instantiate();
		add_child(l);
