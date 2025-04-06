extends Control

@onready var ScoresBox: VBoxContainer = $ScrollContainer/VBoxContainer;
@onready var Webby: HTTPRequest = $HTTPRequest;
@onready var RefreshButton: Button = $Button;
var url: String = "https://sqlite-gamejam-highscores.glitch.me/"
var headers: Array[String] = ["Content-Type: application/json"];
@export var RowPrefab: PackedScene;
var scoreRows;
var cooldown: float = 10;


func _ready():
	fetchScores()

func _process(delta: float) -> void:
	if(cooldown > 0):
		cooldown -= delta;
		if(cooldown <= 0):
			RefreshButton.disabled = false;
		
func fetchScores():
	cooldown = 10;
	RefreshButton.disabled = true;
	Webby.set_tls_options((TLSOptions.client_unsafe()));
	Webby.request(url+"scores",headers, HTTPClient.METHOD_GET);


func _on_http_request_request_completed(result: int, response_code: int, headers: PackedStringArray, body: PackedByteArray) -> void:
	var json = JSON.parse_string(body.get_string_from_utf8());
	#print(json["highscores"]);
	scoreRows = [];
	for n in json["highscores"].size():
		var dataRow = json["highscores"][n];
		var newRow = RowPrefab.instantiate();
		ScoresBox.add_child(newRow);
		newRow.setScoreRow(n + 1, dataRow["username"], dataRow["score"])
		scoreRows.append(newRow);

# refresh button
func _on_button_pressed() -> void:
	
	for n in scoreRows.size():
		ScoresBox.remove_child(scoreRows[n]);
		scoreRows[n].queue_free();
		
	fetchScores()
