import argparse
import json
import logging
import os
import re
import shutil
import sys

import requests


logger = logging.getLogger(__name__)
logger.addHandler(logging.StreamHandler(sys.stdout))
logger.setLevel(logging.INFO)


def main(args):
    # get absolute path to current working directory
    cwd = os.path.dirname(os.path.realpath(__file__))
    # get absolute path to perk image folder
    icon_base_path = os.path.realpath(f'{cwd}\\..\\assets\\images\\perks\\')
    perks_json_path = os.path.realpath(f'{cwd}\\..\\assets\\data\\perks.json')

    # if --json-only flag specified, do not download the images. This is useful if you already downloaded them once
    if not args.json_only:
        # remove existing perk image folder and all files within
        shutil.rmtree(icon_base_path)
        # remake the folder with nothing in it
        os.mkdir(icon_base_path)

    # read the perks.json file so we can get the URLs for the perk icons, and the IDs of the perks
    with open(perks_json_path, 'r', encoding='utf-8') as f:
        data = json.loads(f.read())

    # perks.json: { 'survivor': [ perks ]: 'killer': [ perks ] }
    for team in data:
        for perk in data[team]:

            if args.json_only:
                for icon_type in ['png', 'jpg', 'gif']:
                    if os.path.exists(f'{icon_base_path}\\{perk["id"]}.{icon_type}'):
                        perk['iconFilename'] = f'{perk["id"]}.{icon_type}'

            else:
                logger.info(f'loading image {perk["icon_url"]}')
                icon_request = requests.get(perk['icon_url'])
                # content-type is like "image/png" so strip "image/" from beginning
                icon_type = re.sub(r'^image/', '', icon_request.headers['content-type'])
                # absolute path of this individual perk icon file using perk id for the name
                icon_absolute_path = f'{icon_base_path}\\{perk["id"]}.{icon_type}'

                # write image content to file
                with open(icon_absolute_path, 'wb') as f:
                    f.write(icon_request.content)

                # save icon type to json, just in case they're not all "png"s
                perk['iconFilename'] = f'{perk["id"]}.{icon_type}'

    # rewrite the perks.json file, now with icon_type field
    with open(perks_json_path, 'w', encoding='utf-8', newline='\n') as f:
        f.write(json.dumps(data, indent=2, ensure_ascii=False))


if __name__ == '__main__':
    parser = argparse.ArgumentParser()
    parser.add_argument('-j', '--json-only', dest='json_only', action='store_true')
    args = parser.parse_args()
    main(args)
