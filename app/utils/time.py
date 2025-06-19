import ntplib
from datetime import datetime, timedelta, timezone

def get_ntp_time():
    try:
        client = ntplib.NTPClient()
        response = client.request('pool.ntp.org', version=3)
        now_utc = datetime.fromtimestamp(response.tx_time, tz=timezone.utc)
        return now_utc.astimezone(timezone(timedelta(hours=7)))
    except:
        return datetime.now(timezone(timedelta(hours=7)))
