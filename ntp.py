import ntplib
from time import ctime

client = ntplib.NTPClient()
response = client.request('pool.ntp.org')
print(ctime(response.tx_time))
