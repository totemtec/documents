import dns.message
import requests
import base64
import json

doh_url = "https://dns.totemtec.com:1053/dns-query"
# doh_url = "https://dns.alidns.com/dns-query"
domain = "test.local"
rr = "A"
result = []

################################
## 此脚本 还未完成测试
################################

message = dns.message.make_query(domain, rr)
dns_req = base64.b64encode(message.to_wire()).decode("UTF8").rstrip("=")
# dns_req = 'xzEBAAABAAAAAAAAA3d3dwZ0YW9iYW8DY29tAAABAAE'
r = requests.get(doh_url + "?dns=" + dns_req,
                 headers={"Content-type": "application/dns-message"})
for answer in dns.message.from_wire(r.content).answer:
    dns = answer.to_text().split()
    result.append({"Query": dns[0], "TTL": dns[1], "RR": dns[3], "Answer": dns[4]})
    print(json.dumps(result))