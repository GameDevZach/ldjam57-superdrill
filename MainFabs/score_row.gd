extends HBoxContainer

@onready var nameLabel: Label = $Label;
@onready var scoreLabel: Label = $Label2;
var myplace: int;
var username: String;
var score: int;

func setScoreRow(place, uname, sc):
	myplace = place;
	username = uname;
	score = sc;
	setLabels();

func _ready():
	setLabels();
	
func setLabels():
	nameLabel.text = str(myplace) + "." + username;
	scoreLabel.text = str(score) + " pts";
