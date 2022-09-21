extends Control

var settingsWindow

# Called when the node enters the scene tree for the first time.
func _ready():
	settingsWindow = get_node("Settings")
	settingsWindow.popup()

func _input(event:InputEvent):
	if(event.is_action_released("ui_cancel")):
		$Settings.popup()
	if(event.is_action_released("ui_home")):
		$ItemEditor.popup_centered()
