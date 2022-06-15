import nltk

from nltk.tokenize.punkt import PunktSentenceTokenizer, PunktLanguageVars

class BulletPointLangVars(PunktLanguageVars):
    sent_end_chars = ('.', '?', '!', ':')

tokenizer = PunktSentenceTokenizer(lang_vars = BulletPointLangVars())


f = open('prova.txt', 'rU')
raw = f.read()
#sents = sent_tokenize(raw)
sents = tokenizer.tokenize(raw)
for s in sents: 
#	print("----------------------------------------")
	print(s.encode("unicode_escape").decode("utf-8"))
