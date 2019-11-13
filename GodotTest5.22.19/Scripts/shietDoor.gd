extends KinematicBody2D

onready var maxHealth := 1
onready var currentHealth = maxHealth
# Declare member variables here. Examples:
# var a = 2
# var b = "text"

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

func takeDamage(damage : int):
	currentHealth -= damage
	if(currentHealth <= 0):
		queue_free()
