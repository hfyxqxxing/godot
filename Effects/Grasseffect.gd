extends Node2D

#其实可以放在每一个艹的场景里。
onready var animationSprite = $AnimatedSprite

func _ready():
	animationSprite.frame = 0
	animationSprite.play("grass")
	


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass


func _on_AnimatedSprite_animation_finished():
	queue_free()
