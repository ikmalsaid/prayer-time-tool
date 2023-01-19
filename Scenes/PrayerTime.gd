extends CanvasLayer
#
# GodotPrayer - Prayer Time Tool
# 2022 - ikmalsaid - godot_3.4.4
#
var api = "https://waktu-solat-api.herokuapp.com/api/v1/prayer_times.json?zon="
var items = ["Tampin", "Jelebu", "Seremban", "Kuala Pilah"]
var kfix = "Kuala%20Pilah"
var act
var loc
var out
var res
var url
#
# Simple and effective activity indicator
#
func busy():
	if act == "busy":
		$OutputPanel/OutputText.clear()
		$ActivityIndicator.modulate = Color(1,0,0)
		$ActivityMeter.text = "BUSY"
		$RequestButton.disabled = true
		print("\n---------------------\nActivity Status: ", act, "\n")
	else:
		$ActivityIndicator.modulate = Color(0,1,0)
		$ActivityMeter.text = "IDLE"
		$RequestButton.disabled = false
		print("\n---------------------\nActivity Status: ", act, "\n")
#
# Set to idle and add item list from array
#
func _ready():
	act = "idle"
	busy()
	
	print("INFO: PrayerTime started...")
	print("INFO: Adding item list... ", items)
	
	$ZoneSelection.add_item(str(items[0]))
	$ZoneSelection.add_item(str(items[1]))
	$ZoneSelection.add_item(str(items[2]))
	$ZoneSelection.add_item(str(items[3]))
	
	loc = $ZoneSelection.get_item_text(0)
	url = api + loc
	
	print("INFO: Default URL: ", url)
#
# Select any item and it will set the respective variables
#
func _on_zone_item_selected(zone):
	if zone == 0:
		loc = $ZoneSelection.get_item_text(0)
		url = api + loc
		print("INFO: Current URL: ", url)
		
	elif zone == 1:
		loc = $ZoneSelection.get_item_text(1)
		url = api + loc
		print("INFO: Current URL: ", url)
		
	elif zone == 2:
		loc = $ZoneSelection.get_item_text(2)
		url = api + loc
		print("INFO: Current URL: ", url)
		
	elif zone == 3:
		loc = kfix
		url = api + loc
		print("INFO: Current URL: ", url)
#
# Send API call to URL and receive JSON-formatted results
#
func _on_request_pressed():
	act = "busy"
	busy()
	#
	url = api + loc
	print("INFO: Requesting: ", url)
	#
	$OutputPanel/OutputText.clear()
	$ApiRequester.request(url)
#
# JSON-formatted results parsed into respective variables
#
func _on_request_completed(result, response_code, headers, body):
	act = "idle"
	busy()
	
	out = JSON.parse(body.get_string_from_utf8())
	res = out.result
	print(res)
	
	var state 	= out.result['data'][0]['negeri']
	var zone 	= out.result['data'][0]['zon']
	var imsak 	= out.result['data'][0]['waktu_solat'][0]['time']
	var subuh 	= out.result['data'][0]['waktu_solat'][1]['time']
	var syuruk 	= out.result['data'][0]['waktu_solat'][2]['time']
	var zohor 	= out.result['data'][0]['waktu_solat'][3]['time']
	var asar 	= out.result['data'][0]['waktu_solat'][4]['time']
	var maghrib = out.result['data'][0]['waktu_solat'][5]['time']
	var isyak 	= out.result['data'][0]['waktu_solat'][6]['time']
	
	$OutputPanel/OutputText.text += "Waktu Solat bagi Negeri di Malaysia\n"
	$OutputPanel/OutputText.text += "Negeri   : " + state.capitalize() + "\n"
	$OutputPanel/OutputText.text += "Daerah   : " + zone.capitalize() + "\n"
	$OutputPanel/OutputText.text += "Imsak    : " + imsak + "\n"
	$OutputPanel/OutputText.text += "Subuh    : " + subuh + "\n"
	$OutputPanel/OutputText.text += "Syuruk   : " + syuruk + "\n"
	$OutputPanel/OutputText.text += "Zohor    : " + zohor + "\n"
	$OutputPanel/OutputText.text += "Asar     : " + asar + "\n"
	$OutputPanel/OutputText.text += "Maghrib  : " + maghrib + "\n"
	$OutputPanel/OutputText.text += "Isyak    : " + isyak + "\n"
