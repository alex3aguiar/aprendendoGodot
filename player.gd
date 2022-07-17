extends Area2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"

signal hit
# Called when the node enters the scene tree for the first time.
func _ready():
	screen_size = get_viewport_rect().size
	pass # Replace with function body.




export var speed = 800 # How fast the player will move (pixels/sec).
var screen_size # Size of the game window
func _process(delta):
	var velocity = Vector2.ZERO # The player's movement vector.
	if Input.is_action_pressed("move_right"):
		velocity.x += 1
	if Input.is_action_pressed("move_left"):
		velocity.x -= 1
	if Input.is_action_pressed("move_down"):
		velocity.y += 1
	if Input.is_action_pressed("move_up"):
		velocity.y -= 1

	if velocity.length() > 0:
		velocity = velocity.normalized() * speed
		$AnimatedSprite.play()
	else:
		$AnimatedSprite.stop()
	if velocity.x != 0:
		$AnimatedSprite.animation = "walk"
		$AnimatedSprite.flip_v = false
		# See the note below about boolean assignment.
		$AnimatedSprite.flip_h = velocity.x < 0
	elif velocity.y != 0:
		$AnimatedSprite.animation = "up"
		$AnimatedSprite.flip_v = velocity.y > 0
		
	$AnimatedSprite.flip_h = velocity.x < 0
	
	
	position += velocity * delta
	position.x = clamp(position.x, 0, screen_size.x)
	position.y = clamp(position.y, 0, screen_size.y)
	
func start():
	position.x = 500
	position.y = 370
	$CollisionShape2D.set_deferred("disabled", false)
	show()
	

func _on_Area2D_body_entered(body):
	hide() # Player disappears after being hit.
	emit_signal("hit")
	# Must be deferred as we can't change physics properties on a physics callback.
	$CollisionShape2D.set_deferred("disabled", true)
