-- ESP --
local ESP = loadstring(game:HttpGet("https://kiriot22.com/releases/ESP.lua"))()
ESP.FaceCamera = true

-- Stuff --
local PlayerChoice = nil
local OreChoice = nil
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
	"Topaz Pick",
	"Obsidian Pick",
	"Fire Opal Pick",
	"Meteorite Pick"
}
local TextChoice = nil
local EventChoice = nil
local Picking = false
local PTable = {}
local KillingTime = false
local MineMethod = game:GetService("Workspace").Ores

local KillPlayers = function(Player)
	while KillingTime do
		wait()
		local args = {
			[1] = game:GetService("Players").LocalPlayer.Character:FindFirstChild(game.Players.LocalPlayer.Character:FindFirstChildOfClass("Tool").Name),
			[2] = game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame
		}

		game:GetService("ReplicatedStorage").Events.DestroyModel:FireServer(unpack(args))

		game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = game:GetService("Players")[Player].Character.HumanoidRootPart.CFrame + game:GetService("Players")[Player].Character.HumanoidRootPart.CFrame.lookVector * -1
	end
end

-- Ores --
ESP:AddObjectListener(game:GetService("Workspace").Ores, {
    Type = "Model",
    Validator = function(obj)
        for i,v in pairs(OreTable) do
			if obj.Name == v.." Rock" then
				return true
			end
		end
        return false
    end,
	OnAdded = function(box)
		box.Components.Quad:Remove()
		box.Components.Quad = nil
		box.Components.Distance:Remove()
		box.Components.Distance = {Remove = function() end}
	end,
    IsEnabled = "Ores"
})

-- Animals --
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

-- Auto Farm --
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
			if check == nil then
				exists = false
			end
			while exists and Mining do
				wait(0.001)
				check = MineMethod:FindFirstChild(x.." Rock")
				if check == nil then
					while Mining do
						wait(0.01)
						check = game:GetService("Workspace"):FindFirstChild(x)
						if check == nil then
							break
						end
						Plr.Character.HumanoidRootPart.CFrame = game:GetService("Workspace")[x].CFrame
						do
							game:GetService("ReplicatedStorage").Events:FindFirstChild("Pick up"):FireServer(check)
						end
					end
					break
				end
				local args = {
					[1] = Plr.Character:FindFirstChild(Plr.Character:FindFirstChildOfClass("Tool").Name),
					[2] = Plr.Character.HumanoidRootPart.CFrame
				}
				game:GetService("ReplicatedStorage").Events.DestroyModel:FireServer(unpack(args))
				
				do
					Plr.Character.HumanoidRootPart.CFrame = MineMethod[x.." Rock"].Reference.CFrame
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

-- Coin Farm --
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

-- Healing --
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

-- Gui --
local Material = loadstring(game:HttpGet("https://raw.githubusercontent.com/Kinlei/MaterialLua/master/Module.lua"))()

local X = Material.Load({
	Title = "The Lost Land",
	Style = 3,
	SizeX = 500,
	SizeY = 350,
	ColorOverrides = {
		MainFrame = Color3.fromRGB(20,20,20),
		Minimise = Color3.fromRGB(20, 20, 20),
		MinimiseAccent = Color3.fromRGB(219, 210, 202),
		Maximise = Color3.fromRGB(189, 183, 177),
		MaximiseAccent = Color3.fromRGB(189, 183, 177),
		NavBar = Color3.fromRGB(219, 68, 103),
		NavBarAccent = Color3.fromRGB(20,20,20),
		NavBarInvert = Color3.fromRGB(30,30,30),
		TitleBar = Color3.fromRGB(219, 68, 103),
		TitleBarAccent = Color3.fromRGB(20,20,20),
		Overlay = Color3.fromRGB(219, 68, 103),
		Banner = Color3.fromRGB(20,20,20),
		BannerAccent = Color3.fromRGB(219, 68, 103),
		Content = Color3.fromRGB(219, 68, 103),
		Button = Color3.fromRGB(219, 68, 103),
		ButtonAccent = Color3.fromRGB(20,20,20),
		ChipSet = Color3.fromRGB(219, 68, 103),
		ChipSetAccent = Color3.fromRGB(20,20,20),
		DataTable = Color3.fromRGB(219, 68, 103),
		DataTableAccent = Color3.fromRGB(20,20,20),
		Slider = Color3.fromRGB(20,20,20),
		SliderAccent = Color3.fromRGB(219, 68, 103),
		Toggle = Color3.fromRGB(219, 68, 103),
		ToggleAccent = Color3.fromRGB(20,20,20),
		Dropdown = Color3.fromRGB(20,20,20),
		DropdownAccent = Color3.fromRGB(219, 68, 103),
		ColorPicker = Color3.fromRGB(20,20,20),
		ColorPickerAccent = Color3.fromRGB(219, 68, 103),
		TextField = Color3.fromRGB(219, 68, 103),
		TextFieldAccent = Color3.fromRGB(20,20,20),
	}
})

local Page1 = X.New({
	Title = "ESP"
})

local Page2 = X.New({
	Title = "Local Player"
})

local Page3 = X.New({
	Title = "Item Farm"
})

local Page4 = X.New({
	Title = "Coin Farm"
})

local CreditPage = X.New({
	Title = "Credits"
})

local ESPToggle = Page1.Toggle({
	Text = "ESP Toggle",
	Callback = function(Value)
		ESP:Toggle(Value)
	end,
	Enabled = false
})

local ColorPicker = Page1.ColorPicker({
	Text = "ESP Color",
	Default = Color3.fromRGB(255,170,0),
	Callback = function(Value)
        ESP.Color = Value
		print("RGB:", Value.R * 255, Value.G * 255, Value.B * 255)
	end,
})

local EspOptions = Page1.ChipSet({
	Callback = function(ChipSet)
		table.foreach(ChipSet, function(Option, Value)
			ESP[Option] = Value
		end)
	end,
	Options = {
        Players = true,
		Boxes = true,
        Names = true,
        Ores = false,
        Animals = false,
	}
})

local Health = Page2.Toggle({
	Text = "Auto Use Health Potion",
	Callback = function(Value)
			if Value then
				heal = true
				AutoHeal()
			else
				heal = false
			end
	end,
	Menu = {
		Information = function(self)
			X.Banner({
				Text = "Must have health potions to work!"
			})
		end
	},
	Enabled = false
})

local Thirst = Page2.Toggle({
	Text = "Auto Use Thirst Potion",
	Callback = function(Value)
			if Value then
				thirst = true
				AutoDrink()
			else
				thirst = false
			end
	end,
	Menu = {
		Information = function(self)
			X.Banner({
				Text = "Must have thirst potions to work!"
			})
		end
	},
	Enabled = false
})

local Hunger = Page2.Toggle({
	Text = "Auto Use Hunger Potion",
	Callback = function(Value)
			if Value then
				hunger = true
				AutoEat()
			else
				hunger = false
			end
	end,
	Menu = {
		Information = function(self)
			X.Banner({
				Text = "Must have hunger potions to work!"
			})
		end
	},
	Enabled = false
})

local WalkSpeed = Page2.Slider({
	Text = "WalkSpeed",
	Callback = function(Value)
		game.Players.LocalPlayer.Character.Humanoid.WalkSpeed = Value
	end,
	Min = 6,
	Max = 26,
	Def = 16
})

local JumpHeight = Page2.Slider({
	Text = "JumpHeight",
	Callback = function(Value)
		game.Players.LocalPlayer.Character.Humanoid.JumpPower = Value
	end,
	Min = 50,
	Max = 80,
	Def = 50
})

local HitBox = Page2.Slider({
	Text = "HitBox Expander (Only Works For Bow)",
	Callback = function(Value)
		for i, v in pairs(game.Players:GetPlayers()) do
			if v.Name ~= game.Players.LocalPlayer.Name then
				pcall(function()
					v.Character.HumanoidRootPart.Material = "Neon"
					v.Character.HumanoidRootPart.Size = Vector3.new(Value, Value, Value)
					v.Character.HumanoidRootPart.CanCollide = false
				end)
			end
		end
	end,
	Min = 1,
	Max = 100,
	Def = 1
})

local Transparency = Page2.Slider({
	Text = "Transparency",
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
	Def = 100
})

local Victim = Page2.Toggle({
	Text = "Kill Player",
	Callback = function(Value)
			if Value then
				KillingTime = true
				KillPlayers(PlayerChoice)
			else
				KillingTime = false
			end
	end,
	Enabled = false
})

local PlayerSelect = Page2.Dropdown({
	Text = "Choose a victim >:)",
	Callback = function(Value)
		PlayerChoice = Value
	end,
	Options = nil
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
	PlayerSelect:SetOptions(PTable)
end
game:GetService("Players").PlayerAdded:Connect(Update)
game:GetService("Players").PlayerRemoving:Connect(Update)
Update()

local Pickup = Page3.Toggle({
	Text = "Pickup Dropped Item",
	Callback = function(Value)
		if Value == true then
			Picking = true
			TeleportPlayerItems(TextChoice)
		else
			Picking = false
		end
	end,
	Enabled = false
})

ItemText = Page3.TextField({
	Text = "Type item name here",
	Callback = function(Value)
		print("Item:", Value)
		TextChoice = ItemText:GetText()
	end,
	Menu = {
		Information = function(self)
			X.Banner({
				Text = "Type in the items name you exactly as it shows in game. TIP: during meteor shower type Meteorite into pickup item, whenever someone mines some you will steal it!"
			})
		end
	}
})

local Stealing = Page3.Toggle({
	Text = "Steal Ores (Good for Meteorite)",
	Callback = function(Value)
		if Value == true then
			Steal = true
			StealOres()
		else
			Steal = false
		end
	end,
	Menu = {
		Information = function(self)
			X.Banner({
				Text = "Instead of mining ores yourself, select the ores you want and it will collect them when someone else mines it for you"
			})
		end
	},
	Enabled = false
})

local MineType = Page3.Toggle({
	Text = "Mine Whole Map",
	Callback = function(Value)
		if Value == true then
			MineMethod = game:GetService("ReplicatedStorage")["Render Folder"]
		else
			MineMethod = game:GetService("Workspace").Ores
		end
	end,
	Menu = {
		Information = function(self)
			X.Banner({
				Text = "Takes longer to pickup items but mines all ores in the game"
			})
		end
	},
	Enabled = false
})

local Mine = Page3.Toggle({
	Text = "Auto Mine",
	Callback = function(Value)
		if Value == true then
			Mining = true
			AutoMine()
		else
			Mining = false
		end
	end,
	Menu = {
		Information = function(self)
			X.Banner({
				Text = "Make sure to equip a tool first and clear some space in your backpack"
			})
		end
	},
	Enabled = false
})

local OreChips = Page3.ChipSet({
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
	Options = {
        Turquoise = false,
		Amethyst = false,
		Iron = false,
		Gold = false,
		Crystal = false,
		Ruby = false,
		Green_Quartz = false,
		Rhodonite = false,
		Sapphire = false,
		Titanium = false,
		Tanzanite = false,
		Jade = false,
		Apatite = false,
		Topaz = false,
		Obsidian = false,
		Fire_Opal = false,
		Meteorite = false,
		Coal = false,
		Small = false
	}
})
-- Coin Farm

local howto = Page4.Button({
	Text = "How to Setup                                                                 Click Here  ---->",
	Menu = {
		Information = function(self)
			X.Banner({
				Text = "First craft some fish traps and a market and then sit next to the market (YOU NEED TO BE A HIGH LEVEL FOR THIS, TO GAIN A LOT OF XP JUST MINE HIGH LEVEL ORES), how much money you make scales with how many traps you place down."
			})
		end
	}
})

local fish = Page4.Toggle({
	Text = "Start/Stop Farm",
	Callback = function(Value)
		if Value == true then
			fishing = true
			FishFarm()
		else
			fishing = false
		end
	end,
	Enabled = false
})

-- Credit --

local Credit1 = CreditPage.Button({
	Text = "Thank you Fungbert and Kiriot22 for your libs, and BazingaPog :)",
	Callback = function()
		print("Fungbert's sexy gui lib and Kiriot22's super easy ESP lib")
	end
})

local Credit2 = CreditPage.Button({
	Text = "This script was put together by Inaudible (Mookie#2003)",
})