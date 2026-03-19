extends Node2D

var letters := {
	'А': '.-',
	'Б': '-...',
	'В': '.--',
	'Г': '--.',
	'Д': '-..',
	'Е': '.',
	'Ж': '...-',
	'З': '--..',
	'И': '..',
	'Й': '.---',
	'К': '-.-',
	'Л': '.-..',
	'М': '--',
	'Н': '-.',
	'О': '---',
	'П': '.--.',
	'Р': '.-.',
	'С': '...',
	'Т': '-',
	'У': '..-',
	'Ф': '..-.',
	'Х': '....',
	'Ц': '-.-.',
	'Ч': '---.',
	'Ш': '----',
	'Щ': '--.-',
	'Ы': '-.--',
	'Ю': '..--',
	'Я': '.-.-',
}
@onready var label: Label = $Label
@onready var text_edit: TextEdit = $TextEdit
var kyes = letters.keys()
var values = letters.values()
var let
func write_letter():
	let = randi_range(0, 28)
	label.text = kyes[let]
	if let >= 20:
		text_edit.placeholder_text = values[let]
	else:
		text_edit.placeholder_text = ''
func _ready() -> void:
	write_letter()

func _on_text_edit_text_changed() -> void:
	if text_edit.text == values[let]:
		write_letter()
		text_edit.text = ''
