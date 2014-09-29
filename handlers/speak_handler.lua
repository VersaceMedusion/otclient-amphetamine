--[[
  @Authors: Ukzz (Chemik)
  @Details: Speak handler for module functionality.
]]

SpeakHandler = {}
SpeakHandler.settings = {
	enabled = true,
	runmode = 'superuser',
	routing = {
		private_route = true,
		default_route = false,
		dmesg_route = false,
	},
	replyies = {

	},
	_callbacks = {
		default = print;
	},
	_cache = {}
}

function SpeakHandler.init()
  --
end

function SpeakHandler.terminate()
  --
end

function SpeakHandler.processhandler(...)
	local argc, argv = #{...}, {...};
  local message_data = string.explode(argv[4], ' "')
	local messageText, messageParm = message_data[1], message_data[2]

  options = switch{
    ['help'] = function()   
        pdmesg("help switch option called!")
    end,
    default = function()    
      
    end
  }
  options:case(messageText)
end
