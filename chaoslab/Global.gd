extends Node

var currentMoney: int = 1000
var currentChaos: int = 500
var currentTime = 0
var displayTime: String

@onready var playerCharacter = $PlayerCharacter

enum GameState {
	DEFAULT,
	MINIGAME,
	MENU
}

func _process(delta: float) -> void:
	_calculate_time(delta)
	
func _change_chaos(chaos: int) -> void:
	currentChaos += chaos
	
func _change_money(money: int) -> void:
	currentMoney += money
	
func _calculate_time(delta) -> void:
	currentTime += delta
	var minutes = int(currentTime) / 60
	var seconds = int(currentTime) % 60
	displayTime = "%02d:%02d" % [minutes, seconds]
