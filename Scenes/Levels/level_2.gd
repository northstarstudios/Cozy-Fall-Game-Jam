extends Node2D

@export var manager : Node2D;
@export var l = [];
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	manager.order = l;
