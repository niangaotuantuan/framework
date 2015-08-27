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
