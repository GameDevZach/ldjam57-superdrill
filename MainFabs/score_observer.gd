extends Control

@onready var scoreTracker: Label = $Label;
var localTrack: int = 0;

func _ready():
	scoreTracker.text = "";
	
func _process(delta: float) -> void:
	if(Global.currentScore > 0):
		scoreTracker.text = str(localTrack) + "pts";
		if(localTrack < Global.currentScore):
			localTrack += ceil((Global.currentScore - localTrack)*0.1);
	else:
		scoreTracker.text = "";
		localTrack = 0;
