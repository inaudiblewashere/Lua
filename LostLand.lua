local Library = loadstring(game:HttpGet("https://raw.githubusercontent.com/inaudiblewashere/Lua/main/MyGuiLib.lua"))()
local ESP = loadstring(game:HttpGet("https://kiriot22.com/releases/ESP.lua"))()
ESP.FaceCamera = true
ESP.Players = false

local PlayerChoice = nil
local OreTable = {}
local Mining = false
local Steal = false
local Pickaxes = {
	"Wood Pick",
	"Stone Pick",
	"Turquoise Pick",
	"Amethyst Pick",
	"Iron Pick",
	"Gold Pick",
	"Crystal Pick",
	"Ruby Pick",
	"Green Quartz Pick",
	"Rhodonite Pick",
	"Saphire Pick",
	"Shell Pick",
	"Titanium Pick",
	"Tanzanite Pick",
	"Jade Pick",
	"Apatite Pick",
	"Diamond Pick",
	"Topaz Pick",
	"Lightning Tool",
	"Obsidian Pick",
	"Fire Opal Pick",
	"Meteorite Pick"
}
local TextChoice = nil
local Picking = false
local PTable = {}
local KillingTime = false
local KillingAllTime = false
local render = false
local MineMethod = game:GetService("Workspace")

local KillPlayers = function(Player)
	while KillingTime do
		wait()
		game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = game:GetService("Players")[Player].Character.HumanoidRootPart.CFrame + game:GetService("Players")[Player].Character.HumanoidRootPart.CFrame.lookVector * -1
		local args = {
			[1] = game:GetService("Players").LocalPlayer.Character:FindFirstChild(game.Players.LocalPlayer.Character:FindFirstChildOfClass("Tool").Name),
			[2] = game:GetService("Players")[Player].Character.HumanoidRootPart.CFrame
		}
		game:GetService("ReplicatedStorage").Events.DestroyModel:FireServer(unpack(args))
	end
end

local KillAllPlayers = function()
	while KillingAllTime do
		wait()
		for i,v in pairs(PTable) do
			if game:GetService("Workspace")[v] then
				while game:GetService("Workspace")[v].Humanoid.Health > 0 and KillingAllTime do
					wait()
					game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = game:GetService("Players")[v].Character.HumanoidRootPart.CFrame + game:GetService("Players")[v].Character.HumanoidRootPart.CFrame.lookVector * -1
					local args = {
						[1] = game:GetService("Players").LocalPlayer.Character:FindFirstChild(game.Players.LocalPlayer.Character:FindFirstChildOfClass("Tool").Name),
						[2] = game:GetService("Players")[v].Character.HumanoidRootPart.CFrame
					}
					game:GetService("ReplicatedStorage").Events.DestroyModel:FireServer(unpack(args))
					if game:GetService("UserInputService"):IsKeyDown(Enum.KeyCode.RightShift) then
						wait(0.5)
						break
					end
				end
			end
		end
	end
end


ESP:AddObjectListener(game:GetService("Workspace").Ores, {
    Type = "Model",
    Validator = function(obj)
		if obj.Name == "Small Rock" or obj.Name == "Huge Rock" or obj.Name == "Big Rock" then
				return false
		end

        return true
    end,
	OnAdded = function(box)
		box.Components.Quad:Remove()
		box.Components.Quad = nil
		box.Components.Distance:Remove()
		box.Components.Distance = {Remove = function() end}
	end,
    IsEnabled = "Ores"
})

ESP:AddObjectListener(game:GetService("Workspace").Animals, {
    Type = "Model",
    IsEnabled = "Animals",
	OnAdded = function(box)
		box.Components.Quad:Remove()
		box.Components.Quad = nil
		box.Components.Distance:Remove()
		box.Components.Distance = {Remove = function() end}
	end
})

local AutoMine = function()
	local tool = nil
	local Plr = game:GetService("Players").LocalPlayer
	local high = 0
	if Mining then
		for i, v in pairs(Plr.Backpack:GetChildren()) do
			for o, x in pairs(Pickaxes) do
				if string.match(v.Name, x) then
					if o > high then
						high = o
						tool = v
					end
				end
			end
		end
		Plr.Character.Humanoid:EquipTool(tool)
	end
	while Mining do
		wait(0.01)
		for j,s in pairs(OreTable) do
			local x = s:gsub("%p", " ")
			local exists = true
			local check = MineMethod:FindFirstChild(x.." Rock")
			local mine = MineMethod
			if check == nil and not render then
				check = MineMethod.Ores:FindFirstChild(x.." Rock")
				if check == nil then
					exists = false
				end
				mine = MineMethod.Ores
			end
			while exists and Mining do
				wait(0.001)
				local ore = mine:FindFirstChild(x.." Rock")
				while Mining do
					wait(0.01)
					local itemcheck = game:GetService("Workspace"):FindFirstChild(x)
					if itemcheck == nil then
						break
					end
					Plr.Character.HumanoidRootPart.CFrame = game:GetService("Workspace")[x].CFrame
					do
						game:GetService("ReplicatedStorage").Events:FindFirstChild("Pick up"):FireServer(itemcheck)
					end
				end
				if ore == nil then
					break
				end

				local args = {
					[1] = Plr.Character:FindFirstChild(Plr.Character:FindFirstChildOfClass("Tool").Name),
					[2] = Plr.Character.HumanoidRootPart.CFrame
				}
				game:GetService("ReplicatedStorage").Events.DestroyModel:FireServer(unpack(args))
				
				do
					Plr.Character.HumanoidRootPart.CFrame = ore.Reference.CFrame
				end
			end
		end
	end
	for i,v in pairs(Plr.Character:GetChildren()) do
		if v:IsA"Tool" then
			 v.Parent = Plr.Backpack;
		end;
   end;
end

local StealOres = function()
	while Steal do
		wait()
		for i,v in pairs(OreTable) do
			while Steal do
				wait()
				local check = game:GetService("Workspace"):FindFirstChild(v)
				if check == nil then
					break
				end
				game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = game:GetService("Workspace")[v].CFrame
				do
					game:GetService("ReplicatedStorage").Events:FindFirstChild("Pick up"):FireServer(check)
				end
			end
		end
	end
end

local TeleportPlayerItems = function(Item)
	while Picking do
		wait()
		for _,v in next, game.Workspace:GetDescendants() do
			if v.Name == Item then
				game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = game:GetService("Workspace")[Item].CFrame
				do
					game:GetService("ReplicatedStorage").Events:FindFirstChild("Pick up"):FireServer(v)
				end
			end
		end
	end
end


local fishing = false
local FishFarm = function()
	local name = game.Players.LocalPlayer.Name
	while fishing do
		wait()
		for i,v in next, game:GetService("Workspace")[name.."Model"]:GetDescendants() do
			if v.Name == "Fish Trap" then
				for j,x in next, v:GetDescendants() do
					if x.name == "Raw Fish Meat" then
						game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = x.CFrame
						do
							game:GetService("ReplicatedStorage").Events:FindFirstChild("Pick up"):FireServer(x)
						end
					end
				end
			end
		end
	end
end


local heal = false
local AutoHeal = function()
	local Consume = game:GetService("ReplicatedStorage").Events.Consume
	while heal do
		wait(0.1)
		local Health = string.gsub(game:GetService("Players").LocalPlayer.PlayerGui["Player Screen"].Vitals.Health.AmountDisplayer.Text, "%p", "")
		if tonumber(Health) < 50 then
			Consume:FireServer("Health Potion")
		end
	end
end

local thirst = false
local AutoDrink = function()
	local Consume = game:GetService("ReplicatedStorage").Events.Consume
	while thirst do
		wait(0.1)
		local Drink = string.gsub(game:GetService("Players").LocalPlayer.PlayerGui["Player Screen"].Vitals.Thirst.AmountDisplayer.Text, "%p", "")
		if tonumber(Drink) < 50 then
			Consume:FireServer("Thirst Potion")
		end
	end
end

local hunger = false
local AutoEat = function()
	local Consume = game:GetService("ReplicatedStorage").Events.Consume
	while hunger do
		wait(0.1)
		local Eat = string.gsub(game:GetService("Players").LocalPlayer.PlayerGui["Player Screen"].Vitals.Hunger.AmountDisplayer.Text, "%p", "")
		if tonumber(Eat) < 50 then
			Consume:FireServer("Hunger Potion")
		end
	end
end
local x = Library:CreateWindow("The Lost Land v0.5")
local tab1 = x.Tab({Title = "Main Menu"})
local tab2 = x.Tab({Title = "Local Player", Icon = "player"})
local tab3 = x.Tab({Title = "Annoying", Icon = "pvp"})
local tab4 = x.Tab({Title = "Item Farm", Icon = "item"})
local tab5 = x.Tab({Title = "Coin Farm", Icon = "money"})

local uitoggle = true
local bind = "P"
local focused = false
local uis = game:service('UserInputService');
uis.TextBoxFocused:Connect(function()
	focused = true
end)
uis.TextBoxFocusReleased:Connect(function()
    focused = false
end)
uis.InputBegan:connect(function(key)
    if key.KeyCode == bind and not focused then
        x.LibraryToggle()
    end
end)

tab1.Keybind({
    Title = "Toggle UI",
    Key = "P",
    Callback = function(Key)
        bind = Enum.KeyCode[Key:upper()];
    end
})

tab1.Toggle({
    Title = "ESP",
    Callback = function(Value)
        ESP:Toggle(Value)
    end
})

tab1.Chipset({
    Title = "ESP Options",
    Callback = function(ChipSet)
		table.foreach(ChipSet, function(Option, Value)
			ESP[Option] = Value
		end)
	end,
	List = {
        "Players",
        "Ores",
        "Animals"
	}
})

tab2.Slider({
    Title = "Player WalkSpeed",
	Callback = function(Value)
		game.Players.LocalPlayer.Character.Humanoid.WalkSpeed = Value
	end,
	Min = 16,
	Max = 26,
	Def = 16
})

tab2.Slider({
    Title = "Player JumpHeight",
	Callback = function(Value)
		game.Players.LocalPlayer.Character.Humanoid.JumpPower = Value
	end,
	Min = 50,
	Max = 80,
	Def = 50
})

tab2.Section()

tab2.Slider({
    Title = "HitBox Expander",
	Callback = function(Value)
		for i, v in pairs(game.Players:GetPlayers()) do
			if v.Name ~= game.Players.LocalPlayer.Name then
				pcall(function()
					v.Character.HumanoidRootPart.Material = "Neon"
					v.Character.HumanoidRootPart.Size = Vector3.new(Value, Value, Value)
					v.Character.HumanoidRootPart.CanCollide = false
					v.Character.HumanoidRootPart.Transparency = 0.5
				end)
			end
		end
	end,
	Min = 1,
	Max = 100,
	Def = 1
})

tab2.Slider({
    Title = "Transparency",
	Callback = function(Value)
		for i, v in pairs(game.Players:GetPlayers()) do
			if v.Name ~= game.Players.LocalPlayer.Name then
				pcall(function()
				v.Character.HumanoidRootPart.Transparency = Value * 0.01
				end)
			end
		end
	end,
	Min = 0,
	Max = 100,
	Def = 50
})

tab3.Toggle({
    Title = "Auto use Health Potion",
    Callback = function(Value)
		if Value then
			heal = true
			AutoHeal()
		else
			heal = false
		end
	end
})

tab3.Toggle({
    Title = "Auto use Thirst Potion",
    Callback = function(Value)
        if Value then
			thirst = true
			AutoDrink()
		else
			thirst = false
		end
    end
})

tab3.Toggle({
    Title = "Auto use Hunger Potion",
    Callback = function(Value)
        if Value then
			hunger = true
			AutoEat()
		else
			hunger = false
		end
    end
})

tab3.Section()

tab3.Button({
	Title = "2x Cut Speed",
	Callback = function()
			game:GetService("Players").LocalPlayer.PlayerData.Others.ToolCutTime.Value = 0.3
	end
})

tab3.Toggle({
    Title = "Kill All Players",
    Callback = function(Value)
        if Value then
			KillingAllTime = true
			KillAllPlayers(PlayerChoice)
		else
			KillingAllTime = false
		end
    end
})

tab3.Toggle({
    Title = "Kill Target",
    Callback = function(Value)
        if Value then
			KillingTime = true
			KillPlayers(PlayerChoice)
		else
			KillingTime = false
		end
    end
})

local PlayerSelect = tab3.Dropdown({
    Title = "Target",
	Callback = function(Value)
		print(Value)
		PlayerChoice = Value
	end,
	List = {}
})

local Update = function()
	local plrs = game:GetService("Players"):GetPlayers()
	for i,v in pairs(PTable) do
		PTable[i] = nil
	end
	for i,v in pairs(plrs) do 
		if v ~= game.Players.LocalPlayer then
			table.insert(PTable, v.Name)
		end
	end
	table.sort(PTable,function(a, b) return a:lower() < b:lower() end)
	PlayerSelect:ChangeList(PTable)
end
game:GetService("Players").PlayerAdded:Connect(Update)
game:GetService("Players").PlayerRemoving:Connect(Update)
Update()

tab4.Toggle({
    Title = "Pickup Dropped Item",
	Callback = function(Value)
		if Value == true then
			Picking = true
			TeleportPlayerItems(TextChoice)
		else
			Picking = false
		end
	end
})

tab4.Text({
    Title = "Type item name here",
	Callback = function(Value)
		TextChoice = Value
	end
})

tab4.Section("Turn off Reduce Lag in settings (Z)")

tab4.Toggle({
    Title = "(Check this if you need reduce lag)",
	Callback = function(Value)
		if Value == true then
			MineMethod = game:GetService("ReplicatedStorage")["Render Folder"]
			render = true
		else
			MineMethod = game:GetService("Workspace")
			render = false
		end
	end
})

tab4.Toggle({
    Title = "Steal Ores (Select Ores First)",
	Callback = function(Value)
		if Value == true then
			Steal = true
			StealOres()
		else
			Steal = false
		end
	end
})

tab4.Toggle({
    Title = "Auto Mine",
	Callback = function(Value)
		if Value == true then
			Mining = true
			AutoMine()
		else
			Mining = false
		end
	end
})

tab4.Chipset({
    Title = "Select Ores",
    Callback = function(ChipSet)
		table.foreach(ChipSet, function(Option, Value)
			if Value then
				local ispresent = false
				for i,v in pairs(OreTable) do
					if v == Option then
						ispresent = true
					end
				end
				if ispresent == false then
					table.insert(OreTable, Option)
				end
			else
				for i,v in pairs(OreTable) do
					if v == Option then
						table.remove(OreTable, i)
					end
				end
			end
		end)
	end,
	List = {
		"Coal",
        "Turquoise",
		"Amethyst",
		"Iron",
		"Gold",
		"Crystal",
		"Ruby",
		"Green_Quartz",
		"Rhodonite",
		"Sapphire",
		"Titanium",
		"Tanzanite",
		"Jade",
		"Apatite",
		"Topaz",
		"Obsidian",
		"Fire_Opal",
		"Meteorite"
	}
})

tab5.Toggle({
    Title = "Start/Stop Farm",
	Callback = function(Value)
		if Value == true then
			fishing = true
			FishFarm()
		else
			fishing = false
		end
	end
})

tab5.Section("---------- How to Setup ----------")
tab5.Section("Go to solo island and make as many fish traps as you want")
tab5.Section("then make a market so you can sell the fish meat")
tab5.Section("activate the farm and whenever your backpack is full")
tab5.Section("sell the fish meat at the market")