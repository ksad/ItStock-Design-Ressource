function GetTorrentCategory (URL)
	local GetCategoryResponse = HTTP.Submit(URL, {search="Catégorie"}, SUBMITWEB_GET, 20, 80, nil, nil);
	
	error = Application.GetLastError();
	if (error ~= 0) then
		Dialog.Message("Error", _tblErrorMessages[error], MB_OK, MB_ICONEXCLAMATION);
		Application.ExitScript();
	end
	
	local SearchCateg = String.Find(GetCategoryResponse, "<th>Cat&#233;gorie</th>", 1, false);
	local CategPart1 = String.TrimLeft(String.TrimLeft(String.Mid(GetCategoryResponse, SearchCateg+24, 50), nil), "<td>");
	local CategPart2 = String.Mid(CategPart1, String.Find(CategPart1, "</td>", 1, false), -1);
	local Category = String.TrimRight(CategPart1, CategPart2);
end


function accordionToggle (SelectedMenu)
	Debug.ShowWindow(true);
	HEIGHT_BG_MENU_FORM = 200;
	SPECING_MENU = 10;
	
	if ACCORDION_TOGGLE == "OFF" then
		local menuProp = Image.GetProperties(SelectedMenu);
		
		tblImageProps = {};
		tblImageProps.Height = HEIGHT_BG_MENU_FORM;
		tblImageProps.Width = menuProp.Width;
		tblImageProps.Y = menuProp.Y+menuProp.Height;
		tblImageProps.X = menuProp.X;
		tblImageProps.Visible = true;		
		Image.SetProperties("IMG_BG_MENU_FORM", tblImageProps);
	
		ACCORDION_TOGGLE = "ON";
		
		local objectList = Page.EnumerateObjects();
		for i, object in pairs(objectList) do
			local objectType = Page.GetObjectType(object);
			local searchAccordionObject = String.Find(object, "ACCORDION", 1, false);
			local countAccordionObjects = 0;
			if objectType == 3 and searchAccordionObject ~= -1 then
				countAccordionObjects = countAccordionObjects + 1;
				
				if object ~= SelectedMenu then
					Debug.Print(SelectedMenu.."-> Object : "..object.."\r\n");
					nextPosY = 0;
					if Image.GetPos(object).Y > menuProp.Y then
						Debug.Print("menuPropY : "..menuProp.Y.."\r\n");
						posX = menuProp.X;
						posY = menuProp.Y+menuProp.Height+HEIGHT_BG_MENU_FORM+SPECING_MENU
						Image.SetPos(object, posX, posY);
						Debug.Print("Pos Y : "..posY.."\r\n");
						nextPosY = nextPosY + posY+menuProp.Height+SPECING_MENU;
						Debug.Print("Next Pos Y : "..nextPosY.."\r\n");
						Debug.Print("------------------------------------------------\r\n");
					end
				end
			end
		end	
	else
		tblImageProps = {};
		tblImageProps.Height = 1;
		tblImageProps.Width = 1;
		tblImageProps.Y = 0;
		tblImageProps.X = 0;
		tblImageProps.Visible = false;		
		Image.SetProperties("IMG_BG_MENU_FORM", tblImageProps);
		
		ACCORDION_TOGGLE = "OFF";
	end
end