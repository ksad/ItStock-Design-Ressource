local lastName = Input.GetText("IN_LASTNAME_UCF");
local firstName = Input.GetText("IN_FIRSTNAME_UCF");
local username = Input.GetText("IN_USERNAME_UCF");
local password = Input.GetText("IN_PASSWORD_UCF");
local role = ComboBox.GetItemText("CB_ROLE", ComboBox.GetSelected("CB_ROLE"));

local LoadedImage = Image.GetFilename("IMG_TOGGLE_YES_NO");
local ImageStatus = String.SplitPath(LoadedImage);
local checkListSign = ImageStatus.Filename;
			

if lastName == "" or lastName == "Lastname" then
	Image.Load("IMG_LASTNAME_UCF", "AutoPlay\\Images\\input_mandatory.png");
	Application.SetLastError(0616);
end

if firstName == "" or firstName == "Firstname" then
	Image.Load("IMG_FIRSTNAME_UCF", "AutoPlay\\Images\\input_mandatory.png");
	Application.SetLastError(0616);
end

if username == "" or username == "Username" then
	Image.Load("IMG_USERNAME_UCF", "AutoPlay\\Images\\input_mandatory.png");
	Application.SetLastError(0616);
end

if password == "" or password == "Password" then
	Image.Load("IMG_PASSWORD_UCF", "AutoPlay\\Images\\input_mandatory.png");
	Application.SetLastError(0616);
end

if role == "Role" then
	ComboBox.SetItemText("CB_ROLE", 1, "Role is mandatory");
	ComboBox.SetSelected("CB_ROLE", 1);
end

if checkListSign == "user_toggle_idle" then
	tblLabelProps = {};
	tblLabelProps.ColorNormal = Math.HexColorToNumber("FF0000");
	tblLabelProps.ColorDown = Math.HexColorToNumber("FF0000");
	tblLabelProps.ColorHighlight = Math.HexColorToNumber("FF0000");
	tblLabelProps.ColorDisabled = Math.HexColorToNumber("FF0000");	
	Label.SetProperties("LB_SIGN", tblLabelProps);
end


error = Application.GetLastError();
if (error == 0616) then
	Application.ExitScript();
end

Application.ExitScript();

Image.SetVisible("IMG_LASTNAME_UCF", false);
Image.SetVisible("IMG_firstName_UCF", false);
Image.SetVisible("IMG_PASSWORD_UCF", false);
Image.SetVisible("IMG_DB_ADDRESS_DBCF", false);
Image.SetVisible("IMG_firstName_UCF", false);
Input.SetVisible("IN_LASTNAME_UCF", false);
Input.SetVisible("IN_firstName_UCF", false);
Input.SetVisible("IN_PASSWORD_UCF", false);
Input.SetVisible("IN_DB_ADDRESS_DBCF", false);
Input.SetVisible("IN_firstName_UCF", false);
Label.SetVisible("LB_CHECK_DB_CONNECTION", true);
Image.SetVisible("IMG_CHECK_DB_CONNECT", true);

Application.Sleep(3000);

MySQLConnection, err = MySQL:connect(lastName, firstName, password, serverAddress, port);
if err then
	-- If there is an error connecting to the database, display a dialog box with the error
	Dialog.Message("Error coonection", err, MB_OK, MB_ICONSTOP, MB_DEFBUTTON1);
	
	Image.SetVisible("IMG_LASTNAME_UCF", true);
	Image.SetVisible("IMG_firstName_UCF", true);
	Image.SetVisible("IMG_PASSWORD_UCF", true);
	Image.SetVisible("IMG_DB_ADDRESS_DBCF", true);
	Image.SetVisible("IMG_firstName_UCF", true);
	Input.SetVisible("IN_LASTNAME_UCF", true);
	Input.SetVisible("IN_firstName_UCF", true);
	Input.SetVisible("IN_PASSWORD_UCF", true);
	Input.SetVisible("IN_DB_ADDRESS_DBCF", true);
	Input.SetVisible("IN_firstName_UCF", true);
	
	Label.SetVisible("LB_CHECK_DB_CONNECTION", false);
	Image.SetVisible("IMG_CHECK_DB_CONNECT", false);
	Application.ExitScript();
end

Image.SetVisible("IMG_LASTNAME_UCF", true);
Image.SetVisible("IMG_firstName_UCF", true);
Image.SetVisible("IMG_PASSWORD_UCF", true);
Image.SetVisible("IMG_DB_ADDRESS_DBCF", true);
Image.SetVisible("IMG_firstName_UCF", true);
Input.SetVisible("IN_LASTNAME_UCF", true);
Input.SetVisible("IN_firstName_UCF", true);
Input.SetVisible("IN_PASSWORD_UCF", true);
Input.SetVisible("IN_DB_ADDRESS_DBCF", true);
Input.SetVisible("IN_firstName_UCF", true);
Label.SetVisible("LB_CHECK_DB_CONNECTION", false);
Image.SetVisible("IMG_CHECK_DB_CONNECT", false);

local db_access = "[DB_NAME]="..lastName.."\r\n".."[USER]="..firstName.."\r\n".."[PASSWORD]="..password.."\r\n".."[ADDRESS]="..serverAddress.."\r\n".."[PORT]="..port;
TextFile.WriteFromString("AutoPlay\\Docs\\db_access.txt", db_access, false);
Crypto.BlowfishEncrypt("AutoPlay\\Docs\\db_access.txt", "AutoPlay\\Docs\\db_access.enc", "securestockitwiththispassword");
File.Delete("AutoPlay\\Docs\\db_access.txt", false, false, false, nil);

-- Test for error
error = Application.GetLastError();
if (error ~= 0) then
	PopUp("0");
	Application.ExitScript();
else
	PopUp("1");
	DialogEx.Close(this);
end