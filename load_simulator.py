import requests
import time
import threading
import sys


def send_request():
    requests.get("http://34.66.73.6/image-managing/v1/users", verify=False)


sys.stderr = None

t = time.time()

while True:
    threading.Thread(target=send_request, args=()).start()
    t += 0.5
    while time.time() < t:
        pass
