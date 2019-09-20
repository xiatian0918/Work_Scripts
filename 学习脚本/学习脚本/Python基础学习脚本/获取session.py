import requests


sess = requests.post("https://192.168.0.24/rest/com/vmware/cis/session",  \
                     auth=('administrator@vsphere.local', 'Toprs!@#123'), verify=False)
session_id = sess.json()['value']

print(session_id)

# resp = requests.get("https://192.168.0.24/rest/vcenter/vm", verify=False, headers={
#     "vmware-api-session-id": session_id
# })
# print(u"resp.text = %s" % str(resp.text))