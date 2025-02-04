extends Node3D
const HOUSE_SPACING: int = 45
const HOUSE_X_OFFSET: int = -35
const HOUSE_Z_OFFSET_MULTIPLIER: int = -1

@onready var CustomerHouseScene: PackedScene = preload("res://scenes/customer_house.tscn")
@onready var NonCustomerHouseScene: PackedScene = preload("res://scenes/noncustomer_house.tscn")

var houses_data = [
	{"HouseID": 1, "IsCurrentCustomer": false,  "HasBeenDeliveredYesterday": true,  "HasNotHadWindowSmashed": true},
	{"HouseID": 2, "IsCurrentCustomer": true, "HasBeenDeliveredYesterday": false, "HasNotHadWindowSmashed": true},
	{"HouseID": 3, "IsCurrentCustomer": true,  "HasBeenDeliveredYesterday": true,  "HasNotHadWindowSmashed": true},
	{"HouseID": 4, "IsCurrentCustomer": true, "HasBeenDeliveredYesterday": false, "HasNotHadWindowSmashed": true},
	{"HouseID": 5, "IsCurrentCustomer": true,  "HasBeenDeliveredYesterday": true,  "HasNotHadWindowSmashed": true},
	{"HouseID": 6, "IsCurrentCustomer": true,  "HasBeenDeliveredYesterday": true,  "HasNotHadWindowSmashed": true},
	{"HouseID": 7, "IsCurrentCustomer": true,  "HasBeenDeliveredYesterday": true,  "HasNotHadWindowSmashed": true},
	{"HouseID": 8, "IsCurrentCustomer": true, "HasBeenDeliveredYesterday": false, "HasNotHadWindowSmashed": true},
	{"HouseID": 9, "IsCurrentCustomer": true, "HasBeenDeliveredYesterday": false, "HasNotHadWindowSmashed": true}
]

func _ready():
	spawn_houses()
	
func spawn_houses():
	for i in houses_data.size():
		var house_info = houses_data[i]
		var house_instance = Node3D
		if house_info["IsCurrentCustomer"] && house_info["HasBeenDeliveredYesterday"] && house_info["HasNotHadWindowSmashed"]:
			house_instance = CustomerHouseScene.instantiate()
		else:
			house_instance = NonCustomerHouseScene.instantiate()
			
		house_instance.position = Vector3(HOUSE_X_OFFSET, 0, HOUSE_Z_OFFSET_MULTIPLIER * (i * HOUSE_SPACING))
		add_child(house_instance)


# Called every frame. 'delta' isa the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
