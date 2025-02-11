extends CharacterBody2D

#Node references
@onready var gun_2: Node2D = $gun_2
@onready var animated_sprite_2d: AnimatedSprite2D = $AnimatedSprite2D

#constants
const GRAVITY : float = 1000.0
const JUMP_VELOCITY : float = -400.0
const RUN_VELOCITY : float = 150.0
const MAX_FALL : float = 600.0


enum PLAYER_STATE{IDLE, RUN, JUMP, HURT}  #for different actions and easy use of each state
var _state : PLAYER_STATE = PLAYER_STATE.IDLE  
var Health = 3
#to decide which side the character is facing
var direction

func _ready():
	pass


func _physics_process(delta):
	if is_on_floor() == false:
		velocity.y = min(velocity.y + GRAVITY * delta,MAX_FALL) #caps the value if falling for a long time
		
	handle_state_transitions() #input handling
	perform_state_actions(delta) #animation handling
	move_and_slide() 
	
func handle_state_transitions():
	
	if Input.is_action_just_pressed("jump2") and is_on_floor():
		_state = PLAYER_STATE.JUMP
		velocity.y = JUMP_VELOCITY

	direction  = Input.get_axis("left2","right2")
	if direction != 0:
		_state = PLAYER_STATE.RUN
		
	elif is_on_floor() and _state != PLAYER_STATE.JUMP:
		_state = PLAYER_STATE.IDLE
	

func perform_state_actions(delta): #add animations in here 
	match _state:
		PLAYER_STATE.IDLE:
			animated_sprite_2d.play("idle")
			velocity.x = move_toward(velocity.x,0,RUN_VELOCITY)
		PLAYER_STATE.JUMP:
			if velocity.y < 0:
				#add fall animation
				pass
			else:
				#add jump animation
				pass
		PLAYER_STATE.RUN:
			animated_sprite_2d.play("run")
			if(direction == 1):
				gun_2.rotation_degrees = 0
				animated_sprite_2d.flip_h = false
			else:
				gun_2.rotation_degrees = 180
				animated_sprite_2d.flip_h = true
			velocity.x = direction * RUN_VELOCITY
			
func _on_hitbox_area_entered(area: Area2D) -> void:
	if area.is_in_group("Bullet"):
		area.queue_free()
		hit()
		
func hit():
	Health -= 1
	if Health <= 0:
		GameManager.loses(2)
		queue_free()
		
