import dns.message
import requests
import base64
import json

doh_url = "https://dns.totemtec.com/dns-query"
domain = "test.aaa.com"
rr = "A"
result = []

## 这里消息加密了，看不懂

message = dns.message.make_query(domain, rr)
wired_message = message.to_wire()
dns_req = base64.b64encode(message.to_wire()).decode("UTF8").rstrip("=")
r = requests.get(doh_url + "?dns=" + dns_req,
                 headers={"Content-type": "application/dns-message"})
for answer in dns.message.from_wire(r.content).answer:
    dns = answer.to_text().split()
    result.append({"Query": dns[0], "TTL": dns[1], "RR": dns[3], "Answer": dns[4]})
    print(json.dumps(result))