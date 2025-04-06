extends Area2D

@export var droppables: Array[PackedScene];
@export var dropchances: Array[float];
@onready var AnimPlayer: AnimationPlayer = $AnimationPlayer;
var clicksToOpen: int = 0;
var Random: RandomNumberGenerator;

func _ready():
	Random = RandomNumberGenerator.new();
	Random.randomize();
	reset();
	
func _on_input_event(viewport: Node, event: InputEvent, shape_idx: int) -> void:
	if event.is_action_pressed("left_click"):
		if(AnimPlayer.is_playing()): return;

		clicksToOpen -= 1;
		if(clicksToOpen <= 0):
			print("opened!");
			dropLoot();
			setClicks();
			AnimPlayer.play("GeodeSplode")
		else:
			Global.currentScore = 0;
			AnimPlayer.play("GeodeClick");

func reset():
	setClicks();
	
func setClicks():
	clicksToOpen = 6;
	while(clicksToOpen > 1 and Random.randf() > 0.5):
		clicksToOpen -= 1;
	while(Random.randf() < 0.75):
		clicksToOpen += 1;
	print("Clicks now set to: " + str(clicksToOpen));
	
func dropLoot():
	var amnt = pow(10,Random.randf()*Random.randf());
	for i in amnt:
		for n in dropchances.size():
			if(n == dropchances.size() - 1 or Random.randf() < dropchances[n]):
				var newDrop = droppables[n].instantiate();
				get_tree().get_root().add_child(newDrop);
				newDrop.global_position = global_position;
				break;
