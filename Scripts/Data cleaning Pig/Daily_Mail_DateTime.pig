--This script is for cleaning the date time information form The Daily Mail scrape
--****Note the 'n' has been removed therefore January == Jauary && 2nd == 2d***

A = LOAD 'Daily_Mail_Data/*.txt' as (head_line:chararray, author:chararray, date_time:chararray, sent_val:chararray);

--Replace the special characters in each column
clean_data = FOREACH A GENERATE REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(date_time,'[\\\\n\\(\\)]+',''), 'By',''),',',''), '  ', ''), '-',''), '\'', ''), '([^a-zA-Z0-9:\\s]+)', ''), '  ', ''), 'st', ''), 'rd', ''), 'd', ''), 'th', ''), 'am', ''), 'pm', '') as dtime, REPLACE(REPLACE(REPLACE(head_line,'u\'',''),'u"',''),'([^a-zA-Z\\s]+)','') as hline, REPLACE(author,'([^a-zA-Z\\s]+)','') AS auth, sent_val as sentiment_val;

final_data = FOREACH clean_data GENERATE REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(dtime, 'January', '1'),'February', '2'), 'March','3'), 'April', '4'), 'May', '5'), 'Jue', '6'), 'July', '7'), 'Augu', '8'), 'September', '9'), 'October', '10'), 'November', '11'), 'December', '12'), hline, auth, sentiment_val;

STORE final_data INTO 'DM_output' using PigStorage('\t');

--DUMP final_data;
