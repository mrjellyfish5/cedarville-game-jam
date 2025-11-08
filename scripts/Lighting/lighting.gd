extends CharacterBody2D

@export var health = 1
var dead = false

func lamp_fall(direction):
	health -= 1
	if health <= 0:
		dead = true
		$crash.play()
		$CollisionShape2D.queue_free()
		$anim.play("fall_" + direction)
		await $anim.animation_finished
		queue_free()
	else:
		$hit.play()
		health -= 1
		$anim.play("swing")


func _on_buzz_finished() -> void:
	$buzz.play()
