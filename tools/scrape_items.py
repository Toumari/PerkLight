import requests
from bs4 import BeautifulSoup
import json


data = {}
data['firecracker'] = []
data['flashlight'] = []
data['key'] = []
data['map'] = []
data['medkit'] = []
data['toolbox'] = []

firecrackers = ['Winter_Party_Starter','Chinese_Firecracker','Third_Year_Party_Starter']
flashlights = ['Flashlight_(Item)','Sport_Flashlight','Utility_Flashlight']
keys = ['Broken_Key','Dull_Key','Skeleton_Key']
maps = ['Map_(Item)','Rainbow_Map']
medkits = ['Camping_Aid_Kit','First_Aid_Kit','Emergency_Med-Kit','Ranger_Med-Kit',]
toolboxes = ['Worn-Out_Tools','Toolbox_(Item)','Mechanic%27s_Toolbox','Commodious_Toolbox','Engineer%27s_Toolbox','Alex%27s_Toolbox']

specialSurvivorList = []
specialKillerList = ['Danny_"Jed_Olsen"_Johnson']

for item in toolboxes:
    page = requests.get('https://deadbydaylight.gamepedia.com/' + item)
    soup = BeautifulSoup(page.text, 'html.parser')
    
    current_element = soup.find(id='mw-content-text').find_all('tr')[1].find_all('td')[1:2][0]
    input = current_element.text.replace('&nbsp;',' ').replace('\xa0', ' ').replace('\n',' ').replace('\u2014',' ').rstrip(' ')

    print(input)


    itemName = soup.find(id='firstHeading').text
    
    data['toolbox'].append({
        'name': itemName,
        'description': input,
        'imagePath': 'assets/images/items/' + item + '.png'
    })

for item in firecrackers:
    page = requests.get('https://deadbydaylight.gamepedia.com/' + item)
    soup = BeautifulSoup(page.text, 'html.parser')
    
    current_element = soup.find(id='mw-content-text').find_all('tr')[1].find_all('td')[1:2][0]
    input = current_element.text.replace('&nbsp;',' ').replace('\xa0', ' ').replace('\n',' ').replace('\u2014',' ').rstrip(' ')

    print(input)


    itemName = soup.find(id='firstHeading').text
    
    data['firecracker'].append({
        'name': itemName,
        'description': input,
        'imagePath': 'assets/images/items/' + item + '.png'
    })

for item in flashlights:
    page = requests.get('https://deadbydaylight.gamepedia.com/' + item)
    soup = BeautifulSoup(page.text, 'html.parser')
    
    current_element = soup.find(id='mw-content-text').find_all('tr')[1].find_all('td')[1:2][0]
    input = current_element.text.replace('&nbsp;',' ').replace('\xa0', ' ').replace('\n',' ').replace('\u2014',' ').rstrip(' ')

    print(input)


    itemName = soup.find(id='firstHeading').text
    
    data['flashlight'].append({
        'name': itemName,
        'description': input,
        'imagePath': 'assets/images/items/' + item + '.png'
    })

for item in maps:
    page = requests.get('https://deadbydaylight.gamepedia.com/' + item)
    soup = BeautifulSoup(page.text, 'html.parser')
    
    current_element = soup.find(id='mw-content-text').find_all('tr')[1].find_all('td')[1:2][0]
    input = current_element.text.replace('&nbsp;',' ').replace('\xa0', ' ').replace('\n',' ').replace('\u2014',' ').rstrip(' ')

    print(input)


    itemName = soup.find(id='firstHeading').text
    
    data['map'].append({
        'name': itemName,
        'description': input,
        'imagePath': 'assets/images/items/' + item + '.png'
    })

for item in medkits:
    page = requests.get('https://deadbydaylight.gamepedia.com/' + item)
    soup = BeautifulSoup(page.text, 'html.parser')
    
    current_element = soup.find(id='mw-content-text').find_all('tr')[1].find_all('td')[1:2][0]
    input = current_element.text.replace('&nbsp;',' ').replace('\xa0', ' ').replace('\n',' ').replace('\u2014',' ').rstrip(' ')

    print(input)


    itemName = soup.find(id='firstHeading').text
    
    data['medkit'].append({
        'name': itemName,
        'description': input,
        'imagePath': 'assets/images/items/' + item + '.png'
    })

for item in keys:
    page = requests.get('https://deadbydaylight.gamepedia.com/' + item)
    soup = BeautifulSoup(page.text, 'html.parser')
    
    current_element = soup.find(id='mw-content-text').find_all('tr')[1].find_all('td')[1:2][0]
    input = current_element.text.replace('&nbsp;',' ').replace('\xa0', ' ').replace('\n',' ').replace('\u2014',' ').rstrip(' ')

    print(input)


    itemName = soup.find(id='firstHeading').text
    
    data['key'].append({
        'name': itemName,
        'description': input,
        'imagePath': 'assets/images/items/' + item + '.png'
    })



with open('items.json','w') as outfile:
    json.dump(data,outfile, indent=4)
