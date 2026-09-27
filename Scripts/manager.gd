extends Node2D

@export var tileMap : TileMapLayer;
@export var villager : PackedScene;



var headPos = Vector2i(0,0);

var body = [];

var order = [0,0,1]

var directions = [Vector2i(3,3)];
var direction = Vector2i(0,0);

var GameOver = false;


func drawRoot():
	for i in range(body.size()):
		#tileMap.set_cell(body[i], 1, order[i % order.size()]);
		if (order[i % order.size()] && directions[i].y <= 1):
			tileMap.set_cell(body[i], 1, directions[i] + Vector2i(0,2));
		else:
			tileMap.set_cell(body[i], 1, directions[i]);

func checkNextPos(nextPos: Vector2i) -> bool:
	var atlasCoords = tileMap.get_cell_atlas_coords(nextPos);
	if (0 <= atlasCoords.y && atlasCoords.y <= 3): 
		if (0 <= atlasCoords.x && atlasCoords.x <= 1):
			return true;
	elif (3 < atlasCoords.y && atlasCoords.y <= 5):
		if (0 <= atlasCoords.x && atlasCoords.x <= 2):
			return true;
	elif atlasCoords == Vector2i(-1,-1):
		return true;
	return false;
		
	#return tileMap.get_cell_atlas_coords(nextPos) == Vector2i(0,0) or tileMap.get_cell_atlas_coords(nextPos) == Vector2i(-1,-1);

func check_straight(pos, dir) -> bool:	
	var atlasCoords = tileMap.get_cell_atlas_coords(pos + dir);
	if (2 <= atlasCoords.y && atlasCoords.y <=3):
		if (12 <= atlasCoords.x && atlasCoords.x <=13):
			return check_straight(pos + dir, dir);
	elif atlasCoords == Vector2i(3,4):
		return true;
	else:
		return false;
	return false;
	"""
	if tileMap.get_cell_atlas_coords(pos + dir) == Vector2i(1,1):
		return check_straight(pos + dir, dir);
	elif tileMap.get_cell_atlas_coords(pos + dir) == Vector2i(0,1):
		return true;
	else:
		return false;
	"""

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
			if direction != Vector2i(0,-1):
				if direction == Vector2i(1,0):
					directions[0] = (Vector2i(13,5));
				elif direction == Vector2i(-1,0):
					directions[0] = (Vector2i(12,5));
				else:
					pass
					#directions[0] = (Vector2i(12,0));
			else:
				directions[0] = (Vector2i(12,0));
			directions.push_front(Vector2i(12,6));
			headPos += Vector2i(0,-1);
			body.push_front(headPos);
			direction = Vector2i(0,-1);
			#tileMap.set_cell(headPos, 1, Vector2i(1,0))
		#print(pos, " ", tileMap.get_cell_atlas_coords(pos), " ", tileMap.get_cell_atlas_coords(Vector2i(1,0)))
	elif Input.is_action_just_pressed("Down"):
		if checkNextPos(headPos + Vector2i(0,1)):
			if direction != Vector2i(0,1):
				if direction == Vector2i(1,0):
					directions[0] = (Vector2i(13,4));
				elif direction == Vector2i(-1,0):
					directions[0] = (Vector2i(12,4));
				else:
					pass
					#directions[0] = (Vector2i(12,1));
			else:
				directions[0] = (Vector2i(12,1));
			directions.push_front(Vector2i(12,7));
			headPos += Vector2i(0,1);
			body.push_front(headPos);
			direction = Vector2i(0,1);
			#tileMap.set_cell(headPos, 1, Vector2i(1,0));
	elif Input.is_action_just_pressed("Left"):
		if checkNextPos(headPos + Vector2i(-1,0)):
			if direction != Vector2i(-1,0):
				if direction == Vector2i(0,1):
					directions[0] = (Vector2i(13,5));
				elif direction == Vector2i(0,-1):
					directions[0] = (Vector2i(13,4));
				else:
					pass
					#directions[0] = (Vector2i(13,1));
			else:
				directions[0] = (Vector2i(13,1));
			directions.push_front(Vector2i(13,7));
			headPos += Vector2i(-1,0);
			body.push_front(headPos);
			direction = Vector2i(-1,0);
			#tileMap.set_cell(headPos, 1, Vector2i(1,0))
	elif Input.is_action_just_pressed("Right"):
		if checkNextPos(headPos + Vector2i(1,0)):
			if direction != Vector2i(1,0):
				if direction == Vector2i(0,1):
					directions[0] = (Vector2i(12,5));
				elif direction == Vector2i(0,-1):
					directions[0] = (Vector2i(12,4));
				else:
					pass
					#directions[0] = (Vector2i(13,0));
			else:
				directions[0] = (Vector2i(13,0));
			directions.push_front(Vector2i(13,6));
			headPos += Vector2i(1,0);
			body.push_front(headPos);
			direction = Vector2i(1,0);
			#tileMap.set_cell(headPos, 1, Vector2i(1,0))
	#print(body, " ", directions)
	drawRoot();
	if Input.is_action_just_pressed("check"):
		#print(headPos, " ", body);
		check_solution();
	
