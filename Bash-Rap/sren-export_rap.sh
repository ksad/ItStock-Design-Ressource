#!/bin/bash

echo '*******************************************'
echo ' Calcul des statistiques pour SREN monde'
echo '*******************************************'

file=$1
local_date="$(date +%x)"
year="$(date +%G)"
current_month="$(date +%B)"
current_month="${current_month^}"
output_file="Export_$(date +%g)-$(date +%m)-$(date +%d)_consolide_RSITE.xls"

Not_Closed="$(curl -s -u karim.sad:2YynIn3h -X POST -H "Content-Type: application/json" --data '{"jql":"project = \"Support Renault \" and status not in (closed) and Platform not in (\"MY RENAULT\",\"MY DACIA\", \"MyR / MyD\")","startAt":0,"maxResults":0,"fields":["none"]}' "https://jira.ekino.com/rest/api/2/search" | jq -r '.total')"
Not_Closed_Renault="$(curl -s -u karim.sad:2YynIn3h -X POST -H "Content-Type: application/json" --data '{"jql":"project = \"Support Renault \" and status not in (closed) and Platform not in (\"MY RENAULT\",\"MY DACIA\", \"MyR / MyD\") AND assignee not in (membersOf(confluence-users), xavier.riviere, gustavo.ruiz, johana.moreno)","startAt":0,"maxResults":0,"fields":["none"]}' "https://jira.ekino.com/rest/api/2/search" | jq -r '.total')"
Resolved="$(curl -s -u karim.sad:2YynIn3h -X POST -H "Content-Type: application/json" --data '{"jql":"project = \"Support Renault \" and status = resolved and Platform not in (\"MY RENAULT\",\"MY DACIA\", \"MyR / MyD\")","startAt":0,"maxResults":0,"fields":["none"]}' "https://jira.ekino.com/rest/api/2/search" | jq -r '.total')"
Resolved_Renault="$(curl -s -u karim.sad:2YynIn3h -X POST -H "Content-Type: application/json" --data '{"jql":"project = \"Support Renault \" and status = resolved and Platform not in (\"MY RENAULT\",\"MY DACIA\", \"MyR / MyD\") AND assignee not in (membersOf(confluence-users), xavier.riviere, gustavo.ruiz, johana.moreno)","startAt":0,"maxResults":0,"fields":["none"]}' "https://jira.ekino.com/rest/api/2/search" | jq -r '.total')"
In_Progress="$(curl -s -u karim.sad:2YynIn3h -X POST -H "Content-Type: application/json" --data '{"jql":"project = \"Support Renault \" and status not in (closed,resolved) and Platform not in (\"MY RENAULT\",\"MY DACIA\", \"MyR / MyD\") ","startAt":0,"maxResults":0,"fields":["none"]}' "https://jira.ekino.com/rest/api/2/search" | jq -r '.total')"
In_Progress_Renault="$(curl -s -u karim.sad:2YynIn3h -X POST -H "Content-Type: application/json" --data '{"jql":"project = \"Support Renault \" and status not in (closed,resolved) and Platform not in (\"MY RENAULT\",\"MY DACIA\", \"MyR / MyD\") AND assignee not in (membersOf(confluence-users), xavier.riviere, gustavo.ruiz, johana.moreno)","startAt":0,"maxResults":0,"fields":["none"]}' "https://jira.ekino.com/rest/api/2/search" | jq -r '.total')"
In_Progress_Incidents="$(curl -s -u karim.sad:2YynIn3h -X POST -H "Content-Type: application/json" --data '{"jql":"project = \"Support Renault \" and status not in (closed,resolved) and Platform not in (\"MY RENAULT\",\"MY DACIA\", \"MyR / MyD\") and type = incident","startAt":0,"maxResults":0,"fields":["none"]}' "https://jira.ekino.com/rest/api/2/search" | jq -r '.total')"
In_Progress_Support_Request="$(curl -s -u karim.sad:2YynIn3h -X POST -H "Content-Type: application/json" --data '{"jql":"project = \"Support Renault \" and status not in (closed,resolved) and Platform not in (\"MY RENAULT\",\"MY DACIA\", \"MyR / MyD\") and type = \"Support Request\"","startAt":0,"maxResults":0,"fields":["none"]}' "https://jira.ekino.com/rest/api/2/search" | jq -r '.total')"
AR_in_Progress="$(curl -s -u karim.sad:2YynIn3h -X POST -H "Content-Type: application/json" --data '{"jql":"project =  \"Renault Support : Account Request\" and status not in (closed,resolved) and (labels != WIRED OR labels is EMPTY)","startAt":0,"maxResults":0,"fields":["none"]}' "https://jira.ekino.com/rest/api/2/search" | jq -r '.total')"
AR_Renault_In_Progress="$(curl -s -u karim.sad:2YynIn3h -X POST -H "Content-Type: application/json" --data '{"jql":"project =  \"Renault Support : Account Request\" and status not in (closed,resolved) and (labels != WIRED OR labels is EMPTY) AND assignee not in (membersOf(confluence-users), xavier.riviere, gustavo.ruiz, johana.moreno)","startAt":0,"maxResults":0,"fields":["none"]}' "https://jira.ekino.com/rest/api/2/search" | jq -r '.total')"
AR_Month="$(curl -s -u karim.sad:2YynIn3h -X POST -H "Content-Type: application/json" --data '{"jql":"project =  \"Renault Support : Account Request\" and created >= startOfMonth() and (labels != WIRED OR labels is EMPTY)","startAt":0,"maxResults":0,"fields":["none"]}' "https://jira.ekino.com/rest/api/2/search" | jq -r '.total')"
read -p "Please enter two fix versions (Ex : R17-x R17-y): " fixVersion1 fixVersion2
Fix_Version1="$(curl -s -u karim.sad:2YynIn3h -X POST -H "Content-Type: application/json" --data '{"jql":"project = \"Support Renault \" and status not in (closed) and Platform not in (\"MY RENAULT\",\"MY DACIA\", \"MyR / MyD\") and fixVersion in (\"'$fixVersion1'\")","startAt":0,"maxResults":0,"fields":["none"]}' "https://jira.ekino.com/rest/api/2/search" | jq -r '.total')"
Fix_Version2="$(curl -s -u karim.sad:2YynIn3h -X POST -H "Content-Type: application/json" --data '{"jql":"project = \"Support Renault \" and status not in (closed) and Platform not in (\"MY RENAULT\",\"MY DACIA\", \"MyR / MyD\") and fixVersion in (\"'$fixVersion2'\")","startAt":0,"maxResults":0,"fields":["none"]}' "https://jira.ekino.com/rest/api/2/search" | jq -r '.total')"
Created_Month="$(curl -s -u karim.sad:2YynIn3h -X POST -H "Content-Type: application/json" --data '{"jql":"project = \"Support Renault \" and created >= startOfMonth() and Platform not in (\"MY RENAULT\",\"MY DACIA\", \"MyR / MyD\")","startAt":0,"maxResults":0,"fields":["none"]}' "https://jira.ekino.com/rest/api/2/search" | jq -r '.total')"
Resolved_Month="$(curl -s -u karim.sad:2YynIn3h -X POST -H "Content-Type: application/json" --data '{"jql":"project = \"Support Renault \" and resolutiondate >= startOfMonth() and Platform not in (\"MY RENAULT\",\"MY DACIA\", \"MyR / MyD\")","startAt":0,"maxResults":0,"fields":["none"]}' "https://jira.ekino.com/rest/api/2/search" | jq -r '.total')"
Resolved_Blocker="$(curl -s -u karim.sad:2YynIn3h -X POST -H "Content-Type: application/json" --data '{"jql":"project = \"Support Renault \" and resolutiondate >= startOfMonth() and Platform not in (\"MY RENAULT\",\"MY DACIA\", \"MyR / MyD\") and priority in (Blocker)","startAt":0,"maxResults":0,"fields":["none"]}' "https://jira.ekino.com/rest/api/2/search" | jq -r '.total')"
Resolved_Critical="$(curl -s -u karim.sad:2YynIn3h -X POST -H "Content-Type: application/json" --data '{"jql":"project = \"Support Renault \" and resolutiondate >= startOfMonth() and Platform not in (\"MY RENAULT\",\"MY DACIA\", \"MyR / MyD\") and priority in (Critical)","startAt":0,"maxResults":0,"fields":["none"]}' "https://jira.ekino.com/rest/api/2/search" | jq -r '.total')"
Resolved_Major="$(curl -s -u karim.sad:2YynIn3h -X POST -H "Content-Type: application/json" --data '{"jql":"project = \"Support Renault \" and resolutiondate >= startOfMonth() and Platform not in (\"MY RENAULT\",\"MY DACIA\", \"MyR / MyD\") and priority in (Major)","startAt":0,"maxResults":0,"fields":["none"]}' "https://jira.ekino.com/rest/api/2/search" | jq -r '.total')"
Resolved_Minor="$(curl -s -u karim.sad:2YynIn3h -X POST -H "Content-Type: application/json" --data '{"jql":"project = \"Support Renault \" and resolutiondate >= startOfMonth() and Platform not in (\"MY RENAULT\",\"MY DACIA\", \"MyR / MyD\") and priority in (Minor, Trivial)","startAt":0,"maxResults":0,"fields":["none"]}' "https://jira.ekino.com/rest/api/2/search" | jq -r '.total')"

echo 'Jiras non fermés (Renault)        : '$Not_Closed' ('$Not_Closed_Renault')'
echo 'Jiras résolus à fermer (Renault)  : '$Resolved' ('$Resolved_Renault')'
echo 'Jiras à résoudre (Renault)        : '$In_Progress' ('$In_Progress_Renault')'
echo '                 Incidents        : '$In_Progress_Incidents''
echo '		 Support Request        : '$In_Progress_Support_Request''
#echo '#Délai moyen de résolution (en jours dont HNO) pour le mois de {$Month) : '
echo 'AR à résoudre                     : '$AR_in_Progress' ('$AR_Renault_In_Progress')'
echo 'AR créés dans le mois de '$current_month' : '$AR_Month''
#echo '#délai moyen de résolution (en jours dont HNO) pour le mois courant'
echo 'Jira prévue '$fixVersion1'                 : '$Fix_Version1''
if [ ! -z "$fixVersion2" ]; then
	echo 'Jira prévue '$fixVersion2'                 : '$Fix_Version2''
fi
echo '------ Stats du mois de '$current_month' ------'
echo 'Jiras créés   : '$Created_Month''
echo 'Jiras résolus : '$Resolved_Month''
echo '      Blocker : '$Resolved_Blocker''
echo '	   Critical : '$Resolved_Critical''
echo '	      Major : '$Resolved_Major''
echo '	      Minor : '$Resolved_Minor''

echo '*******************************************'
echo ' Génération du fichier excel               '
echo '*******************************************'

python sren_updater.py $1 $local_date $Not_Closed $Not_Closed_Renault $Resolved $Resolved_Renault $In_Progress $In_Progress_Renault $In_Progress_Incidents $In_Progress_Support_Request $AR_in_Progress $AR_Renault_In_Progress $AR_Month $Fix_Version1 $Fix_Version2 $Created_Month $Resolved_Month $Resolved_Blocker $Resolved_Critical $Resolved_Major $Resolved_Minor $year $current_month $output_file
