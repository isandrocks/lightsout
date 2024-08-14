extends Node


# Called when the node enters the scene tree for the first time.
func _ready():
	randomize()
	var grid_size = 5
	var pressed_buttons = 8
	var buttons = []
	
	# Collect all the buttons in the grid
	for row in range(1, grid_size + 1):
		for col in range(1, grid_size + 1):
			var button_path = "Panel/r%dc%d" % [row, col]
			var button = get_node(button_path)
			buttons.append(button)
	
	# Randomly select buttons to press
	for i in range(pressed_buttons):
		var index = randi() % buttons.size()
		flip_light(buttons[index])
		buttons[index].emit_signal("pressed")	
		buttons.remove_at(index)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	pass

func flip_light(node):
	if node.is_pressed():
		node.set_pressed_no_signal(false)
	else:
		node.set_pressed_no_signal(true)

func toggle_neighbors(row, col):
	var directions = [
		Vector2(0, 1),  # Right
		Vector2(0, -1), # Left
		Vector2(1, 0),  # Down
		Vector2(-1, 0)  # Up
	]	
	# Toggle the neighboring buttons
	for direction in directions:
		var new_row = abs(row + direction.x)
		var new_col = abs(col + direction.y)	
		var button_path = "Panel/r%dc%d" % [new_row, new_col]
		var button = get_node(button_path)
		if button != null:
			flip_light(button)
			

func _on_r1c1_pressed():
	toggle_neighbors(1, 1)

func _on_r1c2_pressed():
	toggle_neighbors(1, 2)

func _on_r1c3_pressed():
	toggle_neighbors(1, 3)

func _on_r1c4_pressed():
	toggle_neighbors(1, 4)

func _on_r1c5_pressed():
	toggle_neighbors(1, 5)

func _on_r2c1_pressed():
	toggle_neighbors(2, 1)

func _on_r2c2_pressed():
	toggle_neighbors(2, 2)

func _on_r2c3_pressed():
	toggle_neighbors(2, 3)

func _on_r2c4_pressed():
	toggle_neighbors(2, 4)

func _on_r2c5_pressed():
	toggle_neighbors(2, 5)

func _on_r3c1_pressed():
	toggle_neighbors(3, 1)

func _on_r3c2_pressed():
	toggle_neighbors(3, 2)

func _on_r3c3_pressed():
	toggle_neighbors(3, 3)

func _on_r3c4_pressed():
	toggle_neighbors(3, 4)

func _on_r3c5_pressed():
	toggle_neighbors(3, 5)

func _on_r4c1_pressed():
	toggle_neighbors(4, 1)

func _on_r4c2_pressed():
	toggle_neighbors(4, 2)

func _on_r4c3_pressed():
	toggle_neighbors(4, 3)

func _on_r4c4_pressed():
	toggle_neighbors(4, 4)

func _on_r4c5_pressed():
	toggle_neighbors(4, 5)

func _on_r5c1_pressed():
	toggle_neighbors(5, 1)

func _on_r5c2_pressed():
	toggle_neighbors(5, 2)

func _on_r5c3_pressed():
	toggle_neighbors(5, 3)

func _on_r5c4_pressed():
	toggle_neighbors(5, 4)

func _on_r5c5_pressed():
	toggle_neighbors(5, 5)

func _on_reset_pressed():
	get_tree().reload_current_scene()
