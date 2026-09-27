extends Node2D

@export var tileMap : TileMapLayer;

var headPos = Vector2i(0,0);

var body = [headPos];

var order = [Vector2i(1, 0), Vector2i(1, 0), Vector2i(1, 1)]


func drawRoot():
	for i in range(body.size()):
		tileMap.set_cell(body[i], 1, order[i % order.size()]);

func checkNextPos(nextPos: Vector2i) -> bool:
	return tileMap.get_cell_atlas_coords(nextPos) == Vector2i(0,0) or tileMap.get_cell_atlas_coords(nextPos) == Vector2i(-1,-1);

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if Input.is_action_just_pressed("Up"):
		if checkNextPos(headPos + Vector2i(0,-1)):
			headPos += Vector2i(0,-1);
			body.push_front(headPos);
			#tileMap.set_cell(headPos, 1, Vector2i(1,0))
		#print(pos, " ", tileMap.get_cell_atlas_coords(pos), " ", tileMap.get_cell_atlas_coords(Vector2i(1,0)))
	elif Input.is_action_just_pressed("Down"):
		if checkNextPos(headPos + Vector2i(0,1)):
			headPos += Vector2i(0,1);
			body.push_front(headPos);
			#tileMap.set_cell(headPos, 1, Vector2i(1,0));
	elif Input.is_action_just_pressed("Left"):
		if checkNextPos(headPos + Vector2i(-1,0)):
			headPos += Vector2i(-1,0);
			body.push_front(headPos);
			#tileMap.set_cell(headPos, 1, Vector2i(1,0))
	elif Input.is_action_just_pressed("Right"):
		if checkNextPos(headPos + Vector2i(1,0)):
			headPos += Vector2i(1,0);
			body.push_front(headPos);
			#tileMap.set_cell(headPos, 1, Vector2i(1,0))
	drawRoot();
	if Input.is_action_just_pressed("check"):
		print(headPos, " ", body)
	
