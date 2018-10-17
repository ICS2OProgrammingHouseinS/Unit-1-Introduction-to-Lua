-----------------------------------------------------------------------------------------
-- Title: NumericTextFields
-- Name: Housein Shaib
-- Course: ICS2O
-- This program displays a numeric text field where the user can enter their answer for a
-- addition, subtraction, or multiplication math question
-----------------------------------------------------------------------------------------

-- Hides the status bar
display.setStatusBar(display.HiddenStatusBar)

-- Sets the background colour
display.setDefault("background", 0/255, 220/255, 200/255)

-----------------------------------------------------------------------------------------
-- LOCAL VARIBLES
-----------------------------------------------------------------------------------------

-- Create local varibles
local questionObject
local correctObject
local incorrectObject
local numericField
local randomNumber1
local randomNumber2
local userAnswer
local correctAnswer
local randomOperator

-----------------------------------------------------------------------------------------
-- LOCAL FUNCTIONS
-----------------------------------------------------------------------------------------

local function AskQuestion()
	-- Generate 2 random numbers between a max and a min number
	randomNumber1 = math.random(10, 20)
	randomNumber2 = math.random(10, 20)
	randomOperator = math.random(1, 3)

	-- Create question in text object and sets the value of correctAnswer
	if (randomOperator == 1) then
	correctAnswer = randomNumber1 + randomNumber2
	questionObject.text = randomNumber1 .. "+" .. randomNumber2 .. "="
	elseif (randomOperator == 2) then
	correctAnswer = randomNumber1 - randomNumber2
	questionObject.text = randomNumber1 .. "-" .. randomNumber2 .. "="
	else
	correctAnswer = randomNumber1 * randomNumber2
	questionObject.text = randomNumber1 .. "x" .. randomNumber2 .. "="
end
end

local function HideCorrect()
	correctObject.isVisible = false
	AskQuestion()
end

local function HideIncorrect()
	incorrectObject.isVisible = false
	AskQuestion()
end
local function NumericFieldListener(event)

	-- User begins editing "numericField"
	if (event.phase == "began") then

		-- Clear text field
		event.target.text = ""

	elseif event.phase == "submitted" then

			-- When answer is submitted (enter key is presed) set user input to user's answer
			userAnswer = tonumber(event.target.text)

			-- If the user's answer and the correct answer are the same or different:
			if (userAnswer == correctAnswer) then
				correctObject.isVisible = true
				timer.performWithDelay(2000, HideCorrect)
			else
				incorrectObject.isVisible = true
				timer.performWithDelay(2000, HideIncorrect)
			end
	end
end

-----------------------------------------------------------------------------------------
-- OBJECT CREATION
-----------------------------------------------------------------------------------------

-- Displays a question and sets the colour
questionObject = display.newText("", display.contentWidth/3, display.contentHeight/2, nil, 50)
questionObject.x = display.contentWidth/2
questionObject:setTextColor(155/255, 42/255, 198/255)

-- Create the correct text object and make it invisible
correctObject = display.newText("Correct!", display.contentWidth/2, display.contentHeight*2/3, nil, 50)
correctObject:setTextColor(0/255, 0/255, 0/255)
correctObject.isVisible = false

-- Create the incorrect text object and make it invisible
incorrectObject = display.newText("Incorrect", display.contentWidth/2, display.contentHeight*2/3, nil, 50)
incorrectObject:setTextColor(150/255, 0/255, 255/255)
incorrectObject.isVisible = false

-- Create numeric field
numericField = native.newTextField(display.contentWidth/2, display.contentHeight/2, 150, 80)
numericField.xScale = 1.5
numericField.x = display.contentWidth/2
numericField.y = 500
numericField.inputType = "number"

-- Add the event listener for numeric fiel
numericField:addEventListener("userInput", NumericFieldListener)

-----------------------------------------------------------------------------------------
-- FUNCTION CALLS
-----------------------------------------------------------------------------------------

-- Call the function to ask the question
AskQuestion()