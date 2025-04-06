extends Node

# player stats
var damage: int = 10;
var heatShield: int = 100;
var battery: int = 60;
var armorPiercing: float = 0;
var speedCore: float = 1;
var highestScore: int = 0;
var currentScore: int = 0;
var Random: RandomNumberGenerator;

var playerY: float = 0;
var InactiveBlocks: Array[BlockArea] = [];

func _ready():
	Random = RandomNumberGenerator.new()
	
func increaseScore(num: int):
	currentScore += num;
	if(currentScore > highestScore):
		highestScore = currentScore;
