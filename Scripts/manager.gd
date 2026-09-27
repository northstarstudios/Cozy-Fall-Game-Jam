extends Node2D

@export var tileMap : TileMapLayer;
@export var villager : PackedScene;



var headPos = Vector2i(0,0);

var body = [];

var order = [Vector2i(1, 0), Vector2i(1, 0), Vector2i(1, 1)]

var GameOver = false;


func drawRoot():
	for i in range(body.size()):
		tileMap.set_cell(body[i], 1, order[i % order.size()]);

func checkNextPos(nextPos: Vector2i) -> bool:
	return tileMap.get_cell_atlas_coords(nextPos) == Vector2i(0,0) or tileMap.get_cell_atlas_coords(nextPos) == Vector2i(-1,-1);

func check_straight(pos, dir) -> bool:	
	if tileMap.get_cell_atlas_coords(pos + dir) == Vector2i(1,1):
		return check_straight(pos + dir, dir);
	elif tileMap.get_cell_atlas_coords(pos + dir) == Vector2i(0,1):
		return true;
	else:
		return false;

func check_solution():
	var correct = true;
	for child in get_children():
		if check_straight(child.StartPosition, child.direction): #tileMap.get_cell_atlas_coords(child.StartPosition + child.direction) == Vector2i(1,1):
			child.success();
			#print("succes manager")
		else:
			correct = false;
			break;
	if correct:
		var GameOverlay = get_node("../../../CanvasLayer/GameOverlay");
		GameOverlay.showWinScreen();
		GameOver = true;
		
		
			

func _ready() -> void:
	for cell in tileMap.get_used_cells():
		if tileMap.get_cell_tile_data(cell).get_custom_data("Direction") == Vector2i(1,0):
			var newVillager = villager.instantiate();
			newVillager.StartPosition = cell;
			newVillager.direction = Vector2i(1,0);
			newVillager.manager = self;
			newVillager.name = var_to_str(cell);
			add_child(newVillager);
		elif tileMap.get_cell_tile_data(cell).get_custom_data("Direction") == Vector2i(0,1):
			var newVillager = villager.instantiate();
			newVillager.StartPosition = cell;
			newVillager.direction = Vector2i(0,1);
			newVillager.manager = self;
			newVillager.name = var_to_str(cell);
			add_child(newVillager);
		elif tileMap.get_cell_tile_data(cell).get_custom_data("Direction") == Vector2i(-1,0):
			var newVillager = villager.instantiate();
			newVillager.StartPosition = cell;
			newVillager.direction = Vector2i(-1,0);
			newVillager.manager = self;
			newVillager.name = var_to_str(cell);
			add_child(newVillager);
		elif tileMap.get_cell_tile_data(cell).get_custom_data("Direction") == Vector2i(0,-1):
			var newVillager = villager.instantiate();
			newVillager.StartPosition = cell;
			newVillager.direction = Vector2i(0,-1);
			newVillager.manager = self;
			newVillager.name = var_to_str(cell);
			add_child(newVillager);
		if tileMap.get_cell_tile_data(cell).get_custom_data("StartPos"):
			headPos = cell;
	body.push_back(headPos);

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if GameOver:
		return;
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
		#print(headPos, " ", body);
		check_solution();
	
