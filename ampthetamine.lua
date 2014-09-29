--[[
  @Authors: Ukzz (Chemik)
  @ExAuthr: Ben Dol (benis), Alexandre Severino (kilouco)
  @Details: Otclient module that turns player to
            fuckuped amph person. Main code
            skelet was from candybot.
]]

Amphetamine = {}
Amphetamine.window = nil
Amphetamine.options = {}
Amphetamine.defaultOptions = {}

dofile('extensions/utils.lua')
dofile('classes/player_class.lua')
dofile('handlers/speak_handler.lua')

local enabled = false
local writeDir = "/amphetamine"

function init()
  pdmesg("Module amphetamine init")
  
  if not g_resources.directoryExists(writeDir) then
    g_resources.makeDir(writeDir)
  end
  
  SpeakHandler.init()
  
  connect(g_game, {
    onGameStart = Amphetamine.enable,
    onGameEnd = Amphetamine.disable,
    onTalk = SpeakHandler.processhandler
  })
  
  if g_game.isOnline() then
    Amphetamine.enable()
  end
end

function terminate()
  pdmesg("Module amphetamine terminate")
  
    SpeakHandler.terminate()
  
  disconnect(g_game, {
    onGameStart = Amphetamine.enable,
    onGameEnd = Amphetamine.disable,
    onTalk = SpeakHandler.processhandler
  })

  if g_game.isOnline() then
    Amphetamine.disable()
  end
end

function Amphetamine.enable()
  pdmesg("Amphetamine enables.")
  enabled = true
end

function Amphetamine.disable()
  pdmesg("Amphetamine disables.")
  enabled = false
end

function Amphetamine.isEnabled()
  return enabled
end

function Amphetamine.getWriteDir()
  return writeDir
end
