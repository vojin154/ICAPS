
if InventoryChatAndPlayerStates_MenuKitRenderer_Hooked then
	return
else
	InventoryChatAndPlayerStates_MenuKitRenderer_Hooked = true
end

-- Called from MenuKitRenderer:open() (actually MenuLobbyRenderer:open()) for the local player, or
-- ConnectionNetworkHandler:lobby_info() for remote players (after they have been synchronized)
--[[local _set_player_slot_actual = MenuKitRenderer._set_player_slot
function MenuKitRenderer:_set_player_slot(nr, ...)
	if InventoryChatAndPlayerStates ~= nil then
		InventoryChatAndPlayerStates.PeerStates[nr] = InventoryChatAndPlayerStates.PeerStates[nr] or {}
	end
	_set_player_slot_actual(self, nr, ...)
end]]


Hooks:PreHook(MenuKitRenderer, "_set_player_slot", "_set_player_slot_icaps", function(self, nr, ...)
	if InventoryChatAndPlayerStates ~= nil then
		InventoryChatAndPlayerStates.PeerStates[nr] = InventoryChatAndPlayerStates.PeerStates[nr] or {}
	end
end)

-- Initialize the table for the host peer (when connecting as a client)
--[[local _entered_menu_actual = MenuKitRenderer._entered_menu
function MenuKitRenderer:_entered_menu(...)
	if InventoryChatAndPlayerStates ~= nil then
		for peer_id, __ in pairs(managers.network:session():peers()) do
			InventoryChatAndPlayerStates.PeerStates[peer_id] = InventoryChatAndPlayerStates.PeerStates[peer_id] or {}
		end
	end

	_entered_menu_actual(self, ...)
end]]


Hooks:PreHook(MenuKitRenderer, "_entered_menu", "_entered_menu_icaps", function(self, ...)
	if InventoryChatAndPlayerStates ~= nil then
		for peer_id, __ in pairs(managers.network:session():peers()) do
			InventoryChatAndPlayerStates.PeerStates[peer_id] = InventoryChatAndPlayerStates.PeerStates[peer_id] or {}
		end
	end
end)