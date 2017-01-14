--A = LOAD 'Final_output/part*' using PigStorage(',') as (date_time:chararray, head_line:chararray, author:chararray, sent_val:chararray);

A = LOAD 'Final/*' as (date_time:chararray, head_line:chararray, author:chararray, sent_val:chararray);

B = FOREACH A GENERATE date_time as d_time, head_line as h_line, REPLACE(REPLACE(author, 'None','The New York Times'), 'CNBC', 'The New York Times') as auth, sent_val as s_val;

--B = FOREACH A GENERATE author;

data = FOREACH B GENERATE d_time, h_line, (auth IS NOT NULL ? auth : 'The New York Times') as new_auth, s_val;


STORE data INTO 'Final_output2' using PigStorage(',');

--DUMP data;