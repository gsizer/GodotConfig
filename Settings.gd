extends Node

const configPath : String = "user://settings.cfg"

var config : ConfigFile = ConfigFile.new()

######################################
#	set defaults
######################################
func Defaults():
	#	empty the configFile
	config.clear()
	#	add default values
	config.set_value( "Audio", "Ambient", 0.0 )
	config.set_value( "Audio", "Effects", 0.0 )
	config.set_value( "Audio", "Main", 0.0 )
	config.set_value( "Audio", "Music", 0.0 )
	config.set_value( "Audio", "Speech", 0.0 )
	config.set_value( "Audio", "Weather", 0.0 )
	#	interface
	config.set_value( "Interface", "Font", "default" )
	config.set_value( "Interface", "FontSize", 16 )
	#	Key Bindings
	config.set_value( "Bindings", "Home", KEY_HOME )
	config.set_value( "Bindings", "End", KEY_END )
	config.set_value( "Bindings", "PageUp", KEY_PAGEUP )
	config.set_value( "Bindings", "PageDown", KEY_PAGEDOWN )
	config.set_value( "Bindings", "Back", KEY_BACK )
	config.set_value( "Bindings", "Accept", KEY_ENTER)

######################################
#	save configuration to file
######################################
func WriteConfig():
	config.set_value("Audio", "Ambient", AudioServer.get_bus_volume_db( AudioServer.get_bus_index("Ambient") ) )
	config.set_value("Audio", "Effects", AudioServer.get_bus_volume_db( AudioServer.get_bus_index("Effects") ) )
	config.set_value("Audio", "Main", AudioServer.get_bus_volume_db( AudioServer.get_bus_index("Master") ) )
	config.set_value("Audio", "Music", AudioServer.get_bus_volume_db( AudioServer.get_bus_index("Music") ) )
	config.set_value("Audio", "Speech", AudioServer.get_bus_volume_db( AudioServer.get_bus_index("Speech") ) )
	config.set_value("Audio", "Weather", AudioServer.get_bus_volume_db( AudioServer.get_bus_index("Weather") ) )
	#	write config to file
	var err = config.save(configPath)
	match err:
		OK:
			pass
		_:
			print( "Settings Config Write Error: ", err )

######################################
#	read from configuration file
######################################
func ReadConfig():
	#	Read values from config
	AudioServer.set_bus_volume_db( AudioServer.get_bus_index("Ambient"), config.get_value("Audio", "Ambient", 0.0) )
	AudioServer.set_bus_volume_db( AudioServer.get_bus_index("Effects"), config.get_value( "Audio", "Effects", 0.0) )
	AudioServer.set_bus_volume_db( AudioServer.get_bus_index("Master"), config.get_value( "Audio", "Main", 0.0 ) )
	AudioServer.set_bus_volume_db( AudioServer.get_bus_index("Music"), config.get_value( "Audio", "Music", 0.0 ) )
	AudioServer.set_bus_volume_db( AudioServer.get_bus_index("Speech"), config.get_value( "Audio", "Speech", 0.0 ) )
	AudioServer.set_bus_volume_db( AudioServer.get_bus_index("Weather"), config.get_value( "Audio", "Weather", 0.0 ) )

######################################
#	copy audio server values to interface
######################################
func ApplyConfig():
	#	adjust user interface
	$VBoxContainer/TabContainer/Audio/HBoxAmbient/HSliderAmbient.value = AudioServer.get_bus_volume_db(AudioServer.get_bus_index("Ambient"))
	$VBoxContainer/TabContainer/Audio/HBoxEffects/HSliderEffects.value = AudioServer.get_bus_volume_db(AudioServer.get_bus_index("Effects"))
	$VBoxContainer/TabContainer/Audio/HBoxMain/HSliderMain.value = AudioServer.get_bus_volume_db(AudioServer.get_bus_index("Master"))
	$VBoxContainer/TabContainer/Audio/HBoxMusic/HSliderMusic.value = AudioServer.get_bus_volume_db(AudioServer.get_bus_index("Music"))
	$VBoxContainer/TabContainer/Audio/HBoxSpeech/HSliderSpeech.value = AudioServer.get_bus_volume_db(AudioServer.get_bus_index("Speech"))
	$VBoxContainer/TabContainer/Audio/HBoxWeather/HSliderWeather.value = AudioServer.get_bus_volume_db(AudioServer.get_bus_index("Weather"))

######################################
#	GUI Bindings : Audio
######################################
func _on_HSliderAmbient_value_changed(value):
	AudioServer.set_bus_volume_db(AudioServer.get_bus_index("Ambient"), value)

func _on_HSliderEffects_value_changed(value):
	AudioServer.set_bus_volume_db(AudioServer.get_bus_index("Effects"), value)

func _on_HSliderMain_value_changed(value):
	AudioServer.set_bus_volume_db(AudioServer.get_bus_index("Master"), value)

func _on_HSliderMusic_value_changed(value):
	AudioServer.set_bus_volume_db(AudioServer.get_bus_index("Music"), value)

func _on_HSliderSpeech_value_changed(value):
	AudioServer.set_bus_volume_db(AudioServer.get_bus_index("Speech"), value)

func _on_HSliderWeather_value_changed(value):
	AudioServer.set_bus_volume_db(AudioServer.get_bus_index("Weather"), value)

func _on_btnDefaults_pressed():
	Defaults()
	ReadConfig()
	ApplyConfig()

func _on_btnSave_pressed():
	Defaults()
	WriteConfig()
	ReadConfig()
	ApplyConfig()

######################################
#	get things done
######################################
func _ready():
	config = ConfigFile.new()
	var err = config.load(configPath)
	match err:
		OK:
			print("Read Configuration")
			ReadConfig()
			ApplyConfig()
		ERR_FILE_NOT_FOUND:
			print("Setting Default Configuration")
			Defaults()
			WriteConfig()
			ReadConfig()
			ApplyConfig()
		_:
			print("Settings Config Read Error: ", err)
