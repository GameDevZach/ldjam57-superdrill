extends RigidBody2D

@export var basePoints: int;

func _ready():
	var val = max(0,round(basePoints * (0.8 + Global.Random.randf() * 0.4)));
	Global.increaseScore(val);
