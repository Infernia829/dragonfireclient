-- CSM death formspec. Only used when clientside modding is enabled, otherwise
-- handled by the engine.

core.register_on_death(function()
	core.display_chat_message("You died.")
	local formspec = "size[11,5.5]bgcolor[#320000b4;true]" ..
		"label[4.85,1.35;" .. fgettext("You died") ..
		"]button_exit[2,3;3,0.5;btn_respawn;".. fgettext("Respawn") ..
		"]button_exit[6,3;3,0.5;btn_ghost_mode;".. fgettext("Ghost Mode") .."]"
	core.show_formspec("bultin:death", formspec)
end)

core.register_on_formspec_input(function(formname, fields)
	if formname == "bultin:death" then
		if fields.btn_ghost_mode then
			core.display_chat_message("You are in ghost mode. Use .respawn to Respawn")
		else
			core.send_respawn()
		end
	end
end)

core.register_chatcommand("respawn", {
	description = core.gettext("Respawn when in ghost mode"),
	func = function()
		if core.localplayer:get_hp() == 0 then
			core.send_respawn()
			core.display_chat_message("Respawned.")
		else
			core.display_chat_message("You are not in ghost mode.")
		end
	end
})
