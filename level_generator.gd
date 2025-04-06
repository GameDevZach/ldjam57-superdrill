extends Node2D

@export var NOISE: NoiseTexture2D
@export var max_x:= 100.0 #3000
@export var max_y:= 100.0 #2000
@onready var noise = NOISE.noise
var startingCellY: int = 4;
var stayAheadOfPlayerByCells: int = 8;
var cellSize: float = 138;
var leftOffset: float = 110;
var currentCellY: int = startingCellY;
var columnCount: int = 7;
@export var block_scene: PackedScene;

func _ready() -> void:
	#randomize()
	NOISE.noise.seed = randi()
	noise.fractal_octaves = 2
	noise.fractal_gain = 0.5
	noise.fractal_lacunarity = 2
	
func _process(delta: float):
	var farthestCellY = stayAheadOfPlayerByCells + floor(Global.playerY / cellSize);
	if(currentCellY < farthestCellY):
		generate_rows(farthestCellY - currentCellY);
		return;
		
func generate_rows(newRows: int):
	for n in newRows:
		currentCellY += 1;
		for n2 in columnCount:
			var noise_val = noise.get_noise_2d(n2,currentCellY)
			if(noise_val > 0):
				var spawned = block_scene.instantiate();
				get_parent().add_child(spawned);
				spawned.global_position = Vector2(n2 * cellSize + leftOffset, currentCellY * cellSize);
