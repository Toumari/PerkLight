import hashlib
import json
import os
import re

from bs4 import BeautifulSoup
import requests

from logger import logger


logger.name = __file__

class DBDCharactersScraper():

    def scrape(self):
        return {
            'survivor': self._scrape_characters('https://deadbydaylight.fandom.com/wiki/Survivors'),
            'killer': self._scrape_characters('https://deadbydaylight.fandom.com/wiki/Killers')
        }

    def _scrape_characters(self, page_url):
        logger.info(f'loading web page {page_url}')
        page = requests.get(page_url)
        soup = BeautifulSoup(page.text, 'html.parser')

        list_header = soup.find('span', attrs={'id': f'List_of_{page_url.split("/")[-1]}'})

        character_list = list_header.parent.find_next_sibling('div').contents
        character_url_list = [f'{"/".join(page_url.split("/")[:-2])}{character.a["href"]}' for character in character_list]

        logger.info(f'found {len(character_url_list)} characters')

        data = []

        for character_url in character_url_list:
            logger.info(f'loading web page {character_url}')
            character_page = requests.get(character_url)
            character_soup = BeautifulSoup(character_page.text, 'html.parser')

            name = character_soup.find('h1', attrs={'id': 'firstHeading'}).text
            # remove leading and trailing whitespace
            name = name.strip()

            starting_point = character_soup.find('span', attrs={'id': 'Lore'}).parent.find_next_sibling('p')
            desc = starting_point.text

            icon_url = character_soup.find('table', attrs={'class': 'infoboxtable'})('a')[0]['href']

            # while not (starting_point.next_sibling.name == 'div' and starting_point.next_sibling['style'] == 'clear:both'):
            #     desc += starting_point.next_sibling.text
            #     starting_point = starting_point.next_sibling

            # lowercase the perk name and then hash it to use as an id (more reliable than using index in table?)
            id = hashlib.sha1(name.lower().encode()).hexdigest()

            data.append({
                'id': id,
                'name': name,
                'description': desc,
                'iconUrl': icon_url
            })

        return data


def _write_out_results(results):
    cwd = os.path.dirname(os.path.realpath(__file__))
    json_path = os.path.realpath(f'{cwd}\\..\\assets\\data\\characters.json')
    with open(json_path, 'w', encoding='utf-8', newline='\n') as f:
        logger.info(f'writing out data to "{json_path}"')
        f.write(json.dumps(results, indent=2, ensure_ascii=False))


if __name__ == '__main__':
    scraper = DBDCharactersScraper()
    items = scraper.scrape()
    _write_out_results(items)
