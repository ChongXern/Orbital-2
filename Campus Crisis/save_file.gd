extends Resource
class_name SaveGame

const SAVE_GAME_PATH = "user://save_file"

@export var coins = 0
@export var speedBoost = false
@export var biggerTagArea = false
@export var torch_collected = false
@export var horn_collected = false
@export var spray_collected = false

func write_savegame(id: String) -> void:
	var save_path = str(SAVE_GAME_PATH + id + '.tres')
	ResourceSaver.save(self, save_path)

static func save_exists(id: String) -> bool:
	var save_path = str(SAVE_GAME_PATH + id + '.tres')
	return ResourceLoader.exists(save_path)

static func load_savegame(id: String) -> Resource:
	var save_path = str(SAVE_GAME_PATH + id + '.tres')
	return ResourceLoader.load(save_path, "", 2)
