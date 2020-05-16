import os
import urllib2    
import json
import logging
import traceback
from contextlib import closing

logging.basicConfig()
log = logging.getLogger()
log.setLevel(logging.INFO)

SLACK_DEBUG_URL =  os.environ['SLACK_DEBUG_URL']
SLACK_DEBUG_CHANNEL =  os.environ['SLACK_DEBUG_CHANNEL']
SLACK_AUTHOR = 'Duda-Ferreira'
app_name = 'APP-Test-tema05-python'
TIMEOUT_PER_REQUEST = 5


slack_channel = SLACK_DEBUG_CHANNEL
message       = os.popen('ps -o pid,comm -A').read()
author_name   = "Duda-Ferreira"
slack_url     = SLACK_DEBUG_URL


try:
    slack_headers = {'Content-type': 'application/json', 'Accept': 'application/json', 'User-Agent': 'custom agent'}
    color = "#FF00FF"
    data = \
        {
            "channel": slack_channel,
            "username": app_name,
            "attachments":
                [
                    {
                        "author_name": 'Notificacao',
                        "title": author_name,
                        "color": color,
                        "text": message,
                        "mrkdwn_in": ["text", "pretext"]
                    }
                ]
        }
    request = urllib2.Request(slack_url, json.dumps(data), headers=slack_headers)
    with closing(urllib2.urlopen(request, timeout=TIMEOUT_PER_REQUEST)) as response:
        the_page = response.read()
        log.debug("Slack response: '%s'", the_page)
except:
    log.error("Fail to send slack message, url: %s, channel: %s, message: %s\n\n%s", slack_url, slack_channel, message, traceback.format_exc())

    
