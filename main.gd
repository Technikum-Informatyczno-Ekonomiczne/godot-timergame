extends Control

@onready var time_label: Label = $VBoxContainer/TimeLabel
@onready var button: Button = $VBoxContainer/StartStopButton
@onready var message_label: Label = $VBoxContainer/MessageLabel

var elapsed_time: float = 0.0 
var is_running: bool = false 


func _ready():
	update_display()
	button.pressed.connect(_on_button_pressed)
	message_label.visible = false
	
func _process(delta):
	print(delta)
	if is_running:
		elapsed_time += delta 
		time_label.text = format_time(elapsed_time)


func _on_button_pressed():
	if is_running:
		stop_timer()
	else:
		reset_timer()
		start_timer()
		
func start_timer():
	is_running = true 
	button.text = "STOP"
	message_label.visible = false 
	
func stop_timer():
	is_running =false
	button.text = "START"
	check_result()
	
	
func check_result():
	var target: float = 300.0
	if abs(elapsed_time - target) < 0.5:
		message_label.text = "BRAWO! Perfekcyjnie !!!"
		message_label.modulate = Color.GREEN
	else:
		message_label.text = "Spróbuj jeszcze raz!\nTwój czas: " + format_time(elapsed_time)
		message_label.modulate = Color.RED
	
	message_label.visible = true 
	
	
func reset_timer():
	elapsed_time = 0.0 
	update_display()
	
func update_display():
	time_label.text = format_time(elapsed_time)
	
func format_time(seconds: float)-> String:
	var whole_seconds: int = int(seconds)
	var hundredths: int = int(((seconds - whole_seconds)*100.0)+0.0001)
	print(hundredths)
	return "%02d:%02d" % [whole_seconds, hundredths]
