import glob
import os
import pandas as pd

from acdh_tei_pyutils.tei import TeiReader

files = sorted(glob.glob('./data/editions/*.xml'))
chars = 0
data = []
for x in files:
    _, tail = os.path.split(x)
    doc_id = f"https://grundbuecher.acdh.oeaw.ac.at/{tail.replace('.xml', '.html')}"
    doc = TeiReader(x)
    try:
        entry = doc.any_xpath('.//tei:div[@type="entry"]')[0]
    except IndexError:
        print(x)
        continue
    char_count = " ".join(''.join(entry.itertext()).split())
    chars = chars + len(char_count)
    item = {}
    item['id'] = doc_id
    item['chars'] = len(char_count)
    data.append(item)

doc = TeiReader('./data/meta/about.xml')
entry = doc.any_xpath('.//tei:body')[0]
char_count = " ".join(''.join(entry.itertext()).split())
chars = chars + len(char_count)
item = {
    "id": 'https://grundbuecher.acdh.oeaw.ac.at/about.html',
    "chars": len(char_count)
}
data.append(item)
df = pd.DataFrame(data)
df.to_csv('chars.csv', index=False)
print(f"all chars: {chars}")