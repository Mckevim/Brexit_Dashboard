A = LOAD 'Daily_mail_offset__0.txt' as (head_line:chararray, author:chararray, source:chararray, date_time:chararray, preview:chararray);

--B = FOREACH A GENERATE REPLACE(head_line,'([^a-zA-Z\\s]+)','');

B = FOREACH A GENERATE REPLACE(REPLACE(REPLACE(head_line,'u\'',''),'u"',''),'([^a-zA-Z\\s]+)','') AS input_data;

Words = FOREACH B GENERATE FLATTEN(TOKENIZE(input_data,' ')) AS word;

Grouped = GROUP Words BY word;

wordcount = FOREACH Grouped GENERATE group, COUNT(Words) AS count_wrd;

sort_data = ORDER wordcount BY count_wrd Asc;

DUMP sort_data;

