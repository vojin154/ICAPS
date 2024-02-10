
if InventoryChatAndPlayerStates_PlayerInventoryGui_Hooked then
	return
else
	InventoryChatAndPlayerStates_PlayerInventoryGui_Hooked = true
end

local init_actual = PlayerInventoryGui.init
function PlayerInventoryGui:init(...)
	init_actual(self, ...)

	if not MenuCallbackHandler:is_multiplayer() or not managers.network:session() then
		return
	end

	if not alive(self._panel) then
		return
	end
	local info_panel = self._panel:child("info_panel")
	if not alive(info_panel) then
		return
	end
	if self._multi_profile_item == nil then
		return
	end
	local basepanel = self._multi_profile_item._panel
	--local boxpanel = self._multi_profile_item._box_panel
	local column_one_box_panel = self._panel:child("column_one_box_panel")
	if not alive(basepanel) or not alive(column_one_box_panel) then --not alive(boxpanel)
		return
	end
	local current_bottom = basepanel:bottom()
	basepanel:set_bottom(column_one_box_panel:bottom() - (tweak_data.menu.pd2_small_font_size + 10))
	basepanel:set_right(column_one_box_panel:left() - 30)
	--boxpanel:set_bottom(boxpanel:bottom() - (current_bottom - basepanel:bottom())) wtf does this do?
end

local open_armor_menu_actual = PlayerInventoryGui.open_armor_menu
function PlayerInventoryGui:open_armor_menu(selected_tab, ...)
	open_armor_menu_actual(self, selected_tab, ...)

	--todo: move search box
end