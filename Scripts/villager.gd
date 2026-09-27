extends Node2D

@export var direction : Vector2i;
@export var StartPosition : Vector2i;
@export var manager : Node2D;

@export var sprite : Sprite2D;

@export var right : Texture;
@export var down : Texture;
@export var left : Texture;
@export var up : Texture;


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	position = Vector2(StartPosition.x * 16 + 8, StartPosition.y * 16 + 8);
	if direction == Vector2i(1,0):
		sprite.texture = right;
		#rotation_degrees = 0;
	elif direction == Vector2i(0,1):
		sprite.texture = down;
		#rotation_degrees = 90;
	elif direction == Vector2i(-1,0):
		sprite.texture = left;
		#rotation_degrees = 180;
	elif direction == Vector2i(0,-1):
		sprite.texture = up;
		#rotation_degrees = -90;
	#print(position);

func success():
	print("success villager: ", name);
	
	
