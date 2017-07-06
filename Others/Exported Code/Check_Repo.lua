Shell.Execute("AutoPlay\\htdocs\\batchs\\check_repo.bat", "open", "", "AutoPlay\\htdocs\\batchs", SW_HIDE, false);

local nLocalCommits = String.ToNumber(TextFile.ReadToString("AutoPlay\\htdocs\\batchs\\Temp\\local_rep.tmp"));
local nRemoteCommits = String.ToNumber(TextFile.ReadToString("AutoPlay\\htdocs\\batchs\\Temp\\remote_rep.tmp"));

if nLocalCommits < nRemoteCommits then
	local commitsList = TextFile.ReadToString("AutoPlay\\htdocs\\batchs\\Temp\\commits_diff.tmp");

	if String.Find(commitsList, "[TMP]:", 1, false) == -1 then
		result = DialogEx.Show("CHECK_REPO", true, nil, nil);
	end
	Application.Exit();	
else
	Application.SaveValue("ITStock", "FirstRun", "Y");
	DialogEx.Show("LOGIN", true, nil, nil);
end