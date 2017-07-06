PROJEJCT_PAGE_WIDTH = 1366;
PROJECT_PAGE_HEIGHT = 768;
MENU_TREE_INDEXS = {Home="1", Settings="2", Users= "2.1", NONE=""}
SAVE_XML = false;
PAGE_LIMIT_RATIO = 2;

function dbConnect ()
	require("AutoPlay\\htdocs\\sources\\pg_database");
	if File.DoesExist("AutoPlay\\htdocs\\database\\db_access.enc") then
		local serverStatus = checkSQLServerStatus();

		if String.Left(serverStatus , 3) ~= "[4]" then
			errorMsg = String.Mid(serverStatus, 4, -1);
			local userAction = Dialog.Message("Notice", errorMsg.."\r\n".."Would you like to change your configurattion ?", MB_YESNO, MB_ICONINFORMATION, MB_DEFBUTTON1);
			if userAction == IDYES then
				local userAction = DialogEx.Show("DB_CONFIG", true, nil, nil);
				if userAction == 2 then
					Application.ExitScript();
				end
			else
				Application.ExitScript();
			end
		end
	else
		Dialog.TimedMessage("Error coonection", "Your Database is not configured properly. Please check your configuration ...", 5000, MB_ICONSTOP);
		local userAction = DialogEx.Show("DB_CONFIG", true, nil, nil);
		if userAction == 2 then
			Application.ExitScript();
		end
	end

	return MySQLConnection
end

function loadDefaultLanguage ()
	local lang = Application.LoadValue("ITStock", "LANG");
	if lang == "fr_FR" then
		RadioButton.SetChecked("RD_FR", true);
		Image.Load("IMG_FLAG", "AutoPlay\\htdocs\\images\\icons\\fr_FR.png");
	else
		RadioButton.SetChecked("RD_UK", true);
		Image.Load("IMG_FLAG", "AutoPlay\\htdocs\\images\\icons\\en_UK.png");
	end
end

function loadPageHeader ()
	Label.SetText("LB_HELLO", "Hello "..CURRENT_USER);
	Label.SetText("LB_IP", "@IP : "..System.GetLANInfo().IP);
	Label.SetText("LB_DATE_TIME", System.GetTime(TIME_FMT_MIL).." "..System.GetDate(DATE_FMT_EUROPE));
	Page.StartTimer(1000, 2);
end

function xmlDataPagesSetup (currentPage)
	if SAVE_XML == true then
		saveXmlData();
		Page.Navigate(PAGE_NEXT);
	else
		if Application.LoadValue("ITStock", "FirstRun") == "Y" then
			Window.Maximize(Application.GetWndHandle());
			setObjectsSizeAndPositions(currentPage);
			Window.Hide(Application.GetWndHandle());
			Page.Navigate(PAGE_NEXT);
		else
			local windowLoadingHandle = Application.LoadValue("Loading", "windowHandle");
			Window.Close(windowLoadingHandle, CLOSEWND_TERMINATE);
			Window.Maximize(Application.GetWndHandle());
		end
	end
end

function xmlDataPagesLoad (currentPage)
	if SAVE_XML == true then
		saveXmlData();
		Page.Navigate(PAGE_NEXT);
	else
		if Application.LoadValue("ITStock", "FirstRun") == "Y" then
			setObjectsSizeAndPositions(currentPage);
			local allPages = Application.GetPages();
			local nCount = Table.Count(allPages);
			if allPages[nCount] == currentPage then
				Application.SaveValue("ITStock", "FirstRun", "N");
				Page.Navigate(PAGE_FIRST);
			else
				Page.Navigate(PAGE_NEXT);
			end
		end
	end
end

--[[
	This function allow to jump from keft menu on each page to a specific page
	Usage : Each element added in the tree list should have Data = Page name in (MAJ)
	Example : Settings -> Data = SETTINGS
]]
function leftMenuJump ()
	local SelectedMenu = Tree.GetSelectedNode("TR_MENU");

	if SelectedMenu == "" then
		Application.ExitScript();
	end

	nodeMenuProperties = Tree.GetNode("TR_MENU", SelectedMenu);

	if Application.GetCurrentPage() == nodeMenuProperties.Data then
		Application.ExitScript();
	else
		Page.Jump(nodeMenuProperties.Data);
	end
end

function setUserCreateForm (currentObject)
	objectList = DialogEx.EnumerateObjects();

	for i, object in pairs(objectList) do
		objectType = DialogEx.GetObjectType(object);

		if object == currentObject then
			local objectText = Input.GetText(object);
			if objectText == "Firstname" or objectText == "Username" or objectText == "Lastname" or objectText == "Password" then
				Input.SetText(currentObject, "");
			else
				Input.SetSelection(currentObject, 1, -1);
			end
			Image.Load(String.Replace(currentObject, "IN", "IMG", false), "AutoPlay\\htdocs\\images\\inputs\\input_selected.png");
		else
			if objectType == 3 and String.Find(object, "UCF", 1, false) ~= -1 then -- UCF = User Create Form
				Image.Load(object, "AutoPlay\\htdocs\\images\\inputs\\input.png");
			end

			if objectType == 7 and Input.GetText(object) == "" then
				if String.Find(object, "FIRSTNAME", 1, false) ~= -1 then
					Input.SetText(object, "Firstname");
				elseif String.Find(object, "USERNAME", 1, false) ~= -1 then
					Input.SetText(object, "Username");
				elseif String.Find(object, "LASTNAME", 1, false) ~= -1 then
					Input.SetText(object, "Lastname");
				elseif String.Find(object, "PASSWORD", 1, false) ~= -1 then
					Input.SetText(object, "Password");
				else
					Input.SetText(object, "...");
				end
			end

			if ComboBox.GetSelected("CB_ROLE") == 1 then
				ComboBox.SetItemText("CB_ROLE", 1, "Role");
				ComboBox.SetSelected("CB_ROLE", 1);
			end

			tblLabelProps = {};
			tblLabelProps.ColorNormal = Math.HexColorToNumber("FFFFFF");
			tblLabelProps.ColorDown = Math.HexColorToNumber("FFFFFF");
			tblLabelProps.ColorHighlight = Math.HexColorToNumber("FFFFFF");
			tblLabelProps.ColorDisabled = Math.HexColorToNumber("FFFFFF");
			Label.SetProperties("LB_SIGN", tblLabelProps);
		end
	end
end

function PopUp (Status, showLoading)
	if showLoading ~= 'NoLoading' then
		ShowLoading = DialogEx.Show("LOADING", true, nil, nil);
	end

	--if ShowLoading == 0 then
		if Status == "1" then
			DialogEx.Show("SUCCESS", true, nil, nil);
		else
			DialogEx.Show("FAILED", true, nil, nil);
		end
	--else
	--	Application.ExitScript();
	--end
end

function setObjectsSizeAndPositions (pageName)
	PAGEWIDTH = Page.GetSize().Width;
	PAGEHEIGHT = Page.GetSize().Height;
	
	XML.Load("AutoPlay\\htdocs\\xml data\\pages_config\\xml_data_"..pageName..".xml");
	
	error = Application.GetLastError();
	if (error ~= XML.OK) then
	    Dialog.Message("Error", _tblErrorMessages[error]);
	end
	
	allObjects = Page.EnumerateObjects();
	
	for i, object in pairs(allObjects) do
		local objectType = Page.GetObjectType(object);
		perWidth = String.ToNumber(XML.GetValue("ROOT/PAGE/"..object.."/perWidth"));
		perHeight = String.ToNumber(XML.GetValue("ROOT/PAGE/"..object.."/perHeight"));	
		NewWidth = (perWidth*PAGEWIDTH)/100;
		NewHeight = (perHeight*PAGEHEIGHT)/100;
		
		perX = String.ToNumber(XML.GetValue("ROOT/PAGE/"..object.."/perPosX"));
		perY = String.ToNumber(XML.GetValue("ROOT/PAGE/"..object.."/perPosY"));
		NewX = (perX*PAGEWIDTH)/100
		NewY = (perY*PAGEHEIGHT)/100

		if objectType ==0 then
			Button.SetSize(object, NewWidth, NewHeight);
			Button.SetPos(object, NewX, NewY);
		elseif objectType ==1 then
			Label.SetSize(object, NewWidth, NewHeight);
			Label.SetPos(object, NewX, NewY);
		elseif objectType ==2 then
			Paragraph.SetSize(object, NewWidth, NewHeight);
			Paragraph.SetPos(object, NewX, NewY);
		elseif objectType ==3 then
			Image.SetSize(object, NewWidth, NewHeight);
			Image.SetPos(object, NewX, NewY);
		elseif objectType ==4 then
			Flash.SetSize(object, NewWidth, NewHeight);
			Flash.SetPos(object, NewX, NewY);
		elseif objectType ==5 then
			Video.SetSize(object, NewWidth, NewHeight);
			Video.SetPos(object, NewX, NewY);
		elseif objectType ==6 then
			Web.SetSize(object, NewWidth, NewHeight);
			Web.SetPos(object, NewX, NewY);
		elseif objectType ==7 then
			perFont = String.ToNumber(XML.GetValue("ROOT/PAGE/"..object.."/perFontSize"));
			newFontSize = (perFont*PAGEWIDTH)/100;
			tblInputProps = {};
			tblInputProps.FontSize = Math.Round(newFontSize, 0);
			tblInputProps.Height = NewHeight;
			tblInputProps.Width = NewWidth;
			tblInputProps.X = NewX;
			tblInputProps.Y = NewY;
			Input.SetProperties(object, tblInputProps);
		elseif objectType ==8 then
			Hotspot.SetSize(object, NewWidth, NewHeight);
			Hotspot.SetPos(object, NewX, NewY);
		elseif objectType ==9 then
			perFont = String.ToNumber(XML.GetValue("ROOT/PAGE/"..object.."/perFontSize"));
			newFontSize = (perFont*PAGEWIDTH)/100;
			tblListBoxProps = {};
			tblListBoxProps.FontSize = Math.Round(newFontSize, 0);
			tblListBoxProps.Height = NewHeight;
			tblListBoxProps.Width = NewWidth;
			tblListBoxProps.X = NewX;
			tblListBoxProps.Y = NewY;
			ListBox.SetProperties(object, tblListBoxProps);
		elseif objectType ==10 then
			ComboBox.SetSize(object, NewWidth, NewHeight);
			ComboBox.SetPos(object, NewX, NewY);
		elseif objectType ==11 then
			Progress.SetSize(object, NewWidth, NewHeight);
			Progress.SetPos(object, NewX, NewY);
		elseif objectType ==12 then
			Tree.SetSize(object, NewWidth, NewHeight);
			Tree.SetPos(object, NewX, NewY);
		elseif objectType ==13 then
			RadioButton.SetSize(object, NewWidth, NewHeight);
			RadioButton.SetPos(object, NewX, NewY);
		elseif objectType ==14 then
			RichText.SetSize(object, NewWidth, NewHeight);
			RichText.SetPos(object, NewX, NewY);
		elseif objectType ==15 then
			perFont = String.ToNumber(XML.GetValue("ROOT/PAGE/"..object.."/perFontSize"));
			newFontSize = (perFont*PAGEWIDTH)/100;
			tblCheckBoxProps = {};
			tblCheckBoxProps.FontSize = Math.Round(newFontSize, 0);
			tblCheckBoxProps.Height = NewHeight;
			tblCheckBoxProps.Width = NewWidth;
			tblCheckBoxProps.X = NewX;
			tblCheckBoxProps.Y = NewY;
			CheckBox.SetProperties(object, tblCheckBoxProps);
		elseif objectType ==16 then
			SlideShow.SetSize(object, NewWidth, NewHeight);
			SlideShow.SetPos(object, NewX, NewY);
		elseif objectType ==17 then
			Grid.SetSize(object, NewWidth, NewHeight);
			Grid.SetPos(object, NewX, NewY);
		elseif objectType ==18 then
			PDF.SetSize(object, NewWidth, NewHeight);
			PDF.SetPos(object, NewX, NewY);
		elseif objectType ==19 then
			QuickTime.SetSize(object, NewWidth, NewHeight);
			QuickTime.SetPos(object, NewX, NewY);
		elseif objectType ==20 then
				xButton.SetSize(object, NewWidth, NewHeight);
				xButton.SetPos(object, NewX, NewY);
		elseif objectType ==40 then
			Plugin.SetSize(object, NewWidth, NewHeight);
			Plugin.SetPos(object, NewX, NewY);
		else
			Dialog.Message("Error", object.." : Object undifined", MB_OK, MB_ICONSTOP, MB_DEFBUTTON1);
		end
	end
end

function saveXmlData()
	xml = '';

	xml = xml..'<ROOT>\r\n';
	xml = xml..'\t<PAGE Name = "'..Application.GetCurrentPage()..'">\r\n';

	allObjects = Page.EnumerateObjects();

	for i,object in pairs (allObjects) do
		local objectType = Page.GetObjectType(object);
		xmlFont = "";
		if object ~= "BTN_SAVE_XML" then
			if objectType ==0 and String.Find(object, "IGNORED", 1, false) == -1 then
				objProp = Button.GetProperties(object);
			elseif objectType ==1  and  String.Find(object, "IGNORED", 1, false) == -1 then
				objProp = Label.GetProperties(object);
			elseif objectType ==2  and  String.Find(object, "IGNORED", 1, false) == -1 then
				objProp = Paragraph.GetProperties(object);
			elseif objectType ==3  and  String.Find(object, "IGNORED", 1, false) == -1 then
				objProp = Image.GetProperties(object);
			elseif objectType ==4  and  String.Find(object, "IGNORED", 1, false) == -1 then
				objProp = Flash.GetProperties(object);
			elseif objectType ==5  and  String.Find(object, "IGNORED", 1, false) == -1 then
				objProp = Video.GetProperties(object);
			elseif objectType ==6  and  String.Find(object, "IGNORED", 1, false) == -1 then
				objProp = Web.GetProperties(object);
			elseif objectType ==7  and  String.Find(object, "IGNORED", 1, false) == -1 then
				objProp = Input.GetProperties(object);
				perFont = (objProp.FontSize*100)/PROJEJCT_PAGE_WIDTH;
				xmlFont = '\t\t\t<perFontSize>'..perFont..'</perFontSize>\r\n';
			elseif objectType ==8  and  String.Find(object, "IGNORED", 1, false) == -1 then
				objProp = Hotspot.GetProperties(object);
			elseif objectType ==9  and  String.Find(object, "IGNORED", 1, false) == -1 then
				objProp = ListBox.GetProperties(object);
				perFont = (objProp.FontSize*100)/PROJEJCT_PAGE_WIDTH;
				xmlFont = '\t\t\t<perFontSize>'..perFont..'</perFontSize>\r\n';
			elseif objectType ==10  and  String.Find(object, "IGNORED", 1, false) == -1 then
				objProp = ComboBox.GetProperties(object);
				perFont = (objProp.FontSize*100)/PROJEJCT_PAGE_WIDTH;
				xmlFont = '\t\t\t<perFontSize>'..perFont..'</perFontSize>\r\n';
			elseif objectType ==11  and  String.Find(object, "IGNORED", 1, false) == -1 then
				objProp = Progress.GetProperties(object);
			elseif objectType ==12  and  String.Find(object, "IGNORED", 1, false) == -1 then
				objProp = Tree.GetProperties(object);
			elseif objectType ==13  and  String.Find(object, "IGNORED", 1, false) == -1 then
				objProp = RadioButton.GetProperties(object);
			elseif objectType ==14  and  String.Find(object, "IGNORED", 1, false) == -1 then
				objProp = RichText.GetProperties(object);
			elseif objectType ==15  and  String.Find(object, "IGNORED", 1, false) == -1 then
				objProp = CheckBox.GetProperties(object);
				perFont = (objProp.FontSize*100)/PROJEJCT_PAGE_WIDTH;
				xmlFont = '\t\t\t<perFontSize>'..perFont..'</perFontSize>\r\n';
			elseif objectType ==16  and  String.Find(object, "IGNORED", 1, false) == -1 then
				objProp = SlideShow.GetProperties(object);
			elseif objectType ==17  and  String.Find(object, "IGNORED", 1, false) == -1 then
				objProp = Grid.GetProperties(object);
			elseif objectType ==18  and  String.Find(object, "IGNORED", 1, false) == -1 then
				objProp = PDF.GetProperties(object);
			elseif objectType ==19  and  String.Find(object, "IGNORED", 1, false) == -1 then
				objProp = QuickTime.GetProperties(object);
			elseif objectType ==20  and  String.Find(object, "IGNORED", 1, false) == -1 then
				objProp = xButton.GetProperties(object);
			elseif objectType ==40  and  String.Find(object, "IGNORED", 1, false) == -1 then
				objProp = Plugin.GetProperties(object);
			else
				Dialog.Message("Error", object.." : Object undifined", MB_OK, MB_ICONSTOP, MB_DEFBUTTON1);
			end

			xml = xml..'\t\t<'..object..' Width = "'..objProp.Width..'" Height = "'..objProp.Height..'" PosX = "'..objProp.X..'" PosY = "'..objProp.Y..'">\r\n';

			perWidth = (objProp.Width*100)/PROJEJCT_PAGE_WIDTH;
			perHeight = (objProp.Height*100)/PROJECT_PAGE_HEIGHT;

			perX = (objProp.X*100)/PROJEJCT_PAGE_WIDTH;
			perY = (objProp.Y*100)/PROJECT_PAGE_HEIGHT;

			xml = xml..'\t\t\t<perWidth>'..perWidth..'</perWidth>\r\n';
			xml = xml..'\t\t\t<perHeight>'..perHeight..'</perHeight>\r\n';
			xml = xml..'\t\t\t<perPosX>'..perX..'</perPosX>\r\n';
			xml = xml..'\t\t\t<perPosY>'..perY..'</perPosY>\r\n';
			if xmlFont ~= nil then
				xml = xml..xmlFont;
			end
			xml = xml..'\t\t</'..object..'>\r\n';
		end
	end

	xml = xml..'\t</PAGE>\r\n';
	xml = xml..'</ROOT>';

	TextFile.WriteFromString("AutoPlay\\htdocs\\xml data\\pages_config\\xml_data_"..Application.GetCurrentPage()..".xml", xml, false);

end

function initList (objectName, tbColumn)
	for i=0, Table.Count(tbColumn)-1 do
		Grid.SetCellText(objectName, 0, i, tbColumn[i+1], true);
	end
end

function resizeList (objectName)
	Grid.AutoSizeColumns(objectName, GVS_BOTH, true);
	
	local gridHeight = Grid.GetSize(objectName).Height;
	newGridHeight = Grid.GetRowHeight(objectName, 0)*Grid.GetRowCount(objectName);
	
	if newGridHeight > Page.GetSize().Height - Grid.GetPos(objectName).Y then
		getLimitInPixel = PAGE_LIMIT_RATIO * Page.GetSize().Height / 100;
		margin = 18;
		
		newGridHeight = Page.GetSize().Height - Grid.GetPos(objectName).Y - getLimitInPixel;
	else
		margin = 3;
		newGridHeight = newGridHeight+20;
	end

	local gridWidth = Grid.GetSize(objectName).Width-margin;
	local nCols = Grid.GetColumnCount(objectName);
	globalColsWidth = 0;
	globalnewColsWidth = 0;
	for i=0, nCols-1 do
		globalColsWidth = globalColsWidth + Grid.GetColumnWidth(objectName, i);
	end

	for i=0, nCols-1 do
		local colRatio = Grid.GetColumnWidth(objectName, i)*100/globalColsWidth;
		local newColWidth = colRatio*gridWidth/100;
		Grid.SetColumnWidth(objectName, i, newColWidth, true);
		globalnewColsWidth = globalnewColsWidth + newColWidth;
	end
	
	Grid.SetSize(objectName, globalnewColsWidth+margin, newGridHeight);

	Grid.SetListMode(objectName, true);
	Grid.SetSingleRowSelection(objectName, true);
end

function checkGitRepo ()
	local IsConnected = HTTP.TestConnection("www.google.fr", 20, 80, nil, nil);
	if (IsConnected == true) then
		Shell.Execute("AutoPlay\\htdocs\\batchs\\check_repo.bat", "open", "", "AutoPlay\\htdocs\\batchs", SW_HIDE, true);

		local nLocalCommits = String.ToNumber(TextFile.ReadToString("AutoPlay\\htdocs\\batchs\\Temp\\local_rep.tmp"));
		local nRemoteCommits = String.ToNumber(TextFile.ReadToString("AutoPlay\\htdocs\\batchs\\Temp\\remote_rep.tmp"));

		if nLocalCommits < nRemoteCommits then
			Dialog.Message("Info", "Git repository is not up to date. Please pull the new version\r\n"..nRemoteCommits-nLocalCommits.." new commits", MB_OKCANCEL, MB_ICONINFORMATION, MB_DEFBUTTON1);
			--[[local commitsList = TextFile.ReadToString("AutoPlay\\htdocs\\batchs\\Temp\\commits_diff.tmp");

			if String.Find(commitsList, "[TMP]:", 1, false) == -1 then
				result = DialogEx.Show("CHECK_REPO", true, nil, nil);
			end]]
		end
	end
end

function Trans (bundle, composant)
	local lang = Application.LoadValue("ITStock", "LANG");
	
	local tblBundleList = TextFile.ReadToTable("AutoPlay\\htdocs\\lang-properties\\"..lang.."\\"..composant.."_"..lang..".properties");

	for i,bundleLines in pairs (tblBundleList) do
		if String.Find(bundleLines, bundle, 1, false) ~= -1 then
			return String.TrimLeft(bundleLines, bundle.."=");
		end
	end
	
	return bundle;
end

function TransPage (composant)
	
	if Application.GetCurrentPage() == "" then
		allObjects = DialogEx.EnumerateObjects();
	else
		allObjects = Page.EnumerateObjects();
	end	

	Debug.ShowWindow(true);

	for i,object in pairs (allObjects) do
		if Application.GetCurrentPage() == "" then
			objectType = DialogEx.GetObjectType(object);
			interfaceSize = DialogEx.GetSize();
		else
			objectType = Page.GetObjectType(object);
			interfaceSize = Page.GetSize();
		end

		if objectType ==0 then
			objProp = Button.GetProperties(object);
			local objTransText = Trans(objProp.Text, composant);
			Button.SetText(object, objTransText);
		end
		
		if objectType ==1  then
			objProp = Label.GetProperties(object);
			local objTransText = Trans(objProp.Text, composant);
			Debug.Print(objProp.Text..":"..objTransText.."\r\n");
			Debug.Print("Page Width = "..interfaceSize.Width.."\r\n");
			Debug.Print("Label Width/PosX = "..Label.GetSize(object).Width.."/"..Label.GetPos(object).X.."\r\n");
			local objRatio = Label.GetPos(object).X * 100 / (interfaceSize.Width - Label.GetSize(object).Width);
			Debug.Print("Label Ratio = "..objRatio.."%\r\n");
			Debug.Print("***************************************\r\n");
			Label.SetText(object, objTransText);
			Debug.Print("Label Width = "..Label.GetSize(object).Width.."\r\n");
			local objNewPosX = objRatio * (interfaceSize.Width - Label.GetSize(object).Width) / 100;
			Debug.Print("New Label PosX = "..objNewPosX.."\r\n");
			Debug.Print("--------------------------------------\r\n");
			Label.SetPos(object, objNewPosX, Label.GetPos(object).Y);

		end
	end
end