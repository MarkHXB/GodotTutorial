extends Node

signal experience_updated(current_experience: float, target_experience: float)

const target_experience_growth = 5

# fields
var current_experience = 0
var current_level = 1
var target_experience = 5

# overrides
func _ready():
	GameEvents.experience_vial_collected.connect(on_experience_vial_collected)

# private functions
func increment_experience(number: float):
	current_experience = min(current_experience + number, target_experience)
	experience_updated.emit(current_experience, target_experience)
	
	if current_experience == target_experience:
		current_level += 1
		target_experience += target_experience_growth
		current_experience = 0
		experience_updated.emit(current_experience, target_experience)

# events
func on_experience_vial_collected(number:float):
	increment_experience(number)
