extends CharacterBody2D

const PLAYABLE_SPEED: float = 200
const JUMP_VEL: float = -1000
const GRAVITY: float = 750

var grav_vel: float = 0
var jumps_remaining: int = 3

func _physics_process(delta):
	if Input.is_action_pressed("Move Right"):
		position.x += PLAYABLE_SPEED * delta
		$idle.flip_h = false
		$attack.flip_h = false
	if Input.is_action_pressed("Move Left"):
		position.x -= PLAYABLE_SPEED * delta
		$idle.flip_h = true
		$attack.flip_h = true
	position.y += grav_vel * delta
	grav_vel += GRAVITY * delta
	if Input.is_action_just_pressed("Jump") and jumps_remaining > 0:
		$anim.play("idle")
		jump()
		jumps_remaining -= 1

func jump() -> void:
	grav_vel = JUMP_VEL

func attack():
	set_physics_process(false)
	$anim.play("attack")
	await $anim.animation_finished
	set_physics_process(true)
