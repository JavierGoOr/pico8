pico-8 cartridge // http://www.pico-8.com
version 16
__lua__
drops={}

function _init()
	for i=1,200 do
		add(drops, create_drop())		
	end
end

function _update()
	for d in all(drops) do
		fall_drop(d)
	end
end

function _draw()
	cls()
	for d in all(drops) do
		draw_drop(d)
	end
end

function create_drop()
	local drop = {}
	drop.x = rnd(128)
	drop.y = initial_y()
	drop.z = rnd(20)
	drop.len = 4+drop.z/4
	drop.yspeed=yspeed_from(drop.z)
	return drop
end

function fall_drop(d)
	d.y += d.yspeed
	d.yspeed += 0.098
	if(d.y > 128) then
		d.y=initial_y()
		d.yspeed=yspeed_from(d.z)
	end
end

function initial_y()
	return rnd(200)-205
end

function yspeed_from(z)
	return z*3/10
end

function draw_drop(d)
	line(d.x, d.y, d.x, d.y+d.len, 7)
	if(d.z>10)then
		line(d.x+1, d.y, d.x+1, d.y+d.len, 7)
	end
end
