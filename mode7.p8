pico-8 cartridge // http://www.pico-8.com
version 16
__lua__
function _init()
	fWorldX = 0
	fWorldY = 0
	fWorldA = 0.1
	fNear = 10
	fFar = 50
	fFoVHalf = 3.14159 / 4.0

	nMapSize = 128
end

function _update()
	fWorldX = fWorldX
	fWorldY = fWorldY
	fWorldA = fWorldA + 0.001
end

function _draw()
	cls()
	
	-- Create Frustum corner points
	fFarX1 = fWorldX + cos(fWorldA - fFoVHalf) * fFar
	fFarY1 = fWorldY + sin(fWorldA - fFoVHalf) * fFar

	fNearX1 = fWorldX + cos(fWorldA - fFoVHalf) * fNear
	fNearY1 = fWorldY + sin(fWorldA - fFoVHalf) * fNear

	fFarX2 = fWorldX + cos(fWorldA + fFoVHalf) * fFar
	fFarY2 = fWorldY + sin(fWorldA + fFoVHalf) * fFar

	fNearX2 = fWorldX + cos(fWorldA + fFoVHalf) * fNear
	fNearY2 = fWorldY + sin(fWorldA + fFoVHalf) * fNear
	
	print('fFarX1 '..fFarX1)
	print('fFarY1 '..fFarY1)
	print('fFarX2 '..fFarX2)
	print('fFarY2 '..fFarY2)
	print('fNearX1 '..fNearX1)
	print('fNearY1 '..fNearY1)
	print('fNearX2 '..fNearX2)
	print('fNearY2 '..fNearY2)

	-- Starting with furthest away line and work towards the camera point
	for y = 0,64 do
		-- Take a sample point for depth linearly related to rows down screen
		fSampleDepth = y / 64.0	

		-- Use sample point in non-linear (1/x) way to enable perspective
		-- and grab start and end points for lines across the screen
		fStartX = (fFarX1 - fNearX1) / (fSampleDepth) + fNearX1
		fStartY = (fFarY1 - fNearY1) / (fSampleDepth) + fNearY1
		fEndX = (fFarX2 - fNearX2) / (fSampleDepth) + fNearX2
		fEndY = (fFarY2 - fNearY2) / (fSampleDepth) + fNearY2

		-- Linearly interpolate lines across the screen
		for x = 0,128 do
			fSampleWidth = x / 128.0
			fSampleX = (fEndX - fStartX) * fSampleWidth + fStartX
			fSampleY = (fEndY - fStartY) * fSampleWidth + fStartY

			pset(x, y + 64, bitmap_color(fSampleX, fSampleY))
		end
	end
	
end

function bitmap_color(x, y)
	if (x % 10 < 6 and y % 10 < 6) then
		return 2
	else
		return 3
	end
end
