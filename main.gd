extends Node
export(PackedScene) var mob_scene
var score = 0
export var label_text : String
var hud
var gameRunning = false

func _ready():
	hud = get_node("HUD")
	randomize()
	new_game()
	
	
func game_over():
	$ScoreTimer.stop()
	$MobTimer.stop()

func new_game():
	hud.on_ScoreChange(0)
	$Player.start()
	$StartTimer.start()
	
func _on_ScoreTimer_timeout():
	if gameRunning:
		score += 1
		hud.on_ScoreChange(score)
	
	

func _on_StartTimer_timeout():
	if gameRunning:
		$MobTimer.start()
		$ScoreTimer.start()


func _on_MobTimer_timeout():
	print(gameRunning)
	if gameRunning :
		var mob = mob_scene.instance()
		# Choose a random location on Path2D.
		var mob_spawn_location = get_node("MobPath/MobSpawnLocation")
		mob_spawn_location.offset = randi()

		# Set the mob's direction perpendicular to the path direction.
		var direction = mob_spawn_location.rotation + PI / 2

		# Set the mob's position to a random location.
		mob.position = mob_spawn_location.position

		# Add some randomness to the direction.
		direction += rand_range(-PI / 4, PI / 4)
		mob.rotation = direction

		# Choose the velocity for the mob.
		var velocity = Vector2(rand_range(100.0, 450.0), 0.0)
		mob.linear_velocity = velocity.rotated(direction)

		# Spawn the mob by adding it to the Main scene.
		add_child(mob)

func _on_messageTimer_timeout():
	$HUD/Message.hide()# Replace with function body.



func _on_HUD_start_game():
	gameRunning = true;
	$Player.start()


func _on_Player_hit():
	gameRunning = false
	hud.restart()
