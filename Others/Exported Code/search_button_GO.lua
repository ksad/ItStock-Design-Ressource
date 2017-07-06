local searchText = Input.GetText("IN_SEARCH_USER");

local usersListColumnsName = {"Lastname", "Firstname", "Username", "Role"}
initList("GD_USERS_LIST", usersListColumnsName)

local mySQLConnection = dbConnect();
if mySQLConnection ~= nil then

	if String.Find(searchText, "Search by", 1, false) == -1 then
		if searchText == "" then
			SQL = "SELECT * FROM IT_USERS;";
			mySQLCursor = mySQLConnection:execute(SQL);
			row = mySQLCursor:fetch({},"a")
		else
			for i,j in pairs (usersListColumnsName) do
				SQL = "SELECT * FROM IT_USERS WHERE "..j.." LIKE '%"..searchText.."%';";
				mySQLCursor = mySQLConnection:execute(SQL);
				row = mySQLCursor:fetch({},"a")
				if row then
					break;
				end
			end
		end

		Grid.DeleteNonFixedRows("GD_USERS_LIST", true);
		if not row then
			Grid.SetGridLines("GD_USERS_LIST", GVL_HORZ);
			index = Grid.InsertRow("GD_USERS_LIST", -1, true);
			Grid.SetCellText("GD_USERS_LIST", index, 0, "No result", true);
		else
			while row do
				username = row.Username;
				lastname = row.Lastname;
				firstname = row.Firstname;
				role = row.Role;
				signCheckList = row.Sign_Check_List;

				index = Grid.InsertRow("GD_USERS_LIST", -1, true);
				Grid.SetCellText("GD_USERS_LIST", index, 0, lastname, true);
				Grid.SetCellText("GD_USERS_LIST", index, 1, firstname, true);
				Grid.SetCellText("GD_USERS_LIST", index, 2, username, true);
				Grid.SetCellText("GD_USERS_LIST", index, 3, role, true);
				Grid.SetCellText("GD_USERS_LIST", index, 4, signCheckList, true);

				row = mySQLCursor:fetch(row,"a");
			end
		end

		resizeList("GD_USERS_LIST");
		mySQLCursor:close();
		mySQLConnection:close();
	end
end

-- Code pour afficher listbox pour l'auto complétiion
	--[[Grid.SetGridLines("GD_USERS_LIST", GVL_HORZ);
					index = Grid.InsertRow("GD_USERS_LIST", -1, true);
					Grid.SetCellText("GD_USERS_LIST", index, 0, "No result", true);
				else]]
--[[ListBox.SetVisible("ListBox1", true);
local searchText = Input.GetText("IN_SEARCH_USER");

local usersListColumnsName = {"Lastname", "Firstname", "Username", "Role", "Sign_Check_List"}
initList("GD_USERS_LIST", usersListColumnsName)

local mySQLConnection = dbConnect();
if mySQLConnection ~= nil then
	ListBox.DeleteItem("ListBox1", -1);
	if String.Find(searchText, "Search by", 1, false) == -1 then
		if searchText == "" then
			ListBox.SetVisible("ListBox1", false);
		else
			for i,j in pairs (usersListColumnsName) do
				SQL = "SELECT * FROM IT_USERS WHERE "..j.." LIKE '%"..searchText.."%';";
				mySQLCursor = mySQLConnection:execute(SQL);
				row = mySQLCursor:fetch({},"a")
				if row then
					while row do
						username = row.Username;
						lastname = row.Lastname;
						firstname = row.Firstname;
						role = row.Role;
						signCheckList = row.Sign_Check_List;
						
						index = ListBox.AddItem("ListBox1", firstname.." "..lastname.." ("..username.." / "..role..")", row.ID);				
						
						row = mySQLCursor:fetch(row,"a");
					end
				end
				
			end
		end

		mySQLCursor:close();
		mySQLConnection:close();
	end
end]]