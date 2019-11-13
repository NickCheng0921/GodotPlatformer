extends KinematicBody2D
var velocity = Vector2()
onready var maxHealth := 1
onready var currentHealth = maxHealth
export (float) var runSpeed = 80
export(float) var jumpHeight = 40
export(float) var jumpTime = 0.3
var spriteFacingRight = true
#value used for updating skeleton Health bar
var value
var dead := false 
#was spawned as child of SpiderBoss so nodepath changes so don't use get_node
#var player : KinematicBody2D 

onready var player:= get_node("../Player")  

# Called when the node enters the scene tree for the first time.
func _ready():
	pass
	
func takeDamage(damage : int):
	currentHealth -= damage
	value = get_node("HealthBar").get_value()
	get_node("HealthBar").set_value(value - damage)
	if(currentHealth <= 0):
		dead = true
		$AnimationPlayer.play("onDeath")
	
func _physics_process(delta):
	var move = 0.0
	var gravity = 2*jumpHeight/(jumpTime*jumpTime)
	
	if(dead):
		return
	
	#skeleton moves right
	if(position.x <= player.position.x):
		#make sure skele faces right way
		if(velocity.x > 0):
			$Sprite.flip_h = false
			#if(position.x - player.position.x <= 10 && !spriteFacingRight):
			#	$AnimationPlayer.play("skeletonAttack")
			#	return 
		move += 1
		$AnimationPlayer.play("enemySkeletonWalk")
	#skeleton moves left
	if(position.x >= player.position.x):
		if(velocity.x < 0):
			spriteFacingRight = false
		else:
			spriteFacingRight = true
		if(!spriteFacingRight):
			$Sprite.flip_h = true
			#if(position.x - player.position.x >= 10 && spriteFacingRight):
			#	$AnimationPlayer.play("skeletonAttack")
			#	return
		move -= 1
		$AnimationPlayer.play("enemySkeletonWalk")

		
	velocity.x = move * runSpeed
	velocity.y += gravity*delta
	# -y is up, +y is down
	velocity = move_and_slide(velocity, Vector2(0, -1))
