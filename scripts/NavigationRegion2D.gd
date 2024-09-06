extends Node2D

var polygon_2d
var nav_region_2d

func _ready():
	polygon_2d = get_node("NavigationRegion2D/sky2")  # Ensure the path is correct
	nav_region_2d = get_node("NavigationRegion2D")  # Ensure the path is correct

	print("Attempting to get Polygon2D at: ", polygon_2d)

	if polygon_2d == null:
		push_error("Polygon2D node not found!")
		return

	if nav_region_2d == null:
		push_error("NavigationRegion2D node not found!")
		return
	
	# Get the points from the Polygon2D
	var points = polygon_2d.polygon
	if points.size() == 0:
		push_error("Polygon2D has no points!")
		return
	
	# Create a new NavigationPolygon
	var nav_polygon = NavigationPolygon.new()
	
	# Convert points to PackedVector2Array and add to the navigation polygon
	var outline = PackedVector2Array(points)
	nav_polygon.add_outline(outline)
	nav_polygon.make_polygons_from_outlines()
	
	# Get the NavigationPolygonInstance2D inside the NavigationRegion2D
	var nav_polygon_instance = nav_region_2d.get_node("NavigationPolygonInstance2D")
	if nav_polygon_instance != null:
		# Assign the new NavigationPolygon to it
		nav_polygon_instance.navigation_polygon = nav_polygon
		print("NavigationPolygon assigned successfully!")
	else:
		push_error("NavigationPolygonInstance2D node not found in NavigationRegion2D!")
