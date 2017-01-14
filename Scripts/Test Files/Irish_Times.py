
#Project for MCM Data Visualisation project

from lxml import html
import requests
import time


#Get the html of the web page
page = requests.get('http://www.irishtimes.com/search/search-7.1213540?q=brexit&page=10&sortOrder=newest')
tree = html.fromstring(page.content)


for x in range(0,5):
    
    page = requests.get('http://www.irishtimes.com/search/search-7.1213540?q=brexit&page='
                        + str(x) +'&sortOrder=newest')
    
    tree = html.fromstring(page.content)
    time.sleep(1)
    for h in range(2,12):
        date_value1 = tree.xpath('//*[@id="search_results"]/div['+str(h)+']/div/div/div/ul/li[3]/text()')
        if not date_value1:
            print date_value0
        else:
            date_value0 =  tree.xpath('//*[@id="search_results"]/div['+str(h)+
                                        ']/div/div/div/ul/li[3]/text()')
            print str(date_value0)


        #date_value1 = tree.xpath('//*[@id="search_results"]/div['+str(h-1)+']/div/div/div/ul/li[3]/text()')
        #date_value2 = tree.xpath('//*[@id="search_results"]/div['+str(h+1)+']/div/div/div/ul/li[3]/text()'
