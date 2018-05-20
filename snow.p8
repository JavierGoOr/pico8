pico-8 cartridge // http://www.pico-8.com
version 16
__lua__
function _init()
	flakes = {}
	for i=1,200 do
		add(flakes, create_flake())
	end
end

function _update()
	for f in all(flakes) do
		move_flake(f)
	end
end

function _draw()
	cls()
	for f in all(flakes) do
		draw_flake(f)
	end
end

function create_flake()
	local flake = {}
	flake.x = give_base_x()
	flake.base_y = give_base_y()
	flake.y = 0
	flake.z = rnd(20)
	flake.freq = 150-6*flake.z
	flake.amp = 20-9*flake.z/10
	flake.speed = 1+flake.z/4
	return flake
end

function draw_flake(f)
	local side = 1
	if(f.z > 18) then
		side = 2
	end
	draw_point(f.x, f.y, side, 7)
end

function draw_point(x,y,side,color)
	for i=1,side do
		for j=1,side do
			pset(x+(i-1), y+(j-1), color)
		end
	end
end

function give_base_x()
	return rnd(100)-120
end

function give_base_y()
	return rnd(128)
end

function move_flake(f)
	f.x += f.speed
	if(f.x > 128) then
		f.x = give_base_x()
		f.base_y = give_base_y()
	end
	f.y = harmonic(f.x, f.freq, f.amp)+f.base_y
end

function harmonic(x, freq, amp)
	return sin(x/freq)*amp
end
