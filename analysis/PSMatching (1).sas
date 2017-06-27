%macro PSMatching(datatreatment=, datacontrol=, method=, numberofcontrols=, caliper=,
 replacement=, out=);

/* Create copies of the treated units if N > 1 */;
 data _Treatment0(drop= i);
  set &datatreatment;
  do i= 1 to &numberofcontrols;
  RandomNumber= ranuni(12345);
output;
end;
run;
/* Randomly sort both datasets */
proc sort data= _Treatment0 out= _Treatment(drop= RandomNumber);
by RandomNumber;
run;
data _Control0;
set &datacontrol;
RandomNumber= ranuni(45678);
run;
proc sort data= _Control0 out= _Control(drop= RandomNumber);
by RandomNumber;
run;

 data Matched(keep = IdSelectedControl PScoreControl MatchedToTreatID PScoreTreat);
  length pscoreC 8;
  length idC 8;
/* Load Control dataset into the hash object */
  if _N_= 1 then do;
declare hash h(dataset: "_Control", ordered: 'no');
declare hiter iter('h');
h.defineKey('idC');
h.defineData('pscoreC', 'idC');
h.defineDone();
call missing(idC, pscoreC);
end;
/* Open the treatment */
set _Treatment;
%if %upcase(&method) ~= RADIUS %then %do;
retain BestDistance 99;
%end;
/* Iterate over the hash */
rc= iter.first();
if (rc=0) then BestDistance= 99;
do while (rc = 0);
/* Caliper */
%if %upcase(&method) = CALIPER %then %do;
if (pscoreT - &caliper) <= pscoreC <= (pscoreT + &caliper) then do;
ScoreDistance = abs(pscoreT - pscoreC);
if ScoreDistance < BestDistance then do;
BestDistance = ScoreDistance;
IdSelectedControl = idC;
PScoreControl =  pscoreC;
MatchedToTreatID = idT;
PScoreTreat = pscoreT;
end;
end;
%end;
/* NN */
%if %upcase(&method) = NN %then %do;
ScoreDistance = abs(pscoreT - pscoreC);
if ScoreDistance < BestDistance then do;
BestDistance = ScoreDistance;
IdSelectedControl = idC;
PScoreControl =  pscoreC;
MatchedToTreatID = idT;
PScoreTreat = pscoreT;
end;
%end;

%if %upcase(&method) = NN or %upcase(&method) = CALIPER %then %do;
rc = iter.next();
/* Output the best control and remove it */
if (rc ~= 0) and BestDistance ~=99 then do;
output;
%if %upcase(&replacement) = NO %then %do;
rc1 = h.remove(key: IdSelectedControl);
%end;
end;
%end;
/* Radius */
%if %upcase(&method) = RADIUS %then %do;
if (pscoreT - &caliper) <= pscoreC <= (pscoreT + &caliper) then do;
IdSelectedControl = idC;
PScoreControl =  pscoreC;
MatchedToTreatID = idT;
PScoreTreat = pscoreT;
output;
end;
rc = iter.next();
%end;
end;
run;
/* Delete temporary tables. Quote for debugging */
proc datasets;
delete _:(gennum=all);

run;
 data &out;
   set Matched;
 run;
%mend PSMatching;
