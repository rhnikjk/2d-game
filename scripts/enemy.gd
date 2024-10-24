extends CharacterBody2D

var health = 0
var detect = 0
var SPEED = 0
var momentum = 0
var spn = 0
const JUMP_VELOCITY = -240.0

# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")
@onready var sprite = $AnimatedSprite2D

func _physics_process(delta):
		# Add the gravity.
		if not is_on_floor():
			velocity.y += gravity * delta


		# Handle jump.
		if Input.is_action_just_pressed("ui_up") and is_on_floor():
			velocity.y = JUMP_VELOCITY

		# Get the input direction and handle the movement/deceleration.
		# Get direction of player (-1 left, 0 unchanged, 1 right)
		# Get the input direction and handle the movement/deceleration.
		# Get direction of player (-1 left, 0 unchanged, 1 right)
		var direction = Input.get_axis("ui_left", "ui_right")

		# Variables for handling movement
		var acceleration = 20  # Adjust this for faster/slower acceleration
		var max_speed = 32    # Maximum speed
		var friction = 5      # Adjust this for faster/slower deceleration
		var gravity = 7      # Gravity value
		# Flip character based on direction
		if direction > 0:
			sprite.flip_h = false
		elif direction < 0:
			sprite.flip_h = true
		if direction == 0:
			sprite.play("Idle")
			sprite.play("e")
		else:
			sprite.play("run")
			sprite.play("e")
		# Apply acceleration or deceleration
		if is_on_floor():
			if direction != 0:
				velocity.x += acceleration * direction
				velocity.x = clamp(velocity.x, -max_speed, max_speed)  # Clamp velocity to max_speed
			else:
				# Decelerate when no input is given
				if velocity.x > 0:
					velocity.x = max(0, velocity.x - friction)
				elif velocity.x < 0:
					velocity.x = min(0, velocity.x + friction)
		else:
		# Apply gravity if in the air
			velocity.y += gravity


		# Apply velocity to the character's position
		position.x += velocity.x * delta
		

		move_and_slide()

func _on_area_2d_area_entered(area):
	if area.is_in_group("bullet"):
		health +=1
		print(health)
		if health == 2:
			spn += 1
			if spn == 2:
				velocity.y = -100000000000
			else:
				detect = 1
				velocity.y = -5000
				health = 0
				sprite.play("dead")
				sprite.play("e")
				sprite.play("e")
				sprite.play("e")
				sprite.play("e")
				sprite.play("e")
				print("deadd")
