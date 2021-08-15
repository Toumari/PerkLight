import hashlib
import json
import logging
import os
import re
import shutil
import sys

from bs4 import BeautifulSoup
import requests


logger = logging.getLogger(__name__)
logger.addHandler(logging.StreamHandler(sys.stdout))
logger.setLevel(logging.INFO)


class DBDPerksScraper():

    def scrape(self):
        return {
            'survivor': self._scrape_perks('https://deadbydaylight.fandom.com/wiki/Template:Perks_Survivor'),
            'killer': self._scrape_perks('https://deadbydaylight.fandom.com/wiki/Template:Perks_Killer')
        }

    def _scrape_perks(self, perk_url):
        logger.info(f'loading web page {perk_url}')
        page = requests.get(perk_url)
        soup = BeautifulSoup(page.text, 'html.parser')
        rows = soup.table.tbody('tr')
        logger.info(f'found {len(rows) - 1} rows in perk table')

        data = []

        for row in rows[1:]:
            cols = row(['td', 'th'])

            # remove non-breaking-space, newline, and whatever \xa0 is from perk name
            name = re.sub(r'\n|&nbsp;|\xa0', '', cols[1].text)
            # remove non-breaking-space and whatever \xa0 is from perk description. strip leading and trailing newlines
            desc = re.sub(r'&nbsp;|\xa0', ' ', cols[2].text.strip('\n'))
            # replace instances of 2 or more consecutive newlines/spaces with just 1
            desc = re.sub(r'(\n| ){2,}', r'\1', desc)
            # remove unnecessary space before a comma or full-stop
            desc = re.sub(r' (,|\.)', r'\1', desc)
            # lowercase the perk name and then hash it to use as an id (more reliable than using index in table?)
            id = hashlib.sha1(name.lower().encode()).hexdigest()

            logger.info(f'found perk "{name}"')

            icon_url = cols[0].a['href']

            data.append({
                'id': id,
                'icon_url': icon_url,
                'name': name,
                'description': desc
            })
        return data


def _write_out_results(results):
    cwd = os.path.dirname(os.path.realpath(__file__))
    output_file_path = os.path.realpath(f'{cwd}\\..\\assets\\data\\perks.json')
    with open(output_file_path, 'w', encoding='utf-8', newline='\n') as f:
        f.write(json.dumps(results, indent=2, ensure_ascii=False))


if __name__ == '__main__':
    scraper = DBDPerksScraper()
    perks = scraper.scrape()
    _write_out_results(perks)
