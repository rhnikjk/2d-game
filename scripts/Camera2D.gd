extends Camera2D


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	var player = get_parent()  # This gets the player node, assuming the camera is a direct child of the player
	var target_position = player.position
	position = position.lerp(target_position, 1)
