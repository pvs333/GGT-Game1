extends CharacterBody2D

#Node references
@onready var gun: Node2D = $Gun

#constants
const GRAVITY : float = 1000.0
const JUMP_VELOCITY : float = -600.0
const RUN_VELOCITY : float = 150.0
const MAX_FALL : float = 600.0


enum PLAYER_STATE{IDLE, RUN, JUMP, HURT}  #for different actions and easy use of each state
var _state : PLAYER_STATE = PLAYER_STATE.IDLE  

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
	
	if Input.is_action_just_pressed("jump") and is_on_floor():
		_state = PLAYER_STATE.JUMP
		velocity.y = JUMP_VELOCITY

	direction  = Input.get_axis("left","right")
	if direction != 0:
		_state = PLAYER_STATE.RUN
		
	elif is_on_floor() and _state != PLAYER_STATE.JUMP:
		_state = PLAYER_STATE.IDLE
	

func perform_state_actions(delta): #add animations in here 
	match _state:
		PLAYER_STATE.IDLE:
			#play idle animation
			velocity.x = move_toward(velocity.x,0,RUN_VELOCITY)
		PLAYER_STATE.JUMP:
			if velocity.y < 0:
				#add fall animation
				pass
			else:
				#add jump animation
				pass
		PLAYER_STATE.RUN:
			#add run animation
			if(direction == 1):
				gun.rotation_degrees = 0
			else:
				gun.rotation_degrees = 180
			velocity.x = direction * RUN_VELOCITY
			
