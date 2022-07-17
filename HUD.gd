extends CanvasLayer

var score
signal start_game
func on_ScoreChange(value):
	$ScoreLabel.text = str(value)


func _on_StartButton_pressed():
	$StartButton.hide()
	$Message.hide()
	emit_signal("start_game")

func restart():
	$StartButton.show()
	$Message.show()
