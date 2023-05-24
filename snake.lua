local Material = loadstring(game:HttpGet("https://raw.githubusercontent.com/Kinlei/MaterialLua/master/Module.lua"))()

local Plr = game.Players.LocalPlayer
local connections = {}
local function tp(part)
  part.CFrame = Plr.Character.HumanoidRootPart.CFrame
end

local function Connection(Type, Value)
  if Value then
    for i,v in pairs(Type:GetChildren()) do
      if v.ClassName ~= "MeshPart" then
        tp(v:WaitForChild("Part"))
      end
      tp(v)
    end
    connections[Type.Name] = Type.ChildAdded:Connect(function(part)
      if part.ClassName ~= "MeshPart" then
        tp(part:WaitForChild("Part"))
      end
      tp(part)
    end)
  else
    if connections[Type.Name] == nil then
      return
    end
    connections[Type.Name]:Disconnect()
  end
end

local X = Material.Load({
	Title = "Worm 2048 - Inaudible",
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

local Page2 = X.New({
	Title = "Other"
})

local AutoFarm2 = Page1.Toggle({
	Text = "2",
	Callback = function(Value)
    Connection(game.Workspace.CubeFolder.Cube_2, Value)
	end,
	Enabled = false
})

local AutoFarm4 = Page1.Toggle({
	Text = "4",
	Callback = function(Value)
    Connection(game.Workspace.CubeFolder.Cube_4, Value)
	end,
	Enabled = false
})

local AutoFarm8 = Page1.Toggle({
	Text = "8",
	Callback = function(Value)
    Connection(game.Workspace.CubeFolder.Cube_8, Value)
	end,
	Enabled = false
})

local AutoFarm16 = Page1.Toggle({
	Text = "16",
	Callback = function(Value)
    Connection(game.Workspace.CubeFolder.Cube_16, Value)
	end,
	Enabled = false
})

local AutoFarm32 = Page1.Toggle({
	Text = "32",
	Callback = function(Value)
    Connection(game.Workspace.CubeFolder.VipIsland.Cube_32, Value)
	end,
	Enabled = false
})

local AutoFarm64 = Page1.Toggle({
	Text = "64",
	Callback = function(Value)
    Connection(game.Workspace.CubeFolder.VipIsland.Cube_64, Value)
	end,
	Enabled = false
})

local AutoFarmLuck = Page1.Toggle({
	Text = "?",
	Callback = function(Value)
    Connection(game.Workspace.PropsFolder.LUCK_BLOCK, Value)
	end,
	Enabled = false
})

local DeleteWalls = Page2.Button({
	Text = "Delete Walls",
	Callback = function(Value)
    game.Workspace.VIPmap.Door:Destroy()
    game.Workspace.Hall.VipFunction:Destroy()
    for i,v in pairs(game.Workspace.Map.CenterPart:GetChildren()) do
      v.Transparency = 0.7
      v.CanCollide = false
    end
	end
})

local WalkSlider = Page2.Slider({
	Text = "Speed",
	Callback = function(Value)
		Plr.Character.Humanoid.WalkSpeed = Value
	end,
	Min = 0,
	Max = 400,
	Def = 16
})