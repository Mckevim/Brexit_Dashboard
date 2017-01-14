A = LOAD 'The_Guardian/*.txt' as (head_line:chararray, author:chararray, date_time:chararray, sent_val:chararray);

B = FOREACH A GENERATE date_time, REPLACE(head_line, ',',''), author, sent_val;

STORE B INTO 'Guard_output' using PigStorage('\t');

--DUMP B;

--B = FOREACH A GENERATE REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(date_time,'[\\\\n\\(\\)]+',''), 'By',''),',',''), '  ', ''), '-',''), '\'', ''), '([^a-zA-Z0-9:\\s]+)', ''), '  ', ''), 'am', ''), 'pm', ''), '2d', '2nd') AS mytime;

--C = FOREACH B GENERATE REPLACE(REPLACE(REPLACE(REPLACE(mytime, 'nd', ''), 'th', ''), 'st', ''), 'rd', '') AS newtime;

--,GetDay(newTime),GetYear(newTime),GetHour(newTime),GetMinute(newTime);