local Canvas = workspace:WaitForChild("Billboard")["BillboardGUI"]["Canvas"]
local HTTP = game:GetService("HttpService")
local pixelSize = UDim2.new(0, 2, 0, 2)

local SERVER = "http://0.0.0.0/"
local AUTH = ""

function Render(Input)
    local Height = #Input

    for RowIndex = 1, Height do
        local frame = Instance.new("Frame")
        frame.BackgroundTransparency = 1
        frame.Size = UDim2.new(1, 0, 0, 1)
        frame.BorderSizePixel = 0
        frame.BorderColor3 = Color3.new(0, 0, 0)
        frame.Position = UDim2.new(0, -1, 0, RowIndex * pixelSize.Y.Offset)
        frame.AutoLocalize = false
        frame.Name = "0"
        frame.ZIndex = 0
        frame.Visible = false
        frame.Parent = Canvas

        for ColumnIndex = 1, #Input[RowIndex] do
            task.spawn(
                function()
                    local Pixel = Instance.new("Frame")

                    Pixel.BackgroundTransparency = 1 - Input[RowIndex][ColumnIndex][4] / 255 --Input[RowIndex][ColumnIndex][4] = Opacity, RGB'A' terms
                    Pixel.BackgroundColor3 =
                        Color3.fromRGB(
                        Input[RowIndex][ColumnIndex][1],
                        Input[RowIndex][ColumnIndex][2],
                        Input[RowIndex][ColumnIndex][3]
                    )
                    Pixel.BorderSizePixel = 0
                    Pixel.BorderColor3 = Color3.new(0, 0, 0)
                    Pixel.Size = pixelSize
                    Pixel.Position = UDim2.new(0, ColumnIndex * pixelSize.X.Offset, 0, 0)
                    Pixel.Name = "0"
                    Pixel.AutoLocalize = false
                    Pixel.ZIndex = 0
                    Pixel.Parent = frame

                    Pixel = nil
                    Input[RowIndex][ColumnIndex] = nil
                end
            )
        end

        frame = nil
        Input[RowIndex] = nil
        task.wait()
    end

    Height = nil
    for _, frame in pairs(Canvas:GetChildren()) do
        frame.Visible = true
        frame = nil
    end
end

function ClearCanvas()
    for _, child in pairs(Canvas:GetChildren()) do
        child:Destroy()
        child = nil
    end
end
function SizeCanvas(y, x)
    Canvas.Size = UDim2.new(0, x * math.floor(pixelSize.X.Offset), 0, y * math.floor(pixelSize.Y.Offset))
    y = nil
    x = nil
end

function Begin(url)
    local URL = SERVER .. "?src=" .. url
    local RESPONSE
    local Success, Error = pcall(
        function()
            RESPONSE = HTTP:GetAsync(URL, true, {authorization = AUTH})
        end
    )

    if Success then
        RESPONSE = HTTP:JSONDecode(RESPONSE)

        ClearCanvas()
        SizeCanvas(#RESPONSE, #RESPONSE[1])
        task.spawn(function()
			Render(RESPONSE)
		end)
		Response = nil
    else
        error(Error)
		
		Response = nil
		Success = nil
		Error = nil
    end
end
