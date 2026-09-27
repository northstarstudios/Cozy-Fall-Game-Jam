extends Node2D

@export var direction : Vector2i;
@export var StartPosition : Vector2i;
@export var manager : Node2D;


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	position = Vector2(StartPosition.x * 64 + 32, StartPosition.y * 64 + 32);
	if direction == Vector2i(1,0):
		rotation_degrees = 0;
	elif direction == Vector2i(0,1):
		rotation_degrees = 90;
	elif direction == Vector2i(-1,0):
		rotation_degrees = 180;
	elif direction == Vector2i(0,-1):
		rotation_degrees = -90;
	#print(position);

func success():
	print("success villager: ", name);
	
	
