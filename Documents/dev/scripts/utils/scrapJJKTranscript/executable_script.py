import requests
from bs4 import BeautifulSoup
from tqdm import tqdm
import logging

# Set up logging
logging.basicConfig(level=logging.INFO, format='%(message)s')
logger = logging.getLogger()

# Function to fetch and parse a single chapter
def fetch_chapter(chapter_number):
    url = f"https://readjujutsukaisenmanga.net/jujutsu-kaisen-chapter-{chapter_number}/"
    response = requests.get(url)
    
    if response.status_code == 200:
        soup = BeautifulSoup(response.content, 'html.parser')
        content = soup.find('div', class_='entry-content')
        if content:
            return content.get_text(strip=True)
        else:
            logger.warning(f"Content not found for chapter {chapter_number}")
            return None
    else:
        logger.warning(f"Failed to retrieve chapter {chapter_number}")
        return None

# Function to scrape chapters from start to end
def scrape_manga(start_chapter, end_chapter):
    all_text = ""
    for chapter in tqdm(range(start_chapter, end_chapter + 1), desc="Scraping Chapters", unit="chapter"):
        chapter_text = fetch_chapter(chapter)
        if chapter_text:
            all_text += f"Chapter {chapter}\n{chapter_text}\n\n"
    
    # Save the collected text to a file
    with open("jujutsu_kaisen_chapters_211_to_271.txt", "w", encoding="utf-8") as file:
        file.write(all_text)
    logger.info("Scraping complete. Data saved to 'jujutsu_kaisen_chapters_211_to_271.txt'.")

# Run the scraper for chapters 211 to 271
scrape_manga(150, 271)
