-- Load an XML file into memory.
XML.SetXML('<database>\r\n'..
'<users></users>'..
'</database>');

-- get the current XML document as a string
strXML = XML.GetXML();

Debug.ShowWindow(true); 
-- if no errors occurred, display the XML in a popup dialog
error = Application.GetLastError();
if (error == XML.OK) then
    Debug.Print("XML contents : \r\n"..strXML.."\r\n");
    XML.InsertXML("database/users", "\t<planet>Earth</planet>", XML.REPLACE);
    
else
    Dialog.Message("Error", _tblErrorMessages[error]);
end
	

-- get the current XML document as a string
strXML = XML.GetXML();
-- if no errors occurred, display the XML in a popup dialog
error = Application.GetLastError();
if (error == XML.OK) then
    Debug.Print("*** New XML contents : \r\n"..strXML.."\r\n");
else
    Dialog.Message("Error", _tblErrorMessages[error]);
end