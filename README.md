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

#

### Configuring Animations and Presets:

#

### Methods and Examples:

#
