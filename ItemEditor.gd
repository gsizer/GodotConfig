extends PopupPanel

const dataPath : String = "user://itemData/"
const fileName : String = "items.txt"

var dataFile : File = File.new()
var err := NOTIFICATION_READY
var data

func ReadData():
	err = dataFile.open( dataPath + fileName, File.READ_WRITE )
	match err:
		ERR_FILE_NOT_FOUND:
			var d = Directory.new()
			d.make_dir_recursive( dataPath )
		OK:
			data = dataFile.get_var( true )
		_:
			print("ItemEditor Read Error: ", err)

func WriteData():
	err = dataFile.open( dataPath + fileName, File.WRITE_READ )
	match err:
		OK:
			dataFile.store_var( data )
		_:
			print("ItemEditor Read Error: ", err)

func _ready():
	ReadData()

func _notification(what):
	match what:
		NOTIFICATION_WM_QUIT_REQUEST:
			WriteData()
			if( dataFile.is_open() ):
				dataFile.close()
			return

######################################
#	GUI Bindings
######################################

func _on_txtDesc_text_changed():
	pass # Replace with function body.

func _on_obItemType_item_selected(index):
	pass # Replace with function body.

func _on_obRarity_item_selected(index):
	pass # Replace with function body.

func _on_leDmgVal_text_changed(new_text):
	pass # Replace with function body.

func _on_ilDmgType_item_selected(index):
	pass # Replace with function body.

func _on_leResVal_text_changed(new_text):
	pass # Replace with function body.

func _on_ilResType_item_selected(index):
	pass # Replace with function body.

func _on_btnLoad_pressed():
	ReadData()

func _on_btnFirst_pressed():
	pass # Replace with function body.

func _on_btnPrev_pressed():
	pass # Replace with function body.

func _on_btnNext_pressed():
	pass # Replace with function body.

func _on_btnLast_pressed():
	pass # Replace with function body.

func _on_btnNew_pressed():
	pass # Replace with function body.

func _on_btnSave_pressed():
	WriteData()
