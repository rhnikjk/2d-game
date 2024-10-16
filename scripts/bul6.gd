extends CharacterBody2D
var detect = 0
const SPEED = 300.0
var move =0
# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")


func _physics_process(delta):
	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var direction = Input.get_axis("bullet left", "sh5")
	if direction == 1:
		move = 1
		velocity.x = move * SPEED*-1
		

	move_and_slide()

func _on_area_2d_area_entered(area):
	if area.is_in_group("enemy"):
		detect = 1
		velocity.x = 0
		print("dead")
