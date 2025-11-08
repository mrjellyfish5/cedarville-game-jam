extends Control

var final_score
var max_score = 100
var message

func _ready() -> void:
	final_score = Score.moths + Score.lamps
	$RichTextLabel.text = "Mission Results\nMoths: " + str(Score.moths) + "\nLamps: " + str(Score.lamps) + "\nFinal Score: " + str(final_score)

	$anim.play("scroll out")

	if Score == max_score:
		
