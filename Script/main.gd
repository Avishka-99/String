extends Node2D
@onready var topLine = $top
@onready var bottomLine = $bottom
@export var pointCount = 800
@export var speed=100
var directions = ["up","down","linear","easydown","easyup"]
var topDir=null
var bottomDir = null
func _ready():
	topDir = directions[randi()%5]
	bottomDir = directions[randi()%5]
func addCollisionTopLine(coordinate1,coordinate2):
	var points = [Vector2(1080+coordinate2.x,-50),Vector2(1080+coordinate1.x,-50),Vector2(1080+coordinate1.x,coordinate1.y),Vector2(1080+coordinate2.x,coordinate2.y)]
	var collisionPolygon = CollisionPolygon2D.new()
	collisionPolygon.polygon = points
	var area = Area2D.new()
	area.add_child(collisionPolygon)
	add_child(area)
func addCollisionBottomLine(coordinate1,coordinate2):
	var points = [Vector2(1080+coordinate2.x,1725+coordinate2.y),Vector2(1080+coordinate1.x,1725+coordinate2.y),Vector2(1080+coordinate2.x,1911),Vector2(1080+coordinate2.x,1911)]
	var collisionPolygon = CollisionPolygon2D.new()
	collisionPolygon.polygon = points
	var area = Area2D.new()
	area.add_child(collisionPolygon)
	add_child(area)
func addPointTopLine():
	if(topLine.get_point_count()>1):
		addCollisionTopLine(topLine.points[topLine.get_point_count()-1],topLine.points[topLine.get_point_count()-2])
	#print(topLine.get_point_position(topLine.get_point_count()-1).y)
	if(topDir=="up"):
		topLine.add_point(Vector2(position.x,topLine.get_point_position(topLine.get_point_count()-1).y-10))
	elif(topDir=="down"):
		topLine.add_point(Vector2(position.x,topLine.get_point_position(topLine.get_point_count()-1).y+10))
	elif(topDir=="linear"):
		topLine.add_point(Vector2(position.x,topLine.get_point_position(topLine.get_point_count()-1).y))
	elif(topDir=="easydown"):
		topLine.add_point(Vector2(position.x,topLine.get_point_position(topLine.get_point_count()-1).y+1))
	elif(topDir=="easyup"):
		topLine.add_point(Vector2(position.x,topLine.get_point_position(topLine.get_point_count()-1).y-1))
func addPointBottomLine():
	if(bottomLine.get_point_count()>1):
		addCollisionBottomLine(bottomLine.points[bottomLine.get_point_count()-1],bottomLine.points[bottomLine.get_point_count()-2])
	#print(topLine.get_point_position(topLine.get_point_count()-1).y)	
	#print(bottomLine.get_point_position(bottomLine.get_point_count()-1).y)
	if(bottomDir=="up"):
		bottomLine.add_point(Vector2(position.x,bottomLine.get_point_position(bottomLine.get_point_count()-1).y-10))
	elif(bottomDir=="down"):
		bottomLine.add_point(Vector2(position.x,bottomLine.get_point_position(bottomLine.get_point_count()-1).y+10))
	elif(bottomDir=="linear"):
		bottomLine.add_point(Vector2(position.x,bottomLine.get_point_position(bottomLine.get_point_count()-1).y))
	elif(bottomDir=="easydown"):
		bottomLine.add_point(Vector2(position.x,bottomLine.get_point_position(bottomLine.get_point_count()-1).y+1))
	elif(bottomDir=="easyup"):
		bottomLine.add_point(Vector2(position.x,bottomLine.get_point_position(bottomLine.get_point_count()-1).y-1))
func _process(delta):
	position.x+=5
	if(topLine.get_point_count()>1 and topLine.get_point_position(topLine.get_point_count()-1).y>835):
		topDir="easyup"
	elif(topLine.get_point_count()>1 and topLine.get_point_position(topLine.get_point_count()-1).y<10):
		topDir="down"
	if(bottomLine.get_point_count()>1 and bottomLine.get_point_position(bottomLine.get_point_count()-1).y>186):
		bottomDir="up"
	elif(bottomLine.get_point_count()>1 and bottomLine.get_point_position(bottomLine.get_point_count()-1).y<-830):
		bottomDir="easydown"
	#print(bottomLine.get_point_position(bottomLine.get_point_count()-1))
	addPointTopLine()
	#bottomLine.add_point(Vector2(position.x,global_position.y))
	#print(position.y)
	addPointBottomLine()
	while(topLine.get_point_count()>pointCount):
		topLine.remove_point(0)
	while(bottomLine.get_point_count()>pointCount):
		bottomLine.remove_point(0)
	$Camera2D.position=Vector2($Camera2D.position.x+5,$Camera2D.position.y)
func _on_timer_timeout():
	topDir = directions[randi()%5]
	bottomDir=directions[randi()%5]
	#print(dir)


func _on_area_2d_area_entered(area):
	area.queue_free()
