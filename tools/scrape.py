import requests
from bs4 import BeautifulSoup
import json

def main():
    page = requests.get('https://deadbydaylight.gamepedia.com/Perks')
    soup = BeautifulSoup(page.text, 'html.parser')

    output = {'survivor': {}, 'killer': {}}
    
    killerTable = soup.find_all('table')[35]
    scrapeTable(killerTable, output['killer'])

    survivorTable = soup.find_all('table')[34]
    scrapeTable(survivorTable, output['survivor'])

    writeOutResults(output)

def scrapeTable(inTable, outDict):
    tableBody = inTable.find('tbody')
    scrapeTableBody(tableBody, outDict)

def scrapeTableBody(inBody, outDict):
    tableRows = inBody.find_all('tr')

    for tableRow in tableRows[1:]:
        scrapeTableRow(tableRow, outDict)

def scrapeTableRow(inRow, outDict):
    perkName = inRow.find_all('th')[1].get_text().replace('\n', '')
    perkDesc = inRow.find('td').get_text().strip('\n').replace('\n', ' ')
    outDict[perkName] = perkDesc

def writeOutResults(results):
    outputFilePath = 'assets/data/perks.json'
    with open(outputFilePath, 'r', encoding='utf-8') as f:
        rawInput = f.read()
    
    input = json.loads(rawInput)
    for type in ['survivor', 'killer']:
        for perk in input[type]:
            perk['description'] = results[type].get(perk['name'], 'This perk does not currently have a description.')
    
    with open(outputFilePath, 'w', encoding='utf-8') as f:
        f.write(json.dumps(input, indent=4, ensure_ascii=False))


if __name__ == '__main__':
    main()
