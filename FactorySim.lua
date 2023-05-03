local Material = loadstring(game:HttpGet("https://raw.githubusercontent.com/Kinlei/MaterialLua/master/Module.lua"))()

local Plr = game.Players.LocalPlayer
local Plot
local Box
local Mining = false
local Item
local Closest
local WrldList = {
  Rock = "World",
  Tree = "World",
  CopperOre = "World",
  IronOre = "WorldT2",
  TitaniumOre = "WorldT3",
  UraniumOre = "WorldT3",
  ResiniteOre = "WorldT3",
  Diamond = "WorldT3",
  HardwoodTree = "WorldT2",
  TungstenOre = "WorldT4",
  BluemetalOre = "WorldT4",
  RedmetalOre = "WorldT4",
  LavaCrystal = "WorldT4",
  IceCrystal = "WorldT4",
  UltrawoodTree = "WorldT4",
  PetrifiedTree = "WorldT5",
  WeirdOre = "WorldT5",
  EnergyCrystal = "WorldT5",
  ShroomiteOre = "WorldT5",
  OsmiumOre = "WorldT5",
  SaltCrystal = "WorldT6",
  LeadOre = "WorldT6",
  SilverOre = "WorldT6",
  AmberniteOre = "WorldT6",
  TropicalTree = "WorldT6",
  DiabliumOre = "WorldT6",
  SanctiumOre = "WorldT6"
}

for i, plot in pairs(game.Workspace.Plots:GetChildren()) do
  if tostring(plot.Owner.Value) == game.Players.LocalPlayer.Name then
    Plot = plot
    break
  end
end

local function tp(part)
  Plr.Character.HumanoidRootPart.CFrame = part.CFrame
end

local function Farming(item, world)
  if Plr.Character:FindFirstChild("CarriedItem") then
    tp(Plot.PlacedObjects[Box].Input)
    wait(0.5)
    game:GetService("ReplicatedStorage").Events.Inventory.ContainerInteraction:FireServer(Plot.PlacedObjects[Box],false)
  end

  while Mining == true  do
    wait()
    for i,target in pairs(game.Workspace.Harvestable[world]:GetChildren()) do
      if Mining == false then break end
      if Plr.Character:FindFirstChild("CarriedItem") then
        if Plr.Character.CarriedItem.Handle.AmountGui.Amount.Text == "15" then
          tp(Plot.PlacedObjects[Box].Input)
          wait(0.5)
          game:GetService("ReplicatedStorage").Events.Inventory.ContainerInteraction:FireServer(Plot.PlacedObjects[Box],false)
        end
      end
  
      if target.Name == item then
        tp(target.Part)
        wait(.18)
        game:GetService("ReplicatedStorage").Events.Harvest.Harvest:FireServer(target)
        wait(.5)
        for i,v in pairs(Plot.Entities:GetChildren()) do
          if Closest == nil then
            Closest = v
          else
            if (Plr.Character.PrimaryPart.Position - v.Position).magnitude < (Closest.Position - Plr.Character.PrimaryPart.Position).magnitude then
              Closest = v
            end
        end
      end
        game:GetService("ReplicatedStorage").Events.Inventory.PickUp:FireServer(Closest)
        Closest = nil
      end
    end

  end
end

local X = Material.Load({
	Title = "Factory Sim Auto Farm - Inaudible",
	Style = 3,
	SizeX = 500,
	SizeY = 350,
	ColorOverrides = {
		MainFrame = Color3.fromRGB(20,20,20),
		Minimise = Color3.fromRGB(219, 210, 202),
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
		TextField = Color3.fromRGB(175,175,175),
		TextFieldAccent = Color3.fromRGB(20,20,20),
	}
})

local Page1 = X.New({
	Title = "Farm"
})

local AutoFarm = Page1.Toggle({
	Text = "Auto Farm",
	Callback = function(Value)
    Mining = Value
		Farming(Item, WrldList[Item])
	end,
	Enabled = false
})

local BoxType = Page1.Dropdown({
	Text = "Box Type",
	Callback = function(Value)
    Box = Value
	end,
	Options = {
		"BasicContainer",
    "SplitterContainer",
    "TripleSplitterContainer",
    "StackContainer"
	}
})

local Selection = Page1.Dropdown({
	Text = "Item Choice",
	Callback = function(Value)
    Item = Value
	end,
	Options = {
		"Rock",
    "Tree",
    "CopperOre",
    "HardwoodTree",
    "GoldOre",
		"IronOre",
    "SuperwoodTree",
    "ResiniteOre",
    "TitaniumOre",
    "Diamond",
    "UraniumOre",
    "TungstenOre",
    "BluemetalOre",
    "RedmetalOre",
    "LavaCrystal",
    "IceCrystal",
    "UltrawoodTree",
    "WeirdOre",
    "PetrifiedTree",
    "OsmiumOre",
    "ShroomiteOre",
    "EnergyCrystal",
    "SaltCrystal",
    "DiabliumOre",
    "SilverOre",
    "TropicalTree",
    "SanctiumOre",
    "AmberniteOre",
    "LeadOre"
	}
})


