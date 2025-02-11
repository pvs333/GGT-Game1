extends Node2D

const BULLET = preload("res://Player/bullet.tscn")
@onready var muzzle: Marker2D = $muzzle




func _ready():
	pass 

func _process(delta):
	
	
	if Input.is_action_just_pressed("shoot2"):
		
		var bullet_instance = BULLET.instantiate()
		get_tree().root.add_child(bullet_instance)
		bullet_instance.global_position = muzzle.global_position
		bullet_instance.rotation = rotation + randf_range(deg_to_rad(-1),deg_to_rad(1))
