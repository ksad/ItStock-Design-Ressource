Debug.ShowWindow(true);
Debug.Print(GRID_INITIALIZATION.."___");

if GRID_INITIALIZATION == 0 and Grid.GetCellState("GD_USERS_LIST", e_Row, e_Column).Fixed == false then
	Image.SetVisible("IMG_ACCORDION1", false);
	Image.SetVisible("IMG_TOGGLE_DOWN1", false);
	Input.SetVisible("IN_SEARCH_USER", false);
	Image.SetVisible("IMG_SAVE_MODIFICATION", true);

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