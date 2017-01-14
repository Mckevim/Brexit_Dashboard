A = LOAD 'New_York_Times/*.txt' as (head_line:chararray, author:chararray, date_time:chararray, sent_val:chararray);

B = FOREACH A GENERATE date_time, REPLACE(head_line, ',',''), author, sent_val;

STORE B INTO 'TNYT_output' using PigStorage('\t');

--DUMP B;