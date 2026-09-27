extends MarginContainer

@export var LevelGrid : GridContainer;

func unlockLevel(id : int):
	var children = LevelGrid.get_children()
	for i in range(LevelGrid.get_child_count()):
		if(i <= id):
			children[i].locked = false;
		else:
			children[i].locked = true;

func getLevels() -> Array[Node]:
	return LevelGrid.get_children();
			
