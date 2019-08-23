import requests
from bs4 import BeautifulSoup
import json

page = requests.get(
    'https://deadbydaylight.gamepedia.com/Perks')


soup = BeautifulSoup(page.text, 'html.parser')
#Killer only - 34 for survivor
tableBody = soup.find_all('tbody')[35]

tableRows = tableBody.find_all('tr')

output = {}

for tableRow in tableRows[1:]:
    perkName = tableRow.find_all('th')[1].text.replace('\n', '')
    perkDesc = tableRow.find('td').text.strip('\n').replace('\n', ' ')
    output[perkName] = perkDesc

with open('perks.json', 'w') as f:
    f.write(json.dumps(output, indent=4))
