extends CharacterBody2D

@export var health = 1

func lamp_fall(direction):
	health -= 1
	if health <= 0:
		$crash.play()
		$CollisionShape2D.queue_free()
		$anim.play("fall_" + direction)
		await $anim.animation_finished
		queue_free()
	else:
		$hit.play()
		health -= 1
		$anim.play("swing")
