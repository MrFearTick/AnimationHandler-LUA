# AnimationHandler-LUA
An Animation Handler written for Roblox.

### *Please don't use without giving credit to [@MrFearTick]*

> [!WARNING]
> This module should be only called from client.
#

### Table of Contents

1. [Creating a new Animation Handler Object](#creating-a-new-animation-handler-object)
2. [Configuring Animations and Presets](#configuring-animations-and-presets)
3. [Methods and Examples](#methods-and-examples)

#

### Creating a new Animation Handler Object:

To use the handler, we must first create an **AnimationHandler**, which is the object that will let us load and use animations however we want.  
We can do this by using the `Module.new(animatorObject : Animator, name : string)` method.

### What is a ***Animator***?

***Animator*** is a Object that lets us load, modify, play and stop Animations on the host.  
Its found in every **Humanoid**, called the "Animator".

<br />

Now that we know what an ***Animator*** is, we can countinue and create our Handler.

```lua
local Module = require(game.ReplicatedStorage.Modules.AnimationHandler)
local Player = game.Players.LocalPlayer

local Handler = Module.new(Player.Character.Humanoid.Animator, Player.UserId)
```

In this example, the Handler is created for the Player, so everything this handler does is applied to the Player.  
If we wanted to animate a different Humanoid, we would have to create a seperate Handler.

> [!IMPORTANT]
> The second Parameter, which is the Handlers assigned name, has to be named differently for every different Handler that is created.

 <br />

Also, if we want to use an **AnimationHandler** that was created in another script, we can just use `Module.find(name : string)`  
The **name** being the same name we gave our **AnimationHandler** when we created it.

#

### Configuring Animations and Presets:

To call and use Animations with your desired configuration, we must first configure them inside the Module.  
Please locate the **Handler.Animations** and **Handler.TrackConfig** inside your module.  

To create an Animation, use the following Template:

```lua
Handler.Animations = {
    ["Name"] = { -- This name is the actual Name you will see while writing in code.
        ["Name"] = "DisplayName", -- This name won't be visible on code.
        ["Id"] = "rbxassetid://000000000" -- replace the 0's with your own ID.
    }
}
```

To create an TrackConfiguration, use the following Template:
```lua
Handler.TrackConfig = {
    ["Name"] = { -- This name is the actual Name you will see while writing in code.
        ["Speed"] = 1, -- the value can be both positive and negative. (Negative makes it go backwards, 0 stops it.) 
        ["Looped"] = false -- if the animation should keeps playing over and over.
    }
}
```

You can add as much Animation and Configuration as you want.

#

### Methods and Examples:

For all the Examples Below, we use these presets:

```lua
Handler.Animations = {
    ["Emote"] = {
        ["Name"] = "/e dance 2",
         ["Id"] = "rbxassetid://507776043"
    }
}

Handler.TrackConfig = {
    ["Default"] = {
        ["Speed"] = 1,
        ["Looped"] = true
    },

    ["Fast"] = {
        ["Speed"] = 2,
        ["Looped"] = true
    },
}
```  

Also, all the examples below are made to be used in a script that runs in the client.

#

### :Load()

Before you can use the other methods, you must first load the animation.  
To do that, first we create a new Animation in the Handler, and then Load it in using `Handler:Load(config : animationConfig)`  

**Example:**  

```lua
local Handler = Module.new(Player.Character.Humanoid.Animator, Player.UserId)

Handler:Load(Module.Animations.Emote)
```

<br />

### :Play()

With this method we can play the loaded animation with the given **TrackConfig**,
The method is used as  
`Handler:Play(config : animationConfig, trackConfig : animationTrackConfig, Priority : Enum.AnimationPriority?)`  

**Example:**  

```lua
local Handler = Module.new(Player.Character.Humanoid.Animator, Player.UserId)

Handler:Play(Module.Animations.Emote, Module.TrackConfig.Default, Enum.AnimationPriority.Action4)
```

> [!NOTE]
> The last parameter (priority), is up to the user. Can be left empty.  

<br />

### :Stop()

This method will stop the running animation from the given **animationConfig**, this method is used as `Handler:Stop(config : animationConfig)`  

**Example:**  

```lua
local Handler = Module.new(Player.Character.Humanoid.Animator, Player.UserId)

Handler:Play(Module.Animations.Emote, Module.TrackConfig.Default, Enum.AnimationPriority.Action4)
task.wait(2)

Handler:Stop(Module.Animations.Emote) -- The animation will stop after 2 seconds has passed.
```

<br />

### :Pause()

This method sets the **Speed** of the **AnimationTrack** to 0 for a given amount of time, with the option to yield the code until the time has passed.  
an Animation can be paused using the method, which is initialized as `Handler:Pause(config : animationConfig, Duration : number, yield : boolean?)`  

**Example:**  

```lua
local Handler = Module.new(Player.Character.Humanoid.Animator, Player.UserId)

Handler:Play(Module.Animations.Emote, Module.TrackConfig.Default, Enum.AnimationPriority.Action4)
task.wait(1)

Handler:Pause(Module.Animations.Emote, 2, true)
-- since the last parameter (yield) is true, the code will wait until the pause ends [or in other words, task.wait(2)]

print("Countinue.") -- Will print 2 seconds after the Pause.
```

> [!NOTE]
> The last parameter (yield), is up to the user. Can be left empty.

<br />

### :Wait()

To yield until a given Animation ends, we must use the `Handle:Wait(config : animationConfig)`  

> [!WARNING]
> the Method ":Wait()" won't work on Animations that are Looped!
> 
> The reason being that the **AnimationTrack.Ended** signal doesn't fire when the Animations are looped, since technically they never end. Unless an external action stops the playing animation.  

**Example:**  

In this example, consider the "Module.TrackConfig.DefaultNoLoop" as a **TrackConfig** that is *NOT LOOPING*!

```lua
local Handler = Module.new(Player.Character.Humanoid.Animator, Player.UserId)

Handler:Play(Module.Animations.Emote, Module.TrackConfig.DefaultNoLoop, Enum.AnimationPriority.Action4)

Handler:Wait(Module.Animations.Emote) -- Will yield the code until the "Emote" Animation finishes.

print("Finished.")
```

<br />

### :Destroy()

This Method will destroy the **Handler**. Also stopping any animation that was played using the Handler as it removes itself.

**Example:**

```lua
local Handler = Module.new(Player.Character.Humanoid.Animator, Player.UserId)

Handler:Play(Module.Animations.Emote, Module.TrackConfig.Default, Enum.AnimationPriority.Action4)
task.wait(3)

Handler:Stop(Module.Animations.Emote)

Handler:Destroy() -- We destroy the Handler, never intending to use it again on this host. (Animator)
```

> [!NOTE]
> There is a Alias for the Method ":Destroy()", `Module.destroy(name : string)`
>
> As you can guess, the **Name** parameter being the name of the Handler we want to destroy.

<br />
