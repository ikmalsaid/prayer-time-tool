extends CanvasLayer
# godotprayer project
# request from solat api, get and show 'em
# 2022 - ikmalsaid
onready var output = get_node("Panel/Output")
onready var select = $OptionButton
var url = "https://waktu-solat-api.herokuapp.com/api/v1/prayer_times.json?zon="

func add_items():
	select.add_item("tampin")
	select.add_item("seremban")
	select.add_item("jelebu")
	select.add_item("kuala pilah")

func _on_OptionButton_item_selected(index):
	if index == 0:
		print(str(select.get_item_text(index)))
		var option = str(select.get_item_text(index))
		print("option: ",option)
				
	elif index == 1:
		print(str(select.get_item_text(index)))
		var option = str(select.get_item_text(index))
		print("option: ",option)
		
	elif index == 2:
		print(str(select.get_item_text(index)))
		var option = str(select.get_item_text(index))
		print("option: ",option)
		
	elif index == 3:
		print(str(select.get_item_text(index)))
		var option = str(select.get_item_text(index))
		print("option: ",option)

func _ready():
	add_items()
	$White.set_modulate(Color(0,1,0))
	$Label.set_text("READY")

func _on_Button_pressed():
	var opt = ''
	var option = str(opt)
	print("Requesting API...\n", url, option)
	output.clear()
	$Requester.request(url + option)
	$White.set_modulate(Color(1,0,0))
	$Label.set_text("BUSY")

func _on_Requester_request_completed(result, response_code, headers, body):
	print("Processing the response...\n")
	var json = JSON.parse(body.get_string_from_utf8())
	var json2 = json.result
	print(json2)
	
#	var state 	= json.result['data'][0]['negeri']
#	var zone 	= json.result['data'][0]['zon']
#	var imsak 	= json.result['data'][0]['waktu_solat'][0]['time']
#	var subuh 	= json.result['data'][0]['waktu_solat'][1]['time']
#	var syuruk 	= json.result['data'][0]['waktu_solat'][2]['time']
#	var zohor 	= json.result['data'][0]['waktu_solat'][3]['time']
#	var asar 	= json.result['data'][0]['waktu_solat'][4]['time']
#	var maghrib = json.result['data'][0]['waktu_solat'][5]['time']
#	var isyak 	= json.result['data'][0]['waktu_solat'][6]['time']
#
#	$White.set_modulate(Color(0,1,0))
#	$Label.set_text("READY")
#	output.clear()
#	output.text += "Waktu Solat bagi Negeri di Malaysia\n"
#	output.text += "Negeri   : " + state.capitalize() + "\n"
#	output.text += "Daerah   : " + zone.capitalize() + "\n"
#	output.text += "Imsak    : " + imsak + "\n"
#	output.text += "Subuh    : " + subuh + "\n"
#	output.text += "Syuruk   : " + syuruk + "\n"
#	output.text += "Zohor    : " + zohor + "\n"
#	output.text += "Asar     : " + asar + "\n"
#	output.text += "Maghrib  : " + maghrib + "\n"
#	output.text += "Isyak    : " + isyak + "\n"
#
