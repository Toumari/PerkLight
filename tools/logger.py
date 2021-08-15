import logging
import sys

logger = logging.getLogger(__file__)

formatter = logging.Formatter('[%(asctime)s][%(name)s][%(levelname)s] %(message)s')

stdout_handler = logging.StreamHandler(sys.stdout)
stdout_handler.setLevel(logging.INFO)
stdout_handler.setFormatter(formatter)

logger.addHandler(stdout_handler)
logger.setLevel(logging.INFO)


if __name__ == '__main__':
    logger.info('It works!')
