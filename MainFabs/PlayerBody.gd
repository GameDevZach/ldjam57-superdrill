extends RigidBody2D

@onready var DrillStream: AudioStreamPlayer = $AudioStreamPlayer2
var cooldown: float = 0;
var cooldownFull: float = 0.2;
var hittingBlock: BlockArea = null;
var viewHalfWidth: int;

func _ready() -> void:
	DrillStream.stream_paused = true;
	viewHalfWidth = get_viewport().size.x / 2;

func _physics_process(delta: float) -> void:
	var mousePressed = Input.is_mouse_button_pressed(MOUSE_BUTTON_LEFT);
	var mouseDeltaFromCenter = get_viewport().get_mouse_position().x - viewHalfWidth if mousePressed else 0;
	
	if Input.is_action_pressed("ui_left") or mouseDeltaFromCenter < 0:
		apply_impulse(Vector2(-4,0));
		
	if Input.is_action_pressed("ui_right") or mouseDeltaFromCenter > 0:
		apply_impulse(Vector2(4,0));
		
	cooldown -= delta;
	Global.playerY = position.y;
	
func Hit(block: BlockArea):
	print("hit");
	
	apply_impulse(Vector2(0,-linear_velocity.y - 500))
