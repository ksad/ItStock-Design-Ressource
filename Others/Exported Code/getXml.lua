Debug.ShowWindow(true);

xml = '';

xml = xml..'<root>\r\n';
xml = xml..'\t<currentResoltion ePageWidth = "'..Page.GetSize().Width..'" ePageHeight = "'..Page.GetSize().Height..'"/>\r\n';
xml = xml..'\t<Page Name = "'..Application.GetCurrentPage()..'">\r\n';

allObjects = Page.EnumerateObjects();

for i,object in pairs (allObjects) do
	local objectType = Page.GetObjectType(object);

	if objectType ==0 and String.Find(object, "IGNORED", 1, false) == -1 then
		objProp = Button.GetProperties(object);
	elseif objectType ==1 and String.Find(object, "IGNORED", 1, false) == -1 then
		objProp = Label.GetProperties(object);
	elseif objectType ==2 and String.Find(object, "IGNORED", 1, false) == -1 then
		objProp = Paragraph.GetProperties(object);
	elseif objectType ==3 and String.Find(object, "IGNORED", 1, false) == -1 then
		objProp = Image.GetProperties(object);
	elseif objectType ==4 and String.Find(object, "IGNORED", 1, false) == -1 then
		objProp = Flash.GetProperties(object);
	elseif objectType ==5 and String.Find(object, "IGNORED", 1, false) == -1 then
		objProp = Video.GetProperties(object);
	elseif objectType ==6 and String.Find(object, "IGNORED", 1, false) == -1 then
		objProp = Web.GetProperties(object);
	elseif objectType ==7 and String.Find(object, "IGNORED", 1, false) == -1 then
		objProp = Input.GetProperties(object);
	elseif objectType ==8 and String.Find(object, "IGNORED", 1, false) == -1 then
		objProp = Hotspot.GetProperties(object);
	elseif objectType ==9 and String.Find(object, "IGNORED", 1, false) == -1 then
		objProp = Listbox.GetProperties(object);
	elseif objectType ==10 and String.Find(object, "IGNORED", 1, false) == -1 then
		objProp = Combobox.GetProperties(object);
	elseif objectType ==11 and String.Find(object, "IGNORED", 1, false) == -1 then
		objProp = Progress.GetProperties(object);
	elseif objectType ==12 and String.Find(object, "IGNORED", 1, false) == -1 then
		objProp = Tree.GetProperties(object);
	elseif objectType ==13 and String.Find(object, "IGNORED", 1, false) == -1 then
		objProp = RadioButton.GetProperties(object);
	elseif objectType ==14 and String.Find(object, "IGNORED", 1, false) == -1 then
		objProp = RichText.GetProperties(object);
	elseif objectType ==15 and String.Find(object, "IGNORED", 1, false) == -1 then
		objProp = CheckBox.GetProperties(object);
	elseif objectType ==16 and String.Find(object, "IGNORED", 1, false) == -1 then
		objProp = SlideShow.GetProperties(object);
	elseif objectType ==17 and String.Find(object, "IGNORED", 1, false) == -1 then
		objProp = Grid.GetProperties(object);
	elseif objectType ==18 and String.Find(object, "IGNORED", 1, false) == -1 then
		objProp = PDF.GetProperties(object);
	elseif objectType ==19 and String.Find(object, "IGNORED", 1, false) == -1 then
		objProp = QuickTime.GetProperties(object);
	elseif objectType ==20 and String.Find(object, "IGNORED", 1, false) == -1 then
		objProp = xButton.GetProperties(object);
	elseif objectType ==40 and String.Find(object, "IGNORED", 1, false) == -1 then
		objProp = Plugin.GetProperties(object);
	else
		Dialog.Message("Error", "Object undifined", MB_OK, MB_ICONSTOP, MB_DEFBUTTON1);
	end
	xml = xml..'\t\t<Object Name = "'..object..'" Width = "'..objProp.Width..'" Height = "'..objProp.Height..'" PosX = "'..objProp.X..'" PosY = "'..objProp.Y..'">\r\n';
	
	perWidth = (objProp.Width*100)/Page.GetSize().Width;
	perHeight = (objProp.Height*100)/Page.GetSize().Height;
		
	perX = (objProp.X*100)/Page.GetSize().Width;
	perY = (objProp.Y*100)/Page.GetSize().Height;
	
	xml = xml..'\t\t\t<perWidth>'..perWidth..'</perWidth>\r\n';
	xml = xml..'\t\t\t<PerHeight>'..perHeight..'</perHeight>\r\n';
	xml = xml..'\t\t\t<perPosX>'..perX..'</perPosX>\r\n';
	xml = xml..'\t\t\t<perPosY>'..perY..'</perPosY>\r\n';
	xml = xml..'\t\t</Object>\r\n';
end


xml = xml..'\t</Page>\r\n';
xml = xml..'</root>';

TextFile.WriteFromString("AutoPlay\\Docs\\text.xml", xml, false);
