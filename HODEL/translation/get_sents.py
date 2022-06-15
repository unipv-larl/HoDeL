import nltk
from nltk import sent_tokenize

f = open('prova.txt', 'rU')
raw = f.read()
sents = sent_tokenize(raw)
for s in sents: 
	print(s.encode("unicode_escape").decode("utf-8"))
