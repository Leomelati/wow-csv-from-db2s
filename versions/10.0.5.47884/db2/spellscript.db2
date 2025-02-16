WDC3         �  ��SE-$�~ �  N2 ����             x                           �      X                                                                               @                       `                   a                       b  ~  �	  \   �	  �	  �	  \   �  �  q	  \   $  M  a	  \   T  �  Q	  \   V"  �"  �-  \   �-  �-  &6  \   +6  h6  !	  \   .?  U?  	  \   �E  EF  �5  \   �P  �P  XQ  \   ^Q  vQ  �  \   )R  `R  �  \   Z  ZZ  �  \   �`  a  �5  \   \f  of  �  \   
j  aj  �5  \   �o  %p  v5  \   _u  �u  f5  \   �z  {    \     D  �  \   �  �  �  \     Doug Test - Area Trigger Script function doug_test_area_trigger_script(elapsedMs, x, y, z, roll, pitch, yaw)
	------------------------------------
	-- Area Trigger Movement Script:  --
	------------------------------------
	-- Inputs: 
	--    elapsedMs: the amount of milliseconds since the 'm_creationTime' of this AreaTrigger
	--
	-- Output:
	--    x - x offset from the m_center of AreaTrigger
	--    y - y offset from the m_center of AreaTrigger
	--    z - z offset from the m_center of AreaTrigger
	--    roll - rotation around z axis
	--    pitch - rotation around y axis
	--    yaw - rotation around x axis - also known as 'facing'
	--
	--    return values in this specific order.  If you don't want to change a specific value, return 0
	--    example: if you want to adjust only 'pitch' you need to 'return 0,0,0,0,pitch'.
	--
	--

	-- Constants
	local swingTime = 4000; -- in milliseconds
	local startAngle = math.pi;
	local endAngle = 2*math.pi;
	local zOffset = 10;
	local posChangeTime = 10000;
	
	-- Example Code: lerp from 'startAngle' to 'endAngle' then back to 'startAngle' over 'swingTime'
	--               make this a 'smoothstep' (cubic) rather than linear motion
	local time = elapsedMs % (swingTime * 2);
	local swingPercent = 1.0
	if (time < swingTime)  then
		-- on the approach of the arc
		swingPercent = time / swingTime;
		
	else
		-- on the return of the arc
		time = swingTime - (time - swingTime);
		swingPercent = time / swingTime;
	end
	-- smoothstep
	swingPercent = swingPercent * swingPercent * (3 - 2* swingPercent)
	local angle = (endAngle - startAngle) * swingPercent;

	--
	-- Example Code: go down 'zOffset' units, then back up, repeating every 'posChangeTime'
	--
	--local zTime = elapsedMs % (posChangeTime * 2);
	--local zPercent = 1.0
	--if(zTime < posChangeTime) then
	--	zPercent = zTime / posChangeTime;
	--else
	--	zTime = posChangeTime - (zTime - posChangeTime);
	--	zPercent = zTime / posChangeTime;
	--end
	--local zChange = zOffset * zPercent + 10;
	return 0,0, zOffset, 0, angle, 0;
end


 Jared Gillis 9.0 Maw - Area Trigger Test - Stabby Sword - PRK function maw_area_trigger_test_stabby_sword(elapsedMs)
	------------------------------------
	-- Area Trigger Movement Script:  --
	------------------------------------
	-- Inputs: 
	--    elapsedMs: the amount of milliseconds since the 'm_creationTime' of this AreaTrigger
	--
	-- Output:
	--    x - x offset from the m_center of AreaTrigger
	--    y - y offset from the m_center of AreaTrigger
	--    z - z offset from the m_center of AreaTrigger
	--    roll - rotation around z axis
	--    pitch - rotation around y axis
	--    yaw - rotation around x axis - also known as 'facing'
	--
	--    return values in this specific order.  If you don't want to change a specific value, return 0
	--    example: if you want to adjust only 'pitch' you need to 'return 0,0,0,0,pitch'.
	--
	--

	-- Constants
	local idleTime = 4000 --in milliseconds
	local stabTime = 250
	local postStabDelayTime = 1000
	local retractTime = 7000
	
	local totalTime = idleTime + stabTime + postStabDelayTime + retractTime
	
	local stabDistance = 10
	
	-- Calculations
	local offsetX, stepTime
	local time = elapsedMs % totalTime
	if time < idleTime then
		offsetX = 0
	elseif time < idleTime + stabTime then
		stepTime = time - idleTime
		offsetX = stabDistance * (stepTime/stabTime)
	elseif time < idleTime + stabTime + postStabDelayTime then
		offsetX = stabDistance
	else
		stepTime = time - idleTime - stabTime - postStabDelayTime
		offsetX = stabDistance - stabDistance * (stepTime/retractTime)
	end

	return offsetX, 0, 2.5
end


 9.0 Maw - Area Trigger Test - Falling Axe - PRK function maw_area_trigger_test_falling_axe(elapsedMs)
	------------------------------------
	-- Area Trigger Movement Script:  --
	------------------------------------
	-- Inputs: 
	--    elapsedMs: the amount of milliseconds since the 'm_creationTime' of this AreaTrigger
	--
	-- Output:
	--    x - x offset from the m_center of AreaTrigger
	--    y - y offset from the m_center of AreaTrigger
	--    z - z offset from the m_center of AreaTrigger
	--    roll - rotation around z axis
	--    pitch - rotation around y axis
	--    yaw - rotation around x axis - also known as 'facing'
	--
	--    return values in this specific order.  If you don't want to change a specific value, return 0
	--    example: if you want to adjust only 'pitch' you need to 'return 0,0,0,0,pitch'.
	--
	--

	-- Constants
	local idleTime = 4000 --in milliseconds
	local fallTime = 250
	local postFallDelayTime = 1000
	local retractTime = 4000
	
	local totalTime = idleTime + fallTime + postFallDelayTime + retractTime
	
	local pitchAngle = 1.25
	
	-- Calculations
	local newPitch, stepTime
	local time = elapsedMs % totalTime
	if time < idleTime then
		newPitch = 0
	elseif time < idleTime + fallTime then
		stepTime = time - idleTime
		newPitch = pitchAngle * (stepTime/fallTime)
	elseif time < idleTime + fallTime + postFallDelayTime then
		newPitch = pitchAngle
	else
		stepTime = time - idleTime - fallTime - postFallDelayTime
		newPitch = pitchAngle - pitchAngle * (stepTime/retractTime)
	end
	newPitch = newPitch-math.pi/2

	return 0,0,0,0,newPitch
end


 9.0 Maw - Area Trigger Test - Fast Axe - PRK function maw_area_trigger_test_fast_axe(elapsedMs, x, y, z, roll, pitch, yaw)
	------------------------------------
	-- Area Trigger Movement Script:  --
	------------------------------------
	-- Inputs: 
	--    elapsedMs: the amount of milliseconds since the 'm_creationTime' of this AreaTrigger
	--
	-- Output:
	--    x - x offset from the m_center of AreaTrigger
	--    y - y offset from the m_center of AreaTrigger
	--    z - z offset from the m_center of AreaTrigger
	--    roll - rotation around z axis
	--    pitch - rotation around y axis
	--    yaw - rotation around x axis - also known as 'facing'
	--
	--    return values in this specific order.  If you don't want to change a specific value, return 0
	--    example: if you want to adjust only 'pitch' you need to 'return 0,0,0,0,pitch'.
	--
	--

	-- Constants
	local swingTime = 3000; -- in milliseconds
	local startAngle = math.pi;
	local endAngle = 2*math.pi;
	local zOffset = 10;
	local posChangeTime = 10000;
	
	-- Example Code: lerp from 'startAngle' to 'endAngle' then back to 'startAngle' over 'swingTime'
	--               make this a 'smoothstep' (cubic) rather than linear motion
	local time = elapsedMs % (swingTime * 2);
	local swingPercent = 1.0
	if (time < swingTime)  then
		-- on the approach of the arc
		swingPercent = time / swingTime;
		
	else
		-- on the return of the arc
		time = swingTime - (time - swingTime);
		swingPercent = time / swingTime;
	end
	-- smoothstep
	swingPercent = swingPercent * swingPercent * (3 - 2* swingPercent)
	local angle = (endAngle - startAngle) * swingPercent;

	--
	-- Example Code: go down 'zOffset' units, then back up, repeating every 'posChangeTime'
	--
	--local zTime = elapsedMs % (posChangeTime * 2);
	--local zPercent = 1.0
	--if(zTime < posChangeTime) then
	--	zPercent = zTime / posChangeTime;
	--else
	--	zTime = posChangeTime - (zTime - posChangeTime);
	--	zPercent = zTime / posChangeTime;
	--end
	--local zChange = zOffset * zPercent + 10;
	return 0,0, 10, 0, angle, 0;
end


 9.0 Maw - Area Trigger Test - Spinning Axe - PRK function maw_area_trigger_test_spinning_axe(elapsedMs)
	------------------------------------
	-- Area Trigger Movement Script:  --
	------------------------------------
	-- Inputs: 
	--    elapsedMs: the amount of milliseconds since the 'm_creationTime' of this AreaTrigger
	--
	-- Output:
	--    x - x offset from the m_center of AreaTrigger
	--    y - y offset from the m_center of AreaTrigger
	--    z - z offset from the m_center of AreaTrigger
	--    roll - rotation around z axis
	--    pitch - rotation around y axis
	--    yaw - rotation around x axis - also known as 'facing'
	--
	--    return values in this specific order.  If you don't want to change a specific value, return 0
	--    example: if you want to adjust only 'pitch' you need to 'return 0,0,0,0,pitch'.
	--
	--

	-- Constants
	local rotationTime = 3000; -- in milliseconds
	local zOffset = 10;
	
	local angle = (elapsedMs/rotationTime)*2*math.pi

	return 0,0, zOffset, 0, angle, 0;
end


 9.0 Maw - Area Trigger Test - Random Axe - PRK function maw_area_trigger_test_random_axe(elapsedMs, x, y, z, roll, pitch, yaw)
	------------------------------------
	-- Area Trigger Movement Script:  --
	------------------------------------
	-- Inputs: 
	--    elapsedMs: the amount of milliseconds since the 'm_creationTime' of this AreaTrigger
	--
	-- Output:
	--    x - x offset from the m_center of AreaTrigger
	--    y - y offset from the m_center of AreaTrigger
	--    z - z offset from the m_center of AreaTrigger
	--    roll - rotation around z axis
	--    pitch - rotation around y axis
	--    yaw - rotation around x axis - also known as 'facing'
	--
	--    return values in this specific order.  If you don't want to change a specific value, return 0
	--    example: if you want to adjust only 'pitch' you need to 'return 0,0,0,0,pitch'.
	--
	--

	-- Constants
	local period = 3000 --in ms
	local transMax = 8 -- maximum distance the object can translate in either direction in x, y, or z
	local rotMax = 2*math.pi -- maximum rotation value for pitch, roll, or yaw
	local zOffset = 10
	
	-- Pseudorandom functon
	-- This function simulates a random number "close enough" for our purposes
	-- It also does the work of multiplying in the max in
	-- Seed: use a timestamp that is known or easily derivable
	-- Index: use a fixed index for each offset/rotation
	-- Max: transMax or rotMax
	local function SetRandomNumber(seed, index, max)
		local product = 571.1862*seed+718.4814*index+14.4813*seed*index
		local decimal = product - math.floor(product)
		return max * (2*decimal-1)
	end
	
	-- Determine the last locked position
	-- First, get a timestamp of the last 3 second tick
	-- Then, use that as a seed to set x y z pitch roll yaw
	local seed = math.floor((elapsedMs - period)/period)
	local x1, y1, z1 = SetRandomNumber(seed, 1, transMax), SetRandomNumber(seed, 2, transMax), SetRandomNumber(seed, 3, transMax)
	local roll1, pitch1, yaw1 = SetRandomNumber(seed, 4, rotMax), SetRandomNumber(seed, 5, rotMax), SetRandomNumber(seed, 6, rotMax)

	-- Now, do the same, using the next 3 second tick as the seed
	seed = math.floor(elapsedMs/period)
	local x2, y2, z2 = SetRandomNumber(seed, 1, transMax), SetRandomNumber(seed, 2, transMax), SetRandomNumber(seed, 3, transMax)
	local roll2, pitch2, yaw2 = SetRandomNumber(seed, 4, rotMax), SetRandomNumber(seed, 5, rotMax), SetRandomNumber(seed, 6, rotMax)
	
	-- Now, lerp between those two numbers
	local progress = (elapsedMs%period)/period
	local newX = x1 + (x2-x1)*progress
	local newY = y1 + (y2-y1)*progress
	local newZ = z1 + (z2-z1)*progress
	local newRoll = roll1 + (roll2-roll1)*progress
	local newPitch = pitch1 + (pitch2-pitch1)*progress
	local newYaw = yaw1 + (yaw2-yaw1)*progress
	

	return newX, newY, newZ+zOffset, newRoll, newPitch, newYaw
end


 Emma Ripley Rose 9.0 Maw - Jailer's Tower - Swinging Axe Trap Large - KLH function maw_jailerstower_trap_swingingaxe_large_klh(elapsedMs, x, y, z, roll, pitch, yaw)
	------------------------------------
	-- Area Trigger Movement Script:  --
	------------------------------------
	-- Inputs: 
	--    elapsedMs: the amount of milliseconds since the 'm_creationTime' of this AreaTrigger
	--
	-- Output:
	--    x - x offset from the m_center of AreaTrigger
	--    y - y offset from the m_center of AreaTrigger
	--    z - z offset from the m_center of AreaTrigger
	--    roll - rotation around z axis
	--    pitch - rotation around y axis
	--    yaw - rotation around x axis - also known as 'facing'
	--
	--    return values in this specific order.  If you don't want to change a specific value, return 0
	--    example: if you want to adjust only 'pitch' you need to 'return 0,0,0,0,pitch'.
	--
	--

	--prints(elapsedMs, x, y, z, roll, pitch, yaw)

	-- Constants
	local swingTime = 4000; -- in milliseconds
	local startAngle = math.pi;
	local endAngle = 2*math.pi;
	local zOffset = 30;
	local posChangeTime = 10000;
	
	-- Example Code: lerp from 'startAngle' to 'endAngle' then back to 'startAngle' over 'swingTime'
	--               make this a 'smoothstep' (cubic) rather than linear motion
	local time = elapsedMs % (swingTime * 2);
	local swingPercent = 1.0
	if (time < swingTime)  then
		-- on the approach of the arc
		swingPercent = time / swingTime;
		
	else
		-- on the return of the arc
		time = swingTime - (time - swingTime);
		swingPercent = time / swingTime;
	end
	-- smoothstep
	swingPercent = swingPercent * swingPercent * (3 - 2* swingPercent)
	local angle = (endAngle - startAngle) * swingPercent;

	--
	-- Example Code: go down 'zOffset' units, then back up, repeating every 'posChangeTime'
	--
	--local zTime = elapsedMs % (posChangeTime * 2);
	--local zPercent = 1.0
	--if(zTime < posChangeTime) then
	--	zPercent = zTime / posChangeTime;
	--else
	--	zTime = posChangeTime - (zTime - posChangeTime);
	--	zPercent = zTime / posChangeTime;
	--end
	--local zChange = zOffset * zPercent + 10;
	return 0,0, zOffset, 0, angle, 0;
end


 Ronald Leask 9.0 Maw - Jailer's Tower - Swinging Axe Trap Lower Angle - (STM) function maw_jailerstower_trap_swingingaxe_large_lowerangle_stm(elapsedMs, x, y, z, roll, pitch, yaw)
	------------------------------------
	-- Area Trigger Movement Script:  --
	------------------------------------
	-- Inputs: 
	--    elapsedMs: the amount of milliseconds since the 'm_creationTime' of this AreaTrigger
	--
	-- Output:
	--    x - x offset from the m_center of AreaTrigger
	--    y - y offset from the m_center of AreaTrigger
	--    z - z offset from the m_center of AreaTrigger
	--    roll - rotation around z axis
	--    pitch - rotation around y axis
	--    yaw - rotation around x axis - also known as 'facing'
	--
	--    return values in this specific order.  If you don't want to change a specific value, return 0
	--    example: if you want to adjust only 'pitch' you need to 'return 0,0,0,0,pitch'.
	--
	--

	-- Constants
	local swingTime = 2000; -- in milliseconds
	local startAngle = 0.9;
	local endAngle = 2.1;
	local zOffset = 30;
	local posChangeTime = 10000;
	
	-- Example Code: lerp from 'startAngle' to 'endAngle' then back to 'startAngle' over 'swingTime'
	--               make this a 'smoothstep' (cubic) rather than linear motion
	local time = elapsedMs % (swingTime * 2);
	local swingPercent = 1.0
	if (time < swingTime)  then
		-- on the approach of the arc
		swingPercent = time / swingTime;
		
	else
		-- on the return of the arc
		time = swingTime - (time - swingTime);
		swingPercent = time / swingTime;
	end

	-- smoothstep
	swingPercent = swingPercent * swingPercent * (3 - 2* swingPercent)
--	print("Swing percent is", swingPercent)
	local angle = ((endAngle - startAngle) * swingPercent) + startAngle
--	print("Raw angle number is equal to", angle)
--	print("Angle is equal to,", ((0.5*angle) * (180/math.pi)))

	--
	-- Example Code: go down 'zOffset' units, then back up, repeating every 'posChangeTime'
	--
	--local zTime = elapsedMs % (posChangeTime * 2);
	--local zPercent = 1.0
	--if(zTime < posChangeTime) then
	--	zPercent = zTime / posChangeTime;
	--else
	--	zTime = posChangeTime - (zTime - posChangeTime);
	--	zPercent = zTime / posChangeTime;
	--end
	--local zChange = zOffset * zPercent + 10;
	return 0,0, zOffset, 0, angle, 0;
end


 9.0 Maw - Calcis - Soul Eater Breath - PRK function maw_soul_eater_breath(elapsedMs)
	------------------------------------
	-- Area Trigger Movement Script:  --
	------------------------------------
	-- Inputs: 
	--    elapsedMs: the amount of milliseconds since the 'm_creationTime' of this AreaTrigger
	--
	-- Output:
	--    x - x offset from the m_center of AreaTrigger
	--    y - y offset from the m_center of AreaTrigger
	--    z - z offset from the m_center of AreaTrigger
	--    roll - rotation around z axis
	--    pitch - rotation around y axis
	--    yaw - rotation around x axis - also known as 'facing'
	--
	--    return values in this specific order.  If you don't want to change a specific value, return 0
	--    example: if you want to adjust only 'pitch' you need to 'return 0,0,0,0,pitch'.
	--
	--

	-- Constants
	local swingTime = 2000; -- in milliseconds
	local startAngle = 1.7;
	local endAngle = 0;
	local xOffset = -5;
	local yOffset = 10;
	local timeOffset = 1000
	local finalAngleOffset = 0.7

	
	-- Example Code: lerp from 'startAngle' to 'endAngle' then back to 'startAngle' over 'swingTime'
	--               make this a 'smoothstep' (cubic) rather than linear motion
	local time = (elapsedMs +timeOffset) % (swingTime * 2);
	local swingPercent = 1.0
	if (time < swingTime)  then
		-- on the approach of the arc
		swingPercent = time / swingTime;
		
	else
		-- on the return of the arc
		time = swingTime - (time - swingTime);
		swingPercent = time / swingTime;
	end
	-- smoothstep
	swingPercent = swingPercent * swingPercent * (3 - 2* swingPercent)
	local angle = (endAngle - startAngle) * swingPercent + finalAngleOffset;

	return xOffset,yOffset, 0, 0, 0, angle;
end


 9.0 Maw - Jailer's Tower - Traps - Side Wall Axe - 01 Area Trigger - Adamant Vaults function Maw_JailersTower_Traps_SideWallAxe_01AreaTrigger_AdamantVaults(elapsedMs, x, y, z, roll, pitch, yaw)
	------------------------------------
	-- Area Trigger Movement Script:  --
	------------------------------------
	-- Inputs: 
	--    elapsedMs: the amount of milliseconds since the 'm_creationTime' of this AreaTrigger
	--
	-- Output:
	--    x - x offset from the m_center of AreaTrigger
	--    y - y offset from the m_center of AreaTrigger
	--    z - z offset from the m_center of AreaTrigger
	--    roll - rotation around z axis
	--    pitch - rotation around y axis
	--    yaw - rotation around x axis - also known as 'facing'
	--
	--    return values in this specific order.  If you don't want to change a specific value, return 0
	--    example: if you want to adjust only 'pitch' you need to 'return 0,0,0,0,pitch'.
	--
	--

	--prints(elapsedMs, x, y, z, roll, pitch, yaw)

	-- Constants
	local totalTime = 6000 -- in milliseconds
	local swingDownTime = 1000 -- in milliseconds
	local swingUpTime = 1000 -- in milliseconds
	local reloadTime = totalTime - (swingDownTime + swingUpTime) -- in milliseconds
	local startPitch = math.pi
	local endPitch = 1.6*math.pi
	local newYaw = yaw
	local startingYOffset = -13
	local startingZOffset = 6
	local swingLength = 13
	local xOffset = 0
	local yOffset = 0
	local zOffset = 0
	--local posChangeTime = 10000;
	
	-- Example Code: lerp from 'startPitch' to 'endPitch' then back to 'startPitch' over 'swingDownTime'
	--               make this a 'smoothstep' (cubic) rather than linear motion
	local time = elapsedMs % (totalTime)
	local swingPercent = 1.0
	if (time < swingDownTime)  then
		-- on the approach of the arc
		swingPercent = time / swingDownTime
	elseif (time>= swingDownTime) and (time < (swingDownTime + swingUpTime)) then
		local modTime = time - swingDownTime
		
		time =  swingUpTime - modTime
		swingPercent = time / swingUpTime
	
	else
		--waiting!
		swingPercent = 0.0
		
		-- on the return of the arc
		--time =   totalTime -  (time)
	end
	-- smoothstep
	swingPercent = swingPercent * swingPercent * (3 - 2* swingPercent)

	--print(elapsedMs," ",x," ",y," ",z," ",roll," ",pitch," ",yaw)

	local anglePitch = (endPitch - startPitch) * swingPercent -- the angle of the axe
	local adjustedOffset = (math.sin(anglePitch) * swingLength) + startingYOffset --how far forward/back the axe is
	xOffset = math.cos(newYaw) * adjustedOffset
	yOffset =  math.sin(newYaw) * adjustedOffset
	zOffset = math.cos(anglePitch) * swingLength + startingZOffset

	return xOffset,yOffset, zOffset, 0, anglePitch, 0
end


 Candlemancer - All - Core - Shifting Sands - Area Trigger Movement function candlemancer_all_core_shifting_sands_area_trigger_movement(elapsedMs, x, y, z, roll, pitch, yaw)
	return 0, 0, -5, 0, 0, 0

end Graham Berger CharlesTest - Orbit Trigger function charles_test_orbit_trigger(elapsedMs, x, y, z, roll, pitch, yaw)
	print(x .. " " .. y .. " " .. z .. " " .. roll .. " " .. pitch .. " " .. yaw)
	return 0, 0, 0, 0, 0, 0
end


 9.1 Raid - Torghast - Ner'zhul - Achievement Hoop - SWINGS function Raid_Torghast_Nerzhul_AchievementHoop_Swings_MoveScript(elapsedMs, x, y, z, roll, pitch, yaw)
	------------------------------------
	-- Area Trigger Movement Script:  --
	------------------------------------
	-- Inputs: 
	--    elapsedMs: the amount of milliseconds since the 'm_creationTime' of this AreaTrigger
	--
	-- Output:
	--    x - x offset from the m_center of AreaTrigger
	--    y - y offset from the m_center of AreaTrigger
	--    z - z offset from the m_center of AreaTrigger
	--    roll - rotation around z axis
	--    pitch - rotation around y axis
	--    yaw - rotation around x axis - also known as 'facing'
	--
	--    return values in this specific order.  If you don't want to change a specific value, return 0
	--    example: if you want to adjust only 'pitch' you need to 'return 0,0,0,0,pitch'.
	--
	--
	
		
local function remap(value, min1, max1, min2, max2)
	if ((value == nil) or (min1 == nil) or (max1 == nil) or (min2 == nil) or (max2 == nil)) then return nil; end
	return min2 + (value - min1) * (max2 - min2) / (max1 - min1)
end
	
	local DebugSwitch=nil
	
	local MaxSwing=40*math.pi/180
	local DesiredPeriod=12000
	local _,CurrentTime=math.modf(elapsedMs/DesiredPeriod)
	local DesiredPitch
	local RadiusOfPendulum=31
	local BaseFacing=yaw
	
	if CurrentTime<.5 then
		DesiredPitch=remap(CurrentTime,0,0.5,-math.pi/2,math.pi/2)
	else
		DesiredPitch=remap(CurrentTime,.5,1.0,math.pi/2,-math.pi/2)
	end
	local SinedPitch=math.sin(DesiredPitch)*MaxSwing
	if DebugSwitch then
		--Broadcast("[69134] CurrentTime: "..CurrentTime)
		--Broadcast("[69134] DesiredPitch: "..DesiredPitch)
		--Broadcast("[69134] SinedPitch: "..SinedPitch)
	end
	
	
	local New_X=RadiusOfPendulum*math.sin(SinedPitch)*math.cos(BaseFacing)
	local New_Y=RadiusOfPendulum*math.sin(SinedPitch)*math.sin(BaseFacing)
	local New_Z=RadiusOfPendulum*math.cos(SinedPitch)*math.sin(BaseFacing)
	
	
	return -New_X,-New_Y,New_Z,0,0,0
end


 9.1 Raid - Torghast - Ner'zhul - Achievement Hoop - Pendulum Visual function Raid_Torghast_Nerzhul_AchievementHoop_PendulumVisual_MoveScript(elapsedMs, x, y, z, roll, pitch, yaw)
	------------------------------------
	-- Area Trigger Movement Script:  --
	------------------------------------
	-- Inputs: 
	--    elapsedMs: the amount of milliseconds since the 'm_creationTime' of this AreaTrigger
	--
	-- Output:
	--    x - x offset from the m_center of AreaTrigger
	--    y - y offset from the m_center of AreaTrigger
	--    z - z offset from the m_center of AreaTrigger
	--    roll - rotation around z axis
	--    pitch - rotation around y axis
	--    yaw - rotation around x axis - also known as 'facing'
	--
	--    return values in this specific order.  If you don't want to change a specific value, return 0
	--    example: if you want to adjust only 'pitch' you need to 'return 0,0,0,0,pitch'.
	--
	--
	
local function remap(value, min1, max1, min2, max2)
	if ((value == nil) or (min1 == nil) or (max1 == nil) or (min2 == nil) or (max2 == nil)) then return nil; end
	return min2 + (value - min1) * (max2 - min2) / (max1 - min1)
end
	
	local DebugSwitch=nil
	local MaxSwing=40*math.pi/180
	local DesiredPeriod=12000
	local _,CurrentTime=math.modf(elapsedMs/DesiredPeriod)
	local DesiredPitch
	
	if CurrentTime<.5 then
		DesiredPitch=remap(CurrentTime,0,0.5,math.pi/2,-math.pi/2)
	else
		DesiredPitch=remap(CurrentTime,.5,1.0,-math.pi/2,math.pi/2)
	end
	local SinedPitch=math.sin(DesiredPitch)*MaxSwing
	if DebugSwitch then
		--Broadcast("[69134] CurrentTime: "..CurrentTime)
		--Broadcast("[69134] DesiredPitch: "..DesiredPitch)
		--Broadcast("[69134] SinedPitch: "..SinedPitch)
	end
	return 0,0,0,0,-SinedPitch,0
end


 9.1 Broker City - Star Relic Prop Movement function BrokerCity_StarRelicProp_Movement(elapsedMs, x, y, z, roll, pitch, yaw)
	------------------------------------
	-- Area Trigger Movement Script:  --
	------------------------------------
	-- Inputs: 
	--    elapsedMs: the amount of milliseconds since the 'm_creationTime' of this AreaTrigger
	--
	-- Output:
	--    x - x offset from the m_center of AreaTrigger
	--    y - y offset from the m_center of AreaTrigger
	--    z - z offset from the m_center of AreaTrigger
	--    roll - rotation around z axis
	--    pitch - rotation around y axis
	--    yaw - rotation around x axis - also known as 'facing'
	--
	--    return values in this specific order.  If you don't want to change a specific value, return 0
	--    example: if you want to adjust only 'pitch' you need to 'return 0,0,0,0,pitch'.
	--
	--

	--prints(elapsedMs, x, y, z, roll, pitch, yaw)

	-- Constants
	local totalTime = 10000 -- in milliseconds
	
	local startingZOffset = .1
	local totalMoveHeight = 1
	local xOffset = 0
	local yOffset = 0
	local zOffset = 0

	local time = elapsedMs % (totalTime)
	local timePercent = time/totalTime * 6.283
	
	zOffset = startingZOffset + totalMoveHeight + (totalMoveHeight * math.cos(timePercent))
	
	--print(time," ",timePercent," ",z, " ", zOffset)
	
	return xOffset, yOffset, zOffset, 0, 0, 0
end


 9.1 Toy - Top Movement function toy_top_trigger(elapsedMs, x, y, z, roll, pitch, yaw)
	------------------------------------
	-- Area Trigger Movement Script:  --
	------------------------------------
	-- Inputs: 
	--    elapsedMs: the amount of milliseconds since the 'm_creationTime' of this AreaTrigger
	--
	-- Output:
	--    x - x offset from the m_center of AreaTrigger
	--    y - y offset from the m_center of AreaTrigger
	--    z - z offset from the m_center of AreaTrigger
	--    roll - rotation around z axis
	--    pitch - rotation around y axis
	--    yaw - rotation around x axis - also known as 'facing'
	--
	--    return values in this specific order.  If you don't want to change a specific value, return 0
	--    example: if you want to adjust only 'pitch' you need to 'return 0,0,0,0,pitch'.
	--
	--	
	
	
	print(x .. " " .. y .. " " .. z .. " " .. roll .. " " .. pitch .. " " .. yaw)
	return 0, 0, 0, 0, 0, 0
end


 9.2 Raid - Progenitor - Terrestrial Keeper - Cube FX 0 Area Trigger - Move Script Z Rotate function rotate_z_axis(elapsedMs, x, y, z, roll, pitch, yaw)
------------------------------------
	-- Area Trigger Movement Script:  --
	------------------------------------
	-- Inputs: 
	--    elapsedMs: the amount of milliseconds since the 'm_creationTime' of this AreaTrigger
	--
	-- Output:
	--    x - x offset from the m_center of AreaTrigger
	--    y - y offset from the m_center of AreaTrigger
	--    z - z offset from the m_center of AreaTrigger
	--    roll - rotation around z axis
	--    pitch - rotation around y axis
	--    yaw - rotation around x axis - also known as 'facing'
	--
	--    return values in this specific order.  If you don't want to change a specific value, return 0
	--    example: if you want to adjust only 'pitch' you need to 'return 0,0,0,0,pitch'.
	--
	--

	--prints(elapsedMs, x, y, z, roll, pitch, yaw)

	-- Constants
	local totalTime = 10000 -- in milliseconds
	
	local startingZOffset = .1
	local totalMoveHeight = 1
	local xOffset = 0
	local yOffset = 0
	local zOffset = 0
	
	
	local time = elapsedMs % (totalTime)
	local timePercent = time/totalTime * 6.283
	
	local zRotate = .001*time
	local yRotate = .002*time
	local startingZRotate = 0
	
	--zOffset = startingZOffset + totalMoveHeight + (totalMoveHeight * math.cos(timePercent))
	
	--print(time," ",timePercent," ",z, " ", zOffset)
	
	return xOffset, yOffset, zOffset, zRotate, yRotate, 0
end
 9.2 Raid - Progenitor - Terrestrial Keeper - Orb Movement function TerrestrialKeeper_OrbMovement(elapsedMs, x, y, z, roll, pitch, yaw)
	------------------------------------
	-- Area Trigger Movement Script:  --
	------------------------------------
	-- Inputs: 
	--    elapsedMs: the amount of milliseconds since the 'm_creationTime' of this AreaTrigger
	--
	-- Output:
	--    x - x offset from the m_center of AreaTrigger
	--    y - y offset from the m_center of AreaTrigger
	--    z - z offset from the m_center of AreaTrigger
	--    roll - rotation around z axis
	--    pitch - rotation around y axis
	--    yaw - rotation around x axis - also known as 'facing'
	--
	--    return values in this specific order.  If you don't want to change a specific value, return 0
	--    example: if you want to adjust only 'pitch' you need to 'return 0,0,0,0,pitch'.
	--
	--

	--prints(elapsedMs, x, y, z, roll, pitch, yaw)

	-- Constants
	local totalTime = 10000 -- in milliseconds
	
	local startingZOffset = .1
	local totalMoveHeight = 1
	local xOffset = 0
	local yOffset = 0
	local zOffset = 0

	local time = elapsedMs % (totalTime)
	local timePercent = time/totalTime * 6.283
	
	zOffset = startingZOffset + totalMoveHeight + (totalMoveHeight * math.cos(timePercent))
	
	--print(time," ",timePercent," ",z, " ", zOffset)
	
	return xOffset, yOffset, zOffset, 0, 0, 0
end


 9.2 Raid - Progenitor - Terrestrial Keeper - Mines 0 Precast function terrestrial_keeper_mines_move_script(elapsedMs, x, y, z, roll, pitch, yaw)
	------------------------------------
	-- Area Trigger Movement Script:  --
	------------------------------------
	-- Inputs: 
	--    elapsedMs: the amount of milliseconds since the 'm_creationTime' of this AreaTrigger
	--
	-- Output:
	--    x - x offset from the m_center of AreaTrigger
	--    y - y offset from the m_center of AreaTrigger
	--    z - z offset from the m_center of AreaTrigger
	--    roll - rotation around z axis
	--    pitch - rotation around y axis
	--    yaw - rotation around x axis - also known as 'facing'
	--
	--    return values in this specific order.  If you don't want to change a specific value, return 0
	--    example: if you want to adjust only 'pitch' you need to 'return 0,0,0,0,pitch'.
	--
	--

	--prints(elapsedMs, x, y, z, roll, pitch, yaw)

	-- Constants
	local totalTime = 1900 -- in milliseconds
	
	local startingZOffset = -1
	local totalMoveHeight = 3
	local xOffset = 0
	local yOffset = 0
	local zOffset = 0

	local time = elapsedMs % (totalTime)
	local timePercent = time/totalTime * 6.283
	
	zOffset = startingZOffset + (totalMoveHeight * timePercent)
	
	
	--print(time," ",timePercent," ",z, " ", zOffset)
	
	return xOffset, yOffset, zOffset, 0, 0, 0
end


 (BAD) 10.0 Primalist - Wind Elemental - Add's Raging Tempest - Spawn Spiral Area Triggers function Raid_Primalist_WindElemental_AddRagingTempest_SpawnSpiralAreaTriggers_MoveScript(elapsedMs, x, y, z, roll, pitch, yaw)
	local function GenerateSmoothSpiralModded(direction,growth,points,pointsPerCircle)
		local output = {{0,0,0},}
		local rotation = Random(0,360)

		for i=0,points do
			rotation = rotation+(360/pointsPerCircle)
			if rotation>=360 then rotation=rotation-360 end
			local OffsetVector = GetSavedC3Vector({i*growth,0,0})
			OffsetVector = C3Vector_2DRotate(OffsetVector,math.rad(math.floor(rotation))*direction)
			table.insert(output,SaveC3Vector(OffsetVector))
		end
		return output
	end
	
	local vortexDirection = (Random(1,2)*2)-3	-- Gets 1 or -1
	local vortexGrowth = Random(15,25) / 100		-- Gets a decimal
	local vortexPoints = Random(15,25)
	local vortexPointsPerCircle = Random(10,15)

	for k,v in pairs(GenerateSmoothSpiralModded(vortexDirection,vortexGrowth,vortexPoints,vortexPointsPerCircle)) do
		pathContainer:add(C3Vector_add(GetSavedC3Vector(v),position))
	end


end


 Matt Nemiah Trampling Hooves Dummy Animation Trigger function moveForward(elapsedMs, x, y, z, roll, pitch, yaw)



end


 Alan Castle Druid - Syzygy - Path To Dest function syzygy_path_to(elapsedMs, x, y, z, roll, pitch, yaw)

	return caster.syzygyEnd

end


 Alex Ringe  �  ��  ��  ��  ��  ��  �  ��  �  a � s   � � H K ] �( �- N2 