extends State

@export var time_service: Node2D 

@onready var day_timer: Timer = $DayTimer

var current_time = 0

var total_customer : float = 25
var customer_schedule = []

var sin_offset = 0
var gaussian_middle = 8
var gaussian_width = 4

func Enter():	
	sin_offset = Global.rng.randf_range(0, PI)
	create_customer_schedule(12, total_customer)
	day_timer.start()

func Exit():
	day_timer.stop()
	current_time = 0

func create_customer_schedule(day_range, total_customers):
	var hours_in_day = day_range
	var customers_remaining = total_customers
	var customer_schedule = []

	var integral_diffision = gaussian_integral(0, hours_in_day, hours_in_day)
	for hour in range(0, hours_in_day):
		if customers_remaining > 0:
			var percentage = gaussian_disstribution(hour, gaussian_middle, gaussian_width) / integral_diffision
			var round_percentage = round(percentage * 100) / 100
			var mixed_distribution = round_percentage * sin_distribution(hour, sin_offset)
			var hourly_customers = round(mixed_distribution * total_customers)
			
			hourly_customers = min(hourly_customers, customers_remaining)
			customer_schedule.append(hourly_customers)
			customers_remaining -= hourly_customers
		else:
			customer_schedule.append(0)
	var customer_count = 0
	for count in customer_schedule:
		customer_count += count
	#print("Customer schedule: " + str(customer_schedule) + " Total: " + str(customer_count))
	return customer_schedule

func sin_distribution(x, offset = 0):
	var sin_at_x = (sin(x * 10 + offset) + 2 * 2) / 2 * 0.5
	return sin_at_x
	
func gaussian_disstribution( x, high_point_pos, width):
	var a = -pow((x - high_point_pos), 2)
	var b = 2 * pow(width, 2)
	return exp(a / b)
	
func gaussian_integral(start, end, graniolarity) -> float:
	var step_size = float((end - start)) / graniolarity
	var sum = (gaussian_disstribution(start, gaussian_middle, gaussian_width) + gaussian_disstribution(end, gaussian_middle, gaussian_width)) / 2
	
	for i in range(1, graniolarity):
		var x_i = start + i * step_size
		sum += gaussian_disstribution(x_i, gaussian_middle, gaussian_width)
	return sum * step_size
	
func _on_day_timer_timeout() -> void:
	current_time += 1
	var minutes = current_time % 60
	var hours = int((current_time - minutes) / 60) + 8
	time_service.change_time(current_time)
	if hours >= time_service.close_time:
		time_service.close_shop()