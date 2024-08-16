extends Node2D

var frame = 0

var subbass: float = 0
var bass1: float = 0
var bass2: float = 0
var mid1: float = 0
var mid2: float = 0
var mid3 : float = 0
var mid4: float = 0
var high1: float = 0
var high2: float = 0

var easing = 1

func _ready():
	pass



func _process(delta):
	var spectrum = AudioServer.get_bus_effect_instance(0,0)
	frame += 1
	if frame >= 2:
		
		$subbass.value = lerp(subbass,spectrum.get_magnitude_for_frequency_range(0,50).x * 1500,easing*delta)
		$bass1.value = lerp(bass1,spectrum.get_magnitude_for_frequency_range(50,100).x * 1500,easing*delta)
		$bass2.value = lerp(bass2,spectrum.get_magnitude_for_frequency_range(100,300).x * 1500,easing*delta)
		$mid1.value = lerp(mid1,spectrum.get_magnitude_for_frequency_range(300,500).x * 1500,easing*delta)
		$mid2.value = lerp(mid2,spectrum.get_magnitude_for_frequency_range(500,750).x * 1500,easing*delta)
		$mid3.value = lerp(mid3,spectrum.get_magnitude_for_frequency_range(750,1250).x * 1500,easing*delta)
		$mid4.value = lerp(mid4,spectrum.get_magnitude_for_frequency_range(1250,2000).x * 1500,easing*delta)
		$high1.value = lerp(high1,spectrum.get_magnitude_for_frequency_range(2000,4000).x * 1500,easing*delta)
		$high2.value = lerp(high2,spectrum.get_magnitude_for_frequency_range(4000,8000).x * 1500,easing*delta)
		frame = 0
	
	
	subbass = spectrum.get_magnitude_for_frequency_range(0,50).x * 750
	bass1 = spectrum.get_magnitude_for_frequency_range(50,100).x * 750
	bass2 = spectrum.get_magnitude_for_frequency_range(100,300).x * 1500
	mid1 = spectrum.get_magnitude_for_frequency_range(300,500).x * 1500
	mid2 = spectrum.get_magnitude_for_frequency_range(500,750).x * 1500
	mid3 = spectrum.get_magnitude_for_frequency_range(750,1250).x * 1500
	mid4 = spectrum.get_magnitude_for_frequency_range(1250,2000).x * 1500
	high1 = spectrum.get_magnitude_for_frequency_range(2000,4000).x * 1500
	high2 = spectrum.get_magnitude_for_frequency_range(4000,8000).x * 1500

func _physics_process(delta):
	frame += 1

func load_mp3(path):
	var file = FileAccess.open(path, FileAccess.READ)
	var sound = AudioStreamMP3.new()
	sound.data = file.get_buffer(file.get_length())
	$player.stream = sound
	$player.play()
	
func load_ogg(path):
	$player.stream = AudioStreamOggVorbis.load_from_file(path)
	$player.play()

func _on_button_button_up():
	$filePick.popup()


func _on_file_pick_file_selected(path):
	if path.ends_with(".mp3"):
		load_mp3(path)
	elif path.ends_with(".ogg"):
		load_ogg(path)
		
