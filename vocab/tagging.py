import nltk
from nltk import word_tokenize
from xml.dom.minidom import Document, parseString

f =open('sample2')
sentences=f.read()
tagged = nltk.sent_tokenize(sentences.strip())
tagged = [nltk.word_tokenize(sent) for sent in tagged]
tagged = [nltk.pos_tag(sent) for sent in tagged]
f.close()

output_file = open('output.txt', 'w')
tmp=""
for tup in tagged:
    tmp= " ".join(word+"/"+tag for word, tag in tup, file=output_file)
output_file.write(tmp)
output_file.close()

# Write to xml string
doc = Document()

base = doc.createElement("Document")
doc.appendChild(base)

headline = doc.createElement("headline")
htext = doc.createTextNode("Article Headline")
headline.appendChild(htext)
base.appendChild(headline)

body = doc.createElement("body")
btext = doc.createTextNode(sentences)
headline.appendChild(btext)
base.appendChild(body)

pos_tags = doc.createElement("pos_tags")
tagtext = doc.createTextNode(repr(tagged))
pos_tags.appendChild(tagtext)
base.appendChild(pos_tags)

xmlstring = doc.toxml()

# Read back tagged

doc2 = parseString(xmlstring)
el = doc2.getElementsByTagName("pos_tags")[0]
text = el.firstChild.nodeValue
tagged2 = eval(text)

print "Equal? ", tagged == tagged2