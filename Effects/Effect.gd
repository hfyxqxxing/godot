extends AnimatedSprite

#其实可以放在每一个艹的场景里。因为换成根节点所以不需要引用
#onready var animationSprite = $AnimatedSprite

func _ready():
	self.connect("animation_finished",self,"_on_animation_finished")
	frame = 0
	play("animation")
	


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass


func _on_animation_finished():
	queue_free()

