import json
import html
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


class PerkSchema(Schema):
    id = fields.Integer()
    name = fields.String()
    description = fields.String()
    iconFilename = fields.String()

    class Meta:
        ordered = True


perkSchema = PerkSchema()


class PerkFileSchema(Schema):
    survivor = fields.List(fields.Nested(PerkSchema()))
    killer = fields.List(fields.Nested(PerkSchema()))

    class Meta:
        ordered = True


perkFileSchema = PerkFileSchema()


def main():
    page = requests.get('https://deadbydaylight.gamepedia.com/Perks')
    soup = BeautifulSoup(page.text, 'html.parser')

    output: Dict[str,List[Dict[str, Any]]] = {
        'survivor': [],
        'killer': []
    }

    tables = soup.find_all('table')

    survivor_table = tables[0]
    killer_table = tables[1]

    scrape_table(survivor_table, output['survivor'])
    scrape_table(killer_table, output['killer'])

    write_out_results(output)


def scrape_table(in_table, out_list: List[Dict[str, Any]]) -> None:
    table_body = in_table.find('tbody')
    scrape_table_body(table_body, out_list)


def scrape_table_body(in_body, out_list: List[Dict[str, Any]]):
    table_rows = in_body.find_all('tr')

    for index, table_row in enumerate(table_rows[1:]):
        perk_name, perk_desc = scrape_table_row(table_row)
        loaded_perk = {
            'id': index + 1,
            'name': perk_name,
            'description': perk_desc,
            'iconFilename': f'{index + 1}.png'
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
    
    return perk_name, perk_desc


def write_out_results(results):
    output_file_path = 'assets/data/perks.json'

    try:
        with open(output_file_path, 'r', encoding='utf-8') as f:
            raw_input = f.read()
    except FileNotFoundError:
        # Perk file doesn't exist so just create one and dump the scraped perks
        with open(output_file_path, 'w', encoding='utf-8') as f:
            f.write(json.dumps(perkFileSchema.dump(results), indent=4, ensure_ascii=False))
    else:
        # File already exists, so update existing perk info and append new
        input = perkFileSchema.loads(raw_input)

        for type in ['survivor', 'killer']:

            highest_perk_id = max([i['id'] for i in input[type]])
            for scraped_perk in results[type]:
                found = False
                for existing_perk in input[type]:
                    if existing_perk['name'] == scraped_perk['name']:
                        # Perk already exists in JSON file so re-use the same ID and icon, but keep the scraped desc
                        scraped_perk['id'] = existing_perk['id']
                        scraped_perk['iconFilename'] = existing_perk['iconFilename']
                        found = True
                        break

                if not found:
                    highest_perk_id = highest_perk_id + 1
                    scraped_perk['id'] = highest_perk_id
                    scraped_perk['iconFilename'] = f'{highest_perk_id}.png'

            for existing_perk in input[type]:
                found = False
                for scraped_perk in results[type]:
                    if scraped_perk['name'] == existing_perk['name']:
                        found = True
                        break

                if not found:
                    results[type].append(existing_perk)

            results[type].sort(key=lambda x: x['id'])

        with open(output_file_path, 'w', encoding='utf-8') as f:
            f.write(
                json.dumps(
                    perkFileSchema.dump(results),
                    indent=4,
                    ensure_ascii=False
                )
            )


if __name__ == '__main__':
    main()
