xmlUpdatedusers = '<ROOT>\r\n'..xmlUpdatedusers..'</ROOT>';
TextFile.WriteFromString("AutoPlay\\Docs\\grid_export.xml", xmlUpdatedusers, false);


local mySQLConnection = dbConnect();
if mySQLConnection ~= nil then
	SQL = "SELECT DISTINCT(Role) FROM IT_Stock_Manager.IT_USERS;";
	mySQLCursor = mySQLConnection:execute(SQL);
	row = mySQLCursor:fetch({},"a")

	if row then
		while row do
			role = row.Role;
			local checkExistItem = ComboBox.FindItem("CB_ROLE", 1, LB_BYTEXT, role);
			if checkExistItem == -1 then
				ComboBox.AddItem("CB_ROLE", role, "");
			end
			row = mySQLCursor:fetch(row,"a");
		end
	else
		ComboBox.AddItem("CB_ROLE", "No role defined", "");
	end

	for i,j in pairs(tblListUpdatedUsers) do
		local checkIfItemExist = ListBox.FindItem("LBX_UPDATED_USERS", -1, LB_BYTEXT, j);
		if checkIfItemExist == -1 then
			SQL = "SELECT ID FROM IT_USERS WHERE Username = '"..j.."';";
			mySQLCursor2 = mySQLConnection:execute(SQL);
			row = mySQLCursor2:fetch({},"a")
		
			if row then
				while row do
					userId = row.ID;
					local index = ListBox.AddItem("LBX_UPDATED_USERS", j, "");
					ListBox.SetItemData("LBX_UPDATED_USERS", index, userId);
					row = mySQLCursor:fetch(row,"a");
				end
			end
		end
	end
	
	mySQLCursor:close();
	mySQLConnection:close();
end

ListBox.SelectItem("LBX_UPDATED_USERS", 1);

