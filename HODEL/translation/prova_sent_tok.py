import nltk

from nltk.tokenize.punkt import PunktSentenceTokenizer, PunktLanguageVars
from nltk import sent_tokenize

class BulletPointLangVars(PunktLanguageVars):
    sent_end_chars = ('.', '?', '!', ':')

tokenizer = PunktSentenceTokenizer(lang_vars = BulletPointLangVars())


#f = open('prova.txt', 'rU')
#raw = f.read()

raw = '''
In answer [5] to him spoke swift-footed Achilles: [10]
"Take heart, and speak out whatever oracle you know; for by Apollo, dear to Zeus, to whom you, 
Calchas, pray when you reveal oracles to the Danaans, no one, while I live and have sight on the earth, 
shall lay heavy hands on you beside the hollow ships, no one of the whole host of the Danaans, 
not even if you name Agamemnon, who now claims to be far the best of the Achaeans."
[15] Goodby Achilles!

'''

print("DEFAULT TOKENIZER:")
sents1 = sent_tokenize(raw)
for s in sents1: 
	print("----------------------------------------")
	print(s.encode("unicode_escape").decode("utf-8"))


print("MOD TOKENIZER:")
sents2 = tokenizer.tokenize(raw)
for s in sents2: 
	print("----------------------------------------")
	print(s.encode("unicode_escape").decode("utf-8"))
