extends CharacterBody2D

@onready var _animated_sprite = $AnimatedSprite2D
@onready var jump_sound = $JumpSound  # Pastikan JumpSound adalah AudioStreamPlayer

const SPEED = 300.0
const JUMP_VELOCITY = -400.0

enum States {IDLE, RUN, JUMP, FALL, ATTACK}
var current_state = States.IDLE

func change_state(new_state):
	current_state = new_state
	match current_state:
		States.IDLE:
			_animated_sprite.play("idle")
		States.RUN:
			_animated_sprite.play("run")
		States.FALL:
			_animated_sprite.play("fall")
		States.JUMP:
			_animated_sprite.play("jump")
		States.ATTACK:
			_animated_sprite.play("idle")

func _physics_process(delta: float) -> void:
	if current_state != States.ATTACK:
		# Terapkan gravitasi jika tidak di lantai
		if not is_on_floor():
			velocity += get_gravity() * delta

		# Tangani pergerakan horizontal
		var direction := Input.get_axis("move_left", "move_right")
		if direction != 0:
			velocity.x = direction * SPEED
			_animated_sprite.flip_h = direction < 0
		else:
			# Hentikan pergerakan horizontal sepenuhnya jika tombol dilepaskan
			velocity.x = 0

		# Tangani perubahan status
		if Input.is_action_just_pressed("jump") and is_on_floor():
			velocity.y = JUMP_VELOCITY
			change_state(States.JUMP)
			jump_sound.play()  # Putar suara saat melompat
		elif not is_on_floor():
			if velocity.y > 0:
				change_state(States.FALL)
			else:
				change_state(States.JUMP)
		elif is_on_floor():
			if direction != 0:
				change_state(States.RUN)
			elif Input.is_action_just_pressed("attack"):
				change_state(States.ATTACK)
			else:
				change_state(States.IDLE)

	# Pindahkan karakter
	move_and_slide()
