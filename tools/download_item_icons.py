import argparse
import json
import os
import re
import shutil

import requests

from logger import logger


logger.name = __file__


def main(args):
    # get absolute path to current working directory
    cwd = os.path.dirname(os.path.realpath(__file__))
    # get absolute path to perk image folder
    icon_base_path = os.path.realpath(f'{cwd}\\..\\assets\\images\\items\\')
    json_path = os.path.realpath(f'{cwd}\\..\\assets\\data\\items.json')

    # if --json-only flag specified, do not download the images. This is useful if you already downloaded them once
    if args.clean:
        # remove existing perk image folder and all files within
        shutil.rmtree(icon_base_path)

    if not os.path.exists(icon_base_path):
        # remake the folder with nothing in it
        os.mkdir(icon_base_path)

    # read the items.json file so we can get the URLs for the perk icons, and the IDs of the items
    with open(json_path, 'r', encoding='utf-8') as f:
        data = json.loads(f.read())

    # items.json: { 'craftable & limited items': [ items ]: 'firecrackers': [ items ] }
    for category in data:
        for item in data[category]:

            icon_exists = False
            for icon_type in ['png', 'gif', 'jpg']:
                icon_absolute_path = f'{icon_base_path}\\{item["id"]}.{icon_type}'
                if os.path.exists(icon_absolute_path):
                    icon_exists = True
                    logger.info(f'found existing image "{icon_absolute_path}"')
                    logger.info(f'updating item "{item["id"]}"')
                    item['iconFilename'] = f'{item["id"]}.{icon_type}'

            if not icon_exists:
                logger.info(f'loading image "{item["iconUrl"]}"')
                icon_request = requests.get(item['iconUrl'])
                # content-type is like "image/png" so strip "image/" from beginning
                icon_type = re.sub(r'^image/', '', icon_request.headers['content-type'])
                # absolute path of this individual item icon file using item id for the name
                icon_absolute_path = f'{icon_base_path}\\{item["id"]}.{icon_type}'

                # write image content to file
                with open(icon_absolute_path, 'wb') as f:
                    f.write(icon_request.content)

                # save icon type to json, just in case they're not all "png"s
                item['iconFilename'] = f'{item["id"]}.{icon_type}'

    # rewrite the items.json file, now with icon_type field
    with open(json_path, 'w', encoding='utf-8', newline='\n') as f:
        logger.info(f'writing out item data to "{json_path}"')
        f.write(json.dumps(data, indent=2, ensure_ascii=False))


if __name__ == '__main__':
    parser = argparse.ArgumentParser()
    parser.add_argument('-c', '--clean', action='store_true')
    args = parser.parse_args()
    main(args)
