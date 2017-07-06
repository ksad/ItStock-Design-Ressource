Debug.ShowWindow(true);
Debug.Print(e_Row.."."..e_Column.."\r\n");

posX= 0;
Debug.Print("n_Cols : "..Grid.GetColumnCount("GD_USERS_LIST"));
for i=0, Grid.GetColumnCount("GD_USERS_LIST")-2 do
	W = Grid.GetColumnWidth("GD_USERS_LIST", i);
	Debug.Print("  ->  Width : "..W);
	posX = posX + W;
	Debug.Print("posX = "..posX.."\r\n");
end

posY = 0;
Debug.Print("n_Rows : "..e_Row);
for i=1, e_Row do
	H = Grid.GetRowHeight("GD_USERS_LIST", i);
	Debug.Print("  ->  Height : "..H);
	posY = posY + H;
	Debug.Print("posY = "..posY.."\r\n");
end


-- ComboBox object properties table.
tblComboProps = {};
tblComboProps.FontName = "Arial";
tblComboProps.FontSize = 12;
tblComboProps.FontItalic = false;
tblComboProps.FontStrikeout = false;
tblComboProps.FontAntiAlias = true;
tblComboProps.FontWeight = FW_NORMAL;
tblComboProps.FontUnderline = false;
tblComboProps.FontScript = ANSI_CHARSET;
tblComboProps.TextColor = Math.HexColorToNumber("000000");
tblComboProps.ComboStyle = DROPDOWN_LIST;
tblComboProps.ReadOrder = READ_STANDARD;
tblComboProps.LinesToDisplay = 4;
tblComboProps.Sort = false;
tblComboProps.BackgroundColor = Math.HexColorToNumber("FFFFFF");
tblComboProps.Enabled = true;
tblComboProps.Visible = true;
tblComboProps.ResizeLeft = false;
tblComboProps.ResizeRight = false;
tblComboProps.ResizeTop = false;
tblComboProps.ResizeBottom = false;
tblComboProps.TooltipText = "Please select an action";

tblComboProps.X = Grid.GetPos("GD_USERS_LIST").X+posX;
tblComboProps.Y = Grid.GetPos("GD_USERS_LIST").Y+posY;
Debug.Print(Grid.GetPos("GD_USERS_LIST").X+posX..","..Grid.GetPos("GD_USERS_LIST").Y+posY.."\r\n");

tblComboProps.Height = 25;
tblComboProps.Width = 65;
Page.CreateObject(OBJECT_COMBOBOX, "CB_ACTION", tblComboProps);

if ComboBox.IsVisible("CB_ACTION") then
	Grid.SetVisible("GD_USERS_LIST", false);
	Debug.Print("Yes -> "..ComboBox.GetPos("CB_ACTION").X..","..ComboBox.GetPos("CB_ACTION").Y.."\r\n");
end
