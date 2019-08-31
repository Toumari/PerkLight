import requests
from bs4 import BeautifulSoup
import json


data = {}
data['survivors'] = []
data['killers'] = []

SurvivorNameList = [
'Dwight_Fairfield','Meg_Thomas','Claudette_Morel','Jake_Park','Nea Karlsson','Laurie_Strode','Ace_Visconti','Bill_Overbeck','Feng_Min','David_King','Quentin_Smith','David_Tapp','Kate_Denson','Adam_Francis','Jeff_Johansen','Jane_Romero','Ash_Williams'
]

KillerNameList = [
'Evan_MacMillan','Philip_Ojomo','Max_Thompson_Jr.','Sally_Smithson','Michael_Myers','Lisa_Sherwood','Herman_Carter','Anna','Bubba_Sawyer','Freddy_Krueger','Amanda_Young','Jeffrey_Hawk','Rin_Yamaoka','F._J._S._J.','Adiris'
]

#the Wiki has changed its formatting for the latest killer which leads me to believe eventually we'll have to handle new survivors going forward in this manner.
specialSurvivorList = []
specialKillerList = ['Danny_"Jed_Olsen"_Johnson']

#'Philip_Ojomo','Max_Thompson_Jr.','Sally_Smithson','Michael_Myers','Lisa_Sherwood','Herman_Carter','Anna','Bubba_Sawyer','Freddy_Krueger','Amanda_Young','Jeffrey_Hawk','Rin_Yamaoka','F._J._S._J.','Adiris','Danny_"Jed_Olsen"_Johnson'

for name in SurvivorNameList:
    page = requests.get('https://deadbydaylight.gamepedia.com/' + name)
    soup = BeautifulSoup(page.text, 'html.parser')

    current_element = soup.find(id='Lore').find_parent('h2').find_next_sibling()
    current_element = current_element.find_next('p')

    characterName = []
    characterDescription = []

    while(current_element.name) == 'p':
        input = current_element.text.strip('\n').replace('&nbsp;',' ').replace('\xa0', ' ').replace('"','""')
        characterDescription.append(input)
        current_element = current_element.find_next_sibling()

    characterName = soup.find(id='firstHeading').text
    print(characterName)
    finishedString = ''.join(characterDescription)

    data['survivors'].append({
        'name': characterName,
        'description': finishedString
    })


for name in KillerNameList:
    page = requests.get('https://deadbydaylight.gamepedia.com/' + name)
    soup = BeautifulSoup(page.text, 'html.parser')

    current_element = soup.find(id='Lore').find_parent('h2').find_next_sibling()
    current_element = current_element.find_next('p')

    characterName = []
    characterDescription = []

    while(current_element.name) == 'p':
        input = current_element.text.strip('\n').replace('&nbsp;',' ').replace('\xa0', ' ').replace('"','""')
        characterDescription.append(input)
        current_element = current_element.find_next_sibling()

    characterName = soup.find(id='firstHeading').text
    print(characterName)
    finishedString = ''.join(characterDescription)

    data['killers'].append({
        'name': characterName,
        'description': finishedString
    })


with open('characters.json','w') as outfile:
    json.dump(data,outfile, indent=4)

    





