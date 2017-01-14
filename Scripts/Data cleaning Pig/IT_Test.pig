A = LOAD 'Irish_Times_Page_0.txt' as (head_line:chararray, author:chararray, date_time:chararray, sent_val:chararray);

--B = FOREACH A GENERATE head_line, author, date_time, sent_val;

B = FOREACH A GENERATE REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(date_time, ',',''),'January', '1'),'February', '2'), 'March','3'), 'April', '4'), 'May', '5'), 'June', '6'), 'July', '7'), 'August', '8'), 'September', '9'), 'October', '10'), 'November', '11'), 'December', '12'), head_line, author, sent_val;

DUMP B;

--B = FOREACH A GENERATE REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(date_time,'[\\\\n\\(\\)]+',''), 'By',''),',',''), '  ', ''), '-',''), '\'', ''), '([^a-zA-Z0-9:\\s]+)', ''), '  ', ''), 'am', ''), 'pm', ''), '2d', '2nd') AS mytime;

--C = FOREACH B GENERATE REPLACE(REPLACE(REPLACE(REPLACE(mytime, 'nd', ''), 'th', ''), 'st', ''), 'rd', '') AS newtime;

--,GetDay(newTime),GetYear(newTime),GetHour(newTime),GetMinute(newTime);