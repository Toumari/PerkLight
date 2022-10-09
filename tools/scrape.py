import html
import json
import logging
import re
from typing import (
    Any,
    Dict,
    List
)

from bleach import clean
from bs4 import BeautifulSoup
from marshmallow import Schema, fields
import requests


logging.basicConfig(level=logging.INFO)
logger = logging.getLogger(__name__)


class PerkSchema(Schema):
    id = fields.Integer()
    name = fields.String()
    description = fields.String()
    iconFilename = fields.String()
    iconURL = fields.String()

    class Meta:
        ordered = True


perkSchema = PerkSchema()


class PerkFileSchema(Schema):
    survivor = fields.List(fields.Nested(PerkSchema(exclude=['iconURL'])))
    killer = fields.List(fields.Nested(PerkSchema(exclude=['iconURL'])))

    class Meta:
        ordered = True


perkFileSchema = PerkFileSchema()


def main():
    perk_page_url = 'https://deadbydaylight.gamepedia.com/Perks'
    logger.info(f'Requesting perk page from "{perk_page_url}"')
    page = requests.get(perk_page_url)

    logger.info('Parsing page content')
    soup = BeautifulSoup(page.text, 'html.parser')

    output: Dict[str,List[Dict[str, Any]]] = {
        'survivor': [],
        'killer': []
    }

    tables = soup.find_all('table')

    survivor_table = tables[0]
    killer_table = tables[1]

    logger.info('Scraping Survivor Table')
    scrape_table(survivor_table, output['survivor'])
    logger.info('Scraping Killer Table')
    scrape_table(killer_table, output['killer'])

    write_out_results(output)


def scrape_table(in_table, out_list: List[Dict[str, Any]]) -> None:
    table_body = in_table.find('tbody')
    scrape_table_body(table_body, out_list)


def scrape_table_body(in_body, out_list: List[Dict[str, Any]]):
    table_rows = in_body.find_all('tr')

    for index, table_row in enumerate(table_rows[1:]):
        perk_name, perk_desc, perk_icon_url = scrape_table_row(table_row)
        logger.info(f'Found Perk "{perk_name}"')
        loaded_perk = {
            'id': index + 1,
            'name': perk_name,
            'description': perk_desc,
            'iconFilename': f'{index + 1}.png',
            'iconURL': perk_icon_url
        }
        out_list.append(loaded_perk)


def scrape_table_row(in_row):
    perk_name = in_row\
        .find_all('th')[1]\
        .text
    perk_name = re.sub(r'\n|&nbsp;|\xa0', '', perk_name)
    perk_name = html.unescape(clean(perk_name, tags=[], strip=True))
    
    perk_desc = in_row\
        .find('div', {'class': 'rawPerkDesc'})\
        .text
    perk_desc = re.sub(r'&nbsp;|\xa0|\\|\[|\]|\'', '', perk_desc.strip('\n'))
    perk_desc = html.unescape(clean(perk_desc, tags=[], strip=True))

    perk_icon_url = f'{in_row.find("img")["data-src"].split(".png")[0]}.png'
    
    return perk_name, perk_desc, perk_icon_url


def write_out_results(results):
    output_file_path = 'assets/data/perks.json'

    try:
        with open(output_file_path, 'r', encoding='utf-8') as f:
            raw_input = f.read()
    except FileNotFoundError:
        logger.info(f'Output file "{output_file_path}" doesn\'t exist so it will be created')
        with open(output_file_path, 'w', encoding='utf-8') as f:
            f.write(json.dumps(PerkFileSchema.dump(results), indent=4, ensure_ascii=False))
    else:
        logger.info(f'Output file "{output_file_path}" already exists so Perks will be merged')
        logger.info(f'Parsing contents of "{output_file_path}"')
        input = perkFileSchema.loads(raw_input)

        for type in ['survivor', 'killer']:
            highest_perk_id = max([i['id'] for i in input[type]])
            logger.info(f'Highest existing {type} Perk ID = {highest_perk_id}')
            for scraped_perk in results[type]:
                found = False
                for existing_perk in input[type]:
                    if existing_perk['name'] == scraped_perk['name']:
                        logger.info(f'"{existing_perk["name"]}" already exists. Scraped description will be merged')
                        scraped_perk['id'] = existing_perk['id']
                        scraped_perk['iconFilename'] = existing_perk['iconFilename']
                        found = True
                        break

                if not found:
                    highest_perk_id = highest_perk_id + 1
                    logger.info(f'"{scraped_perk["name"]}" not found and will be added with perk ID {highest_perk_id}')
                    scraped_perk['id'] = highest_perk_id
                    scraped_perk['iconFilename'] = f'{highest_perk_id}.png'

            for existing_perk in input[type]:
                found = False
                for scraped_perk in results[type]:
                    if scraped_perk['name'] == existing_perk['name']:
                        found = True
                        break

                if not found:
                    logger.warning(f'"{existing_perk["name"]}" not found in scraped data. This could mean that the perk has been removed from the game. It will however be added to "{output_file_path}"')
                    results[type].append(existing_perk)

            logger.info(f'Sorting {type} perks by ID')
            results[type].sort(key=lambda x: x['id'])

        logger.info(f'Writing perk data to "{output_file_path}"')
        with open(output_file_path, 'w', encoding='utf-8') as f:
            f.write(
                json.dumps(
                    perkFileSchema.dump(results),
                    indent=4,
                    ensure_ascii=False
                )
            )

    for type in ['survivor', 'killer']:
        logger.info(f'Downloading "{type}" icons')
        for perk in results[type]:
            if 'iconURL' not in perk:
                logger.info(f'"{perk["name"]}" does not have an iconURL')
                continue
            logger.info(f'Requesting perk icon from "{perk["iconURL"]}"')
            req = requests.get(perk['iconURL'], allow_redirects=True)
            icon_download_path = f'assets/images/{type}/{perk["iconFilename"]}'
            logger.info(f'Writing icon data to "{icon_download_path}"')
            with open(icon_download_path, 'wb') as f:
                f.write(req.content)


if __name__ == '__main__':
    logger.info('Starting Perk Scraper')
    main()
