extends CharacterBody2D

func lamp_fall(direction):
	$crash.play()
	$CollisionShape2D.queue_free()
	$anim.play("fall_" + direction)
	await $anim.animation_finished
	queue_free()
