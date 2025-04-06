class_name BlockArea
extends Area2D

@export var hp: int = 30;
@export var armor: int = 1;
var parNode;

var entered: bool = false;
var isColliding: bool = false;
var player: Node;

func _ready():
	parNode = get_parent();

func Reset():
	entered = false;
	isColliding = false;
	return;

func _on_body_entered(body: Node2D) -> void:
	if(!body.has_method("Hit")): return;
	
	if(!entered):
		body.Hit(self);
		player = body;
		entered = true;
		isColliding = true;
	return;
	
func deactivate():
	Global.InactiveBlocks.append(self);
	self.set_process_mode(Node.PROCESS_MODE_DISABLED);
	get_tree().get_root().remove_child(get_parent());
	monitoring = false;
	if(isColliding):
		player_leave(player);
	


func _on_body_exited(body: Node2D) -> void:
	player_leave(body);
	return;

func player_leave(body: Node2D):
	if(!body.has_method("Hit")): return;
	
	if(entered):
		entered = false;
		
