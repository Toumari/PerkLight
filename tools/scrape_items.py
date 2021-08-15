import hashlib
import json
import os
import re

from bs4 import BeautifulSoup
import requests

from logger import logger


logger.name = __file__

class DBDItemsScraper():

    def scrape(self):
        item_url = 'https://deadbydaylight.fandom.com/wiki/Items'
        logger.info(f'loading web page {item_url}')
        page = requests.get(item_url)
        soup = BeautifulSoup(page.text, 'html.parser')
        rows = soup('table')[3]('tr')

        data = {}

        current_category = None
        item_count = 0

        for row in rows:
            if row.th and row.th.get('colspan'):
                current_category = re.sub(r'\n|&nbsp;|\xa0|-', '', row.th.text).lower()
                if re.search(r'unused items', current_category, re.IGNORECASE):
                    break
                logger.info(f'found category of items "{current_category}"')
                data[current_category] = []

            elif row.td and row.td.get('colspan'):
                continue

            else:
                cols = row(['th', 'td'])

                # remove non-breaking-space, newline, and whatever \xa0 is from perk name
                name = re.sub(r'\n|&nbsp;|\xa0', '', cols[1].text)
                # some of the items have "(item)" at the end of the name, so let's remove that
                name = re.sub(r' \(item\)$', '', name, flags=re.IGNORECASE)
                # remove non-breaking-space and whatever \xa0 is from perk description. strip leading and trailing newlines
                desc = re.sub(r'&nbsp;|\xa0', ' ', cols[2].text.strip('\n'))
                # replace instances of 2 or more consecutive newlines/spaces with just 1
                desc = re.sub(r'(\n| ){2,}', r'\1', desc)
                # remove unnecessary space before a comma or full-stop
                desc = re.sub(r' (,|\.)', r'\1', desc)
                # lowercase the perk name and then hash it to use as an id (more reliable than using index in table?)
                id = hashlib.sha1(name.lower().encode()).hexdigest()

                logger.info(f'found item "{name}"')

                icon_url = cols[0].a['href']

                item_count += 1
                data[current_category].append({
                    'id': id,
                    'iconUrl': icon_url,
                    'name': name,
                    'description': desc
                })

        logger.info(f'found {len(data.keys())} item categories in item table')
        logger.info(f'found {item_count} items across categories')
        return data


def _write_out_results(results):
    cwd = os.path.dirname(os.path.realpath(__file__))
    json_path = os.path.realpath(f'{cwd}\\..\\assets\\data\\items.json')
    with open(json_path, 'w', encoding='utf-8', newline='\n') as f:
        logger.info(f'writing out data to "{json_path}"')
        f.write(json.dumps(results, indent=2, ensure_ascii=False))


if __name__ == '__main__':
    scraper = DBDItemsScraper()
    items = scraper.scrape()
    _write_out_results(items)
