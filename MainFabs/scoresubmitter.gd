extends Control

@onready var inputField: TextEdit = $HBoxContainer/TextEdit;
@onready var submit: Button = $HBoxContainer/Button;
@onready var msg: Label = $Label;
@onready var placingLabel: Label = $Label2;
@onready var Webby: HTTPRequest = $HTTPRequest;
var highestSubmitted: int = 0;
var url: String = "https://sqlite-gamejam-highscores.glitch.me/"
var headers: Array[String] = ["Content-Type: application/json"];
var active: bool = false;

func _ready():
	msg.text = ""
	submit.disabled = true;

func _process(delta: float) -> void:
	if(Global.highestScore > highestSubmitted):
		active = true
		submit.disabled = false;
		msg.text = str(Global.highestScore) + "pts :: New personal best! Submit online?"
		
# try to submit
func _on_button_pressed() -> void:
	if(Global.highestScore > highestSubmitted and inputField.text.length() > 0):
		active = false
		submit.disabled = true;
		msg.text = "Submitted score!"
		highestSubmitted = Global.highestScore
		Webby.set_tls_options((TLSOptions.client_unsafe()));
		var json = JSON.stringify({ "username": inputField.text, "newscore": Global.highestScore });
		Webby.request(url + "subscore", headers, HTTPClient.METHOD_POST, json);


func _on_http_request_request_completed(result: int, response_code: int, headers: PackedStringArray, body: PackedByteArray) -> void:
	var json = JSON.parse_string(body.get_string_from_utf8());
	placingLabel.text = "You're #" + str(int(json["place"]));
