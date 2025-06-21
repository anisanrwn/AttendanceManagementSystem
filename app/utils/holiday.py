import requests
from datetime import datetime, date

def fetch_national_holidays(year: int) -> set[date]:
    try:
        response = requests.get(f"https://dayoffapi.vercel.app/api?year={year}")
        if response.status_code == 200:
            holidays = response.json()
            return {
                datetime.strptime(item["tanggal"], "%Y-%m-%d").date()
                for item in holidays
            }
    except Exception as e:
        print("Error fetching holiday API:", e)
    return set()