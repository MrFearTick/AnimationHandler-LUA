--!strict

-- Animation Module by @MrFearTick 
-- Version 1.1

--/ Variables /--

local Handler = {}
local AnimationsCache = {}
Handler.__index = Handler

-- Types

type animationConfig = {
	["Name"] : string, 
	["Id"] : string
}

type animationTrackConfig = {
	["Speed"] : number, 
	["Looped"] : boolean
}

-- Presets

Handler.Animations = {
	["Emote"] = {["Name"] = "/e dance 2", ["Id"] = "rbxassetid://507776043"}
}

Handler.TrackConfig = {
	["Default"] = {["Speed"] = 1, ["Looped"] = true},
	["Fast"] = {["Speed"] = 2, ["Looped"] = true}
}

--/ Functions /--

function Handler.new(animatorObject : Animator, name : string)
	local newHandleObject = {}
	
	local animator = animatorObject
	local cache = {}
	
	local generatedObjects = {}

	if AnimationsCache[name] then error("Can't create 2 or more Handlers on the same Animator.", 5) end
	AnimationsCache[name] = newHandleObject
	
	function newHandleObject:Load(config : animationConfig)
		if not cache[config.Name] then
			local animationObject = Instance.new("Animation");
			animationObject.AnimationId = config.Id; animationObject.Parent = animator
			animationObject.Name = config.Name
			table.insert(generatedObjects, animationObject)
		
			local animationTrack = animator:LoadAnimation(animationObject)
			cache[config.Name] = animationTrack
			
		else warn("This Animation is already loaded on the Animator.") return end
	end
	
	local function getAnimation(name : string) : AnimationTrack?
		if cache[name] then return cache[name]
		else warn(`Animation "{name}" isn't loaded on the Animator. Please consider loading it first.`) return end
	end
	
	function newHandleObject:Play(config : animationConfig, trackConfig : animationTrackConfig, Priority : Enum.AnimationPriority?)
		local animationTrack = getAnimation(config.Name); if not animationTrack then return end
		
		animationTrack.Looped = trackConfig.Looped
		animationTrack.Priority = Priority or Enum.AnimationPriority.Core
		
		animationTrack:Play(); animationTrack:AdjustSpeed(trackConfig.Speed)
	end

	function newHandleObject:Pause(config : animationConfig, Duration : number, yield : boolean?)
		local animationTrack = getAnimation(config.Name); if not animationTrack then return end
		
		local function pause()
			local originalSpeed = animationTrack.Speed
			animationTrack:AdjustSpeed(0); task.wait(Duration); animationTrack:AdjustSpeed(originalSpeed)
		end
		
		if not yield then task.spawn(pause)
		else pause() end
	end

	function newHandleObject:Stop(config : animationConfig)
		local animationTrack = getAnimation(config.Name); if not animationTrack then return end
		
		animationTrack:Stop()
	end
	
	function newHandleObject:Wait(config : animationConfig)
		local animationTrack = getAnimation(config.Name); if not animationTrack then return end

		animationTrack.Ended:Wait()
	end
	
	function newHandleObject:Destroy()
		for _, track in pairs(animator:GetPlayingAnimationTracks()) do newHandleObject:Stop({["Name"] = track.Name, ["Id"] = track.Animation.AnimationId}) end
		for _, object in pairs(generatedObjects) do object:Destroy() end
		for _, object in pairs(cache) do object:Destroy() end
		
		table.clear(newHandleObject); table.clear(generatedObjects); table.clear(cache)
		AnimationsCache[name] = nil
	end
	
	return setmetatable(newHandleObject, Handler)
end

--

function Handler.find(name : string) : {}?
	if AnimationsCache[name] then return AnimationsCache[name]
	else warn(`There isn't an object with the name: {name}`) return end
end

function Handler.destroy(name : string)
	if AnimationsCache[name] then AnimationsCache[name]:Destroy()
	else warn(`There isn't an object with the name: {name}`) return end
end

return Handler
