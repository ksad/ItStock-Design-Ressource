if GRID_INITIALIZATION == 0 and Grid.GetCellState("GD_USERS_LIST", e_Row, e_Column).Fixed == false then
	if (String.CompareNoCase(e_OldText, e_NewText)) ~= 0 then
		if e_Column == 3 then
			local mySQLConnection = dbConnect();
			if mySQLConnection ~= nil then
				SQL = "SELECT DISTINCT(Role) FROM IT_USERS;";
				mySQLCursor = mySQLConnection:execute(SQL);
				row = mySQLCursor:fetch({},"a")

				tblRoleList ={};
				if row then
					while row do
						role = row.Role;
						Table.Insert(tblRoleList, Table.Count(tblRoleList)+1, role);
						row = mySQLCursor:fetch(row,"a");
					end
				else
					Table.Insert(tblRoleList, 1, "No role defined");
				end
				mySQLCursor:close();
				mySQLConnection:close();
			end

			for i,role in pairs(tblRoleList) do
				if e_NewText == role then
					Role = 1;
				else
					Role = 0;
				end
			end

			if Role == 0 then
				local selectedRole = Dialog.ComboBox("Select role", "Invalid data. Please select a valid role :", tblRoleList, "", false, false, MB_ICONSTOP);
				if selectedRole == "" or selectedRole == "CANCEL" then
					e_NewText = e_OldText;
					Grid.SetCellText("GD_USERS_LIST", e_Row, e_Column, e_NewText, true);
					Application.ExitScript();
				else
					if e_OldText == selectedRole then
						Grid.SetCellText("GD_USERS_LIST", e_Row, e_Column, e_OldText, true);
						Application.ExitScript();
					else
						e_NewText = selectedRole
						Grid.SetCellText("GD_USERS_LIST", e_Row, e_Column, selectedRole, true);
					end
				end
			end
		end

		if e_Column == 4 and (e_NewText ~= "Yes" and e_NewText ~= "No") then
			Dialog.Message("Error", "Invalid data.\r\n Allowed value : Yes/No", MB_OK, MB_ICONSTOP, MB_DEFBUTTON1);
			Grid.SetCellText("GD_USERS_LIST", e_Row, e_Column, e_OldText, true);
			Application.ExitScript();
		end

		if e_Column == 5 and (e_NewText ~= "Active" and e_NewText ~= "Disabled") then
			Dialog.Message("Error", "Invalid data.\r\n Allowed value : Active/Disabled", MB_OK, MB_ICONSTOP, MB_DEFBUTTON1);
			Grid.SetCellText("GD_USERS_LIST", e_Row, e_Column, e_OldText, true);
			Application.ExitScript();
		end
		local userAttrValue = DXML.GetAttribute("UpdatingUsers", "List/UpdatedUsers/User", "Username");

		if userAttrValue == '' then
			if e_Column == 2 then
				DXML.InsertXML("UpdatingUsers", "List/UpdatedUsers/User", '<User Username = "'..e_OldText..'" NewUsername = "'..e_NewText..'"></User>', XML.REPLACE);
			else
				DXML.InsertXML("UpdatingUsers", "List/UpdatedUsers/User", '<User Username = "'..thisUser..'" NewUsername = ""></User>', XML.REPLACE);
				DXML.InsertXML("UpdatingUsers", "List/UpdatedUsers/User/Field", '<Field Name="'..Grid.GetCellText("GD_USERS_LIST", 0, e_Column)..'" OldText="'..e_OldText..'" NewText="'..e_NewText..'"/>', XML.REPLACE);
			end
		else
			if e_Column == 2 then
				local nNodes = DXML.Count("UpdatingUsers", "List/UpdatedUsers", "User");
				for i=1,nNodes do
					local usernameAttrValue = DXML.GetAttribute("UpdatingUsers", "List/UpdatedUsers/User:"..i, "Username");
					local newUsernameAttrValue = DXML.GetAttribute("UpdatingUsers", "List/UpdatedUsers/User:"..i, "NewUsername");

					if e_OldText == usernameAttrValue or e_OldText == newUsernameAttrValue then
						checkUserExist = 1;
						nodeIndex = i;
						break;
					else
						checkUserExist = 0;
					end
				end
				if checkUserExist == 0 then
					DXML.InsertXML("UpdatingUsers", "List/UpdatedUsers/User", '<User Username = "'..e_OldText..'" NewUsername = "'..e_NewText..'"></User>', XML.INSERT_BEFORE);
				else
					DXML.SetAttribute("UpdatingUsers", "List/UpdatedUsers/User:"..nodeIndex, "NewUsername", e_NewText);
				end
			else
				local nNodes = DXML.Count("UpdatingUsers", "List/UpdatedUsers", "User");
				for i=1,nNodes do
					local usernameAttrValue = DXML.GetAttribute("UpdatingUsers", "List/UpdatedUsers/User:"..i, "Username");
					local newUsernameAttrValue = DXML.GetAttribute("UpdatingUsers", "List/UpdatedUsers/User:"..i, "NewUsername");
					if thisUser == usernameAttrValue or thisUser == newUsernameAttrValue then
						checkUserExist = 1;
						nodeIndex = i;
						break;
					else
						checkUserExist = 0;
					end
				end
				if checkUserExist == 0 then
					DXML.InsertXML("UpdatingUsers", "List/UpdatedUsers/User", '<User Username = "'..thisUser..'"><Field Name="'..Grid.GetCellText("GD_USERS_LIST", 0, e_Column)..'" OldText="'..e_OldText..'" NewText="'..e_NewText..'"/></User>', XML.INSERT_BEFORE);
				else
					DXML.InsertXML("UpdatingUsers", "List/UpdatedUsers/User:"..nodeIndex.."/Field", '<Field Name="'..Grid.GetCellText("GD_USERS_LIST", 0, e_Column)..'" OldText="'..e_OldText..'" NewText="'..e_NewText..'"/>', XML.INSERT_BEFORE);
				end
			end
		end
		XML.Save("AutoPlay\\Docs\\new_xml.xml");
	end

	Image.SetVisible("IMG_ACCORDION1", false);
	Image.SetVisible("IMG_TOGGLE_DOWN1", false);
	Input.SetVisible("IN_SEARCH_USER", false);
	Image.SetVisible("IMG_SAVE_MODIFICATION", true);
	Image.SetVisible("IMG_CANCEL_UPDATE", true);

	tbCellProps = {};
	tbCellProps.FaceName = "Nunito"
	tbCellProps.Height = 14;
	tbCellProps.Weight = FW_BOLD;
	tbCellProps.Italic = true
	local nCols = Grid.GetColumnCount("GD_USERS_LIST");
	for i = 0, nCols do
		Grid.SetCellFont("GD_USERS_LIST", e_Row, i, tbCellProps, true);
		Grid.SetCellColors("GD_USERS_LIST", e_Row, i, {Background=16777215,Text=Math.HexColorToNumber("FF0000")}, true);
	end
end