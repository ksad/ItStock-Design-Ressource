--local listFolders = Folder.Find(SHF_FONTS, "Nunito", true, nil)
local fontsFilesList = File.Find("C:\\Windows\\Fonts", "Nunito*.*", true, true, nil, nil);

if fontsFilesList == nil then
	result = Dialog.Message("Notice", "Your message here.", MB_OK, MB_ICONINFORMATION, MB_DEFBUTTON1);
	File.Copy("AutoPlay\\htdocs\\ressources\\fonts\\nunito\\*.*", "C:\\Users\\ksad\\Documents\\Docs", true, true, false, true, nil);
	--System.RegisterFont("AutoPlay\\htdocs\\ressources\\fonts\\nunito\\Nunito-Bold.ttf", "Nunito", true);

	
	-- Test for error
	error = Application.GetLastError();
	if (error ~= 0) then
		Dialog.Message("Error", _tblErrorMessages[error], MB_OK, MB_ICONEXCLAMATION);
	end
	
end

Application.ExitScript();

local fontsFilesList = File.Find("C:\\Windows\\Fonts", "Ubuntu*.*", true, true, nil, nil);
local countFonts = Table.Count(fontsFilesList);
Dialog.Message("Notice", count, MB_OK, MB_ICONINFORMATION, MB_DEFBUTTON1);

if countFonts ~= 13 then
	File.Copy("AutoPlay\\htdocs\\apps ressources\\fonts\\nunito\*.*", "C:\\Windows\\Fonts", true, true, false, true, nil);
end


--[[
	Dialog.Message("Notice", "Yes", MB_OK, MB_ICONINFORMATION, MB_DEFBUTTON1);
else
	Dialog.Message("Notice", "No", MB_OK, MB_ICONINFORMATION, MB_DEFBUTTON1);
end]]