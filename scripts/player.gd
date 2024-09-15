extends CharacterBody2D

const SPEED = 100
var current_dir = "none"

func _ready():
	$AnimatedSprite2D.play("front_idle")

func _physics_process(_delta: float):
	player_movement(_delta)
	
func player_movement(_delta: float):
	if Input.is_action_pressed("ui_right"):
		current_dir = "right"
		play_animation(1)
		velocity.x = SPEED
		velocity.y = 0
	elif Input.is_action_pressed("ui_left"):
		current_dir = "left"
		play_animation(1)
		velocity.x = -SPEED
		velocity.y = 0
	elif Input.is_action_pressed("ui_down"):
		current_dir = "down"
		play_animation(1)
		velocity.x = 0
		velocity.y = SPEED
	elif Input.is_action_pressed("ui_up"):
		current_dir = "up"
		play_animation(1)
		velocity.x = 0
		velocity.y = -SPEED
	else:
		play_animation(0)
		velocity.x = 0
		velocity.y = 0
		
	move_and_slide()

func play_animation(movement: int):
	var dir = current_dir
	var animation = $AnimatedSprite2D
	
	if dir == "right":
		animation.flip_h = false
		play_animation_direction("side", movement, animation)
	elif dir == "left":
		animation.flip_h = true
		play_animation_direction("side", movement, animation)
	elif dir == "up":
		animation.flip_h = false
		play_animation_direction("back", movement, animation)
	elif dir == "down":
		animation.flip_h = false
		play_animation_direction("front", movement, animation)

func play_animation_direction(direction: String, movement: int, animation: AnimatedSprite2D):
	if movement == 1:
		animation.play(direction + "_walk")
	elif movement == 0:
		animation.play(direction + "_idle")
