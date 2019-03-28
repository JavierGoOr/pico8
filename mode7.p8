pico-8 cartridge // http://www.pico-8.com
version 16
__lua__
function _init()
	my_x = 0
	my_y = 0
	my_angle = 0.1
	near_distance = 0
	far_distance = 10
	field_of_view_half = 3.14159 / 8.0

	map_size = 128
end

function _update()
	my_x = my_x
	my_y = (my_y + 1) % map_size
	my_angle = (my_angle + 0.001) % (2 * 3.14159)
end

function _draw()
	cls()
	
	far_x1 = my_x + cos(my_angle - field_of_view_half) * far_distance
	far_y1 = my_y + sin(my_angle - field_of_view_half) * far_distance

	near_x1 = my_x + cos(my_angle - field_of_view_half) * near_distance
	near_y1 = my_y + sin(my_angle - field_of_view_half) * near_distance

	far_x2 = my_x + cos(my_angle + field_of_view_half) * far_distance
	far_y2 = my_y + sin(my_angle + field_of_view_half) * far_distance

	near_x2 = my_x + cos(my_angle + field_of_view_half) * near_distance
	near_y2 = my_y + sin(my_angle + field_of_view_half) * near_distance
	
	for y = 0,64 do
		proj_depth = y / 64.0	
		
		proj_start_x = (far_x1 - near_x1) / (proj_depth) + near_x1
		proj_start_y = (far_y1 - near_y1) / (proj_depth) + near_y1
		proj_end_x = (far_x2 - near_x2) / (proj_depth) + near_x2
		proj_end_y = (far_y2 - near_y2) / (proj_depth) + near_y2

		for x = 0,128 do
			proj_width = x / 128.0
			proj_x = (proj_end_x - proj_start_x) * proj_width + proj_start_x
			proj_y = (proj_end_y - proj_start_y) * proj_width + proj_start_y

			pset(x, y + 64, bitmap_color(proj_x, proj_y))
		end
	end
	
end

function bitmap_color(x, y)
	if (x % 10 < 6 and y % 10 < 6) then
		return 12
	else
		return 2
	end
end
