local indexSelecteduser = ListBox.GetSelected("LBX_UPDATED_USERS")[1];
local dataSelecteduser = ListBox.GetItemData("LBX_UPDATED_USERS", indexSelecteduser);

local mySQLConnection = dbConnect();
if mySQLConnection ~= nil then
	SQL = "SELECT * FROM IT_USERS WHERE ID = '"..dataSelecteduser.."';";
	mySQLCursor = mySQLConnection:execute(SQL);
	row = mySQLCursor:fetch({},"a")

	if row then
		while row do
			lastname = row.Lastname;
			firstname = row.Firstname;
			username = row.Username
			role = row.Role;
			if row.Sign_Check_List == "Y" then
				signCheckList ="Yes";
			else
				signCheckList ="No";
			end
			if row.Active == 1 then
				status = "Active";
			else
				status = "Disabled";
			end
			
			tblListboxProps = {};
			tblListboxProps.TooltipText = "*** Old configration : ***\r\n".."Lastname : "..lastname.."\r\n".."Firstname : "..firstname.."\r\n".."Username : "..username.."\r\n".."Role : "..role.."\r\n".."Sign check list : "..signCheckList.."\r\n".."Status : "..status.."\r\n";
			ListBox.SetProperties("LBX_UPDATED_USERS", tblListboxProps);

			row = mySQLCursor:fetch(row,"a");
		end
	end
end

	
local indexSelecteduser = ListBox.GetSelected("LBX_UPDATED_USERS")[1];
selectedUser = ListBox.GetItemText("LBX_UPDATED_USERS", indexSelecteduser);

Debug.Print("2. Modified Text_____________\r\n");	
for i,line in pairs(tblUpdatedUsersNewText) do
	Debug.Print(line.."\r\n");
	local indexUserDel = String.Find(line, "@", 1, true);
	local user = String.Left(line, indexUserDel-1);
	
	--local indexModifiedField = result = String.Find("", "?", 1, false);

	if selectedUser == user then
		Debug.Print("******"..selectedUser.."-"..user.."\r\n");
	end



	
end

