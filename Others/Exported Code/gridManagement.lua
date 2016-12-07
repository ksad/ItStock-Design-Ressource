--Debug.ShowWindow(true);

local getLimitInPixel = PAGE_LIMIT_RATIO * Page.GetSize().Height / 100;

local gridWidth = Grid.GetSize("GD_USERS_LIST").Width;
local gridHeight = Grid.GetSize("GD_USERS_LIST").Height;
Debug.Print(gridWidth.."x"..gridHeight.."\r\n");


Grid.SetCellText("GD_USERS_LIST", 0, 0, "Lastname", true);
Grid.SetCellText("GD_USERS_LIST", 0, 1, "Firsname", true);
Grid.SetCellText("GD_USERS_LIST", 0, 2, "Username", true);
Grid.SetCellText("GD_USERS_LIST", 0, 3, "Role", true);
Grid.SetCellText("GD_USERS_LIST", 0, 4, "Sign check list", true);

local mySQLConnection = dbConnect();
if mySQLConnection ~= nil then
	mySQLCursor = mySQLConnection:execute("SELECT * FROM IT_USERS;");

	row = mySQLCursor:fetch({},"a")

	Grid.DeleteNonFixedRows("GD_USERS_LIST", true);
	rowHeight = 0;
	while row do
		
		username = row.Username;
		lastname = row.Lastname;
		firstname = row.Firstname;
		role = row.Role;
		signCheckList = row.Sign_Check_List;

		index = Grid.InsertRow("GD_USERS_LIST", -1, true);
		Grid.SetCellText("GD_USERS_LIST", index, 0, "Lorem Ipsum is simply dummy text of the printing and typesetting / of the printing and typesetting"..lastname, true);
		Grid.SetCellText("GD_USERS_LIST", index, 1, firstname, true);
		Grid.SetCellText("GD_USERS_LIST", index, 2, username, true);
		Grid.SetCellText("GD_USERS_LIST", index, 3, role, true);
		Grid.SetCellText("GD_USERS_LIST", index, 4, signCheckList, true);

		row = mySQLCursor:fetch(row,"a");
	end

	Grid.AutoSizeColumns("GD_USERS_LIST", GVS_BOTH, true);

	newGridHeight = Grid.GetRowHeight("GD_USERS_LIST", index)*Grid.GetRowCount("GD_USERS_LIST");
	Debug.Print(Grid.GetRowHeight("GD_USERS_LIST", index)*Grid.GetRowCount("GD_USERS_LIST").."\r\n");

	res0 = Grid.GetColumnWidth("GD_USERS_LIST", 0);
	res1 = Grid.GetColumnWidth("GD_USERS_LIST", 1);
	res2 = Grid.GetColumnWidth("GD_USERS_LIST", 2);
	res3 = Grid.GetColumnWidth("GD_USERS_LIST", 3);
	res4 = Grid.GetColumnWidth("GD_USERS_LIST", 4);

	res = res0+res1+res2+res3+res4;

	ratioRes0 = res0*100/res;
	ratioRes1 = res1*100/res;
	ratioRes2 = res2*100/res;
	ratioRes3 = res3*100/res;
	ratioRes4 = res4*100/res;

	Debug.Print("Width : "..res.."\r\n");
	Debug.Print("Colomn 0 : "..(res0).." -> "..(ratioRes0).."%\r\n");
	Debug.Print("Colomn 1 : "..(res1).." -> "..(ratioRes1).."%\r\n");
	Debug.Print("Colomn 2 : "..(res2).." -> "..(ratioRes2).."%\r\n");
	Debug.Print("Colomn 3 : "..(res3).." -> "..(ratioRes3).."%\r\n");
	Debug.Print("Colomn 4 : "..(res4).." -> "..(ratioRes4).."%\r\n");

	newColumnWidth0 = ratioRes0*gridWidth/100;
	newColumnWidth1 = ratioRes1*gridWidth/100;
	newColumnWidth2 = ratioRes2*gridWidth/100;
	newColumnWidth3 = ratioRes3*gridWidth/100;
	newColumnWidth4 = ratioRes4*gridWidth/100;

	Debug.Print("new Colum Width : "..newColumnWidth0.."\r\n");
	Debug.Print("new Colum Width : "..newColumnWidth1.."\r\n");
	Debug.Print("new Colum Width : "..newColumnWidth2.."\r\n");
	Debug.Print("new Colum Width : "..newColumnWidth3.."\r\n");
	Debug.Print("new Colum Width : "..newColumnWidth4.."\r\n");
	Debug.Print("Total New Width : "..(newColumnWidth0+newColumnWidth1+newColumnWidth2+newColumnWidth3+newColumnWidth4).."\r\n");

	Grid.SetColumnWidth("GD_USERS_LIST", 0, newColumnWidth0, true);
	Grid.SetColumnWidth("GD_USERS_LIST", 1, newColumnWidth1, true);
	Grid.SetColumnWidth("GD_USERS_LIST", 2, newColumnWidth2, true);
	Grid.SetColumnWidth("GD_USERS_LIST", 3, newColumnWidth3, true);
	Grid.SetColumnWidth("GD_USERS_LIST", 4, newColumnWidth4, true);

	if newGridHeight > Page.GetSize().Height - Grid.GetPos("GD_USERS_LIST").Y then
		Debug.Print("Toooo big");
		Grid.SetSize("GD_USERS_LIST", newColumnWidth0+newColumnWidth1+newColumnWidth2+newColumnWidth3+newColumnWidth4+18, Page.GetSize().Height - Grid.GetPos("GD_USERS_LIST").Y - getLimitInPixel);
	else
		Grid.SetSize("GD_USERS_LIST", newColumnWidth0+newColumnWidth1+newColumnWidth2+newColumnWidth3+newColumnWidth4+2, newGridHeight+4);
	end

	Grid.SetListMode("GD_USERS_LIST", true);
	Grid.SetSingleRowSelection("GD_USERS_LIST", true);

	mySQLCursor:close();
	mySQLConnection:close();
end