DROP TABLE IF EXISTS temp_align;

       CREATE TABLE temp_align( 
         poem_id VARCHAR(60) NOT NULL,
         book_id int(10) unsigned NOT NULL,
         sent_start int(10) unsigned NOT NULL,
         sent_end int(10) unsigned NOT NULL,
         sent_en text NOT NULL DEFAULT '',
         KEY (poem_id,book_id,sent_start,sent_end)
      );
INSERT INTO temp_align(
        poem_id, book_id, sent_start, sent_end, sent_en) 
        VALUES 
('urn:cts:greekLit:tlg0012.tlg002.perseus-grc1',20,1,1,' But the goodly Odysseus lay down to sleep in the fore-hall of the house.'),
('urn:cts:greekLit:tlg0012.tlg002.perseus-grc1',20,2,3,' On the ground he spread an undressed ox-hide and above it many fleeces of sheep, which the Achaeans were wont to slay, '),
('urn:cts:greekLit:tlg0012.tlg002.perseus-grc1',20,4,4,' and Eurynome threw over him a cloak, when he had laid him down.'),
('urn:cts:greekLit:tlg0012.tlg002.perseus-grc1',20,5,6,'  There Odysseus, pondering in his heart evil for the wooers, lay sleepless.'),
('urn:cts:greekLit:tlg0012.tlg002.perseus-grc1',20,6,8,' And the women came forth from the hall, those that had before been wont to lie with the wooers, making laughter and merriment among themselves.'),
('urn:cts:greekLit:tlg0012.tlg002.perseus-grc1',20,9,9,' But the heart was stirred in his breast,'),
('urn:cts:greekLit:tlg0012.tlg002.perseus-grc1',20,10,13,' and much he debated in mind and heart, whether he should rush after them and deal death to each, or suffer them to lie with the insolent wooers for the last and latest time; and his heart growled within him. '),
('urn:cts:greekLit:tlg0012.tlg002.perseus-grc1',20,14,16,'And as a bitch stands over her tender whelps  growling, when she sees a man she does not know, and is eager to fight, so his heart growled within him in his wrath at their evil deeds;'),
('urn:cts:greekLit:tlg0012.tlg002.perseus-grc1',20,17,17,' but he smote his breast, and rebuked his heart, saying:'),
('urn:cts:greekLit:tlg0012.tlg002.perseus-grc1',20,18,18,'\n“Endure, my heart; '),
('urn:cts:greekLit:tlg0012.tlg002.perseus-grc1',20,18,18,'a worse thing even than this didst thou once endure '),
('urn:cts:greekLit:tlg0012.tlg002.perseus-grc1',20,19,20,'on that day when the Cyclops, unrestrained in daring, devoured my  mighty comrades; '),
('urn:cts:greekLit:tlg0012.tlg002.perseus-grc1',20,20,21,' but thou didst endure until craft got thee forth from the cave where thou thoughtest to die.\"'),
('urn:cts:greekLit:tlg0012.tlg002.perseus-grc1',20,22,22,'So he spoke, chiding the heart in his breast, '),
('urn:cts:greekLit:tlg0012.tlg002.perseus-grc1',20,23,24,'and his heart remained bound within him to endure steadfastly; '),
('urn:cts:greekLit:tlg0012.tlg002.perseus-grc1',20,24,24,'but he himself lay tossing this way and that.'),
('urn:cts:greekLit:tlg0012.tlg002.perseus-grc1',20,25,30,'  And as when a man before a great blazing fire turns swiftly this way and that a paunch full of fat and blood, and is very eager to have it roasted quickly, so Odysseus tossed from side to side, pondering how he might put forth his hands upon the shameless wooers,  one man as he was against so many.'),
('urn:cts:greekLit:tlg0012.tlg002.perseus-grc1',20,30,31,' Then Athena came down from heaven'),
('urn:cts:greekLit:tlg0012.tlg002.perseus-grc1',20,31,31,' and drew near to him in the likeness of a woman,'),
('urn:cts:greekLit:tlg0012.tlg002.perseus-grc1',20,32,32,'and she stood above his head, and spoke to him, and said:'),
('urn:cts:greekLit:tlg0012.tlg002.perseus-grc1',20,33,33,'\n“Why now again art thou wakeful, ill-fated above all men?'),
('urn:cts:greekLit:tlg0012.tlg002.perseus-grc1',20,34,35,' Lo, this is thy house, and here within is thy wife  and thy child, such a man, methinks, as anyone might pray to have for his son.”'),
('urn:cts:greekLit:tlg0012.tlg002.perseus-grc1',20,36,36,'And Odysseus of many wiles answered her, and said: '),
('urn:cts:greekLit:tlg0012.tlg002.perseus-grc1',20,37,37,' “Yea, goddess, all this hast thou spoken aright.'),
('urn:cts:greekLit:tlg0012.tlg002.perseus-grc1',20,38,40,'But the heart in my breast is pondering somewhat upon this, how I may put forth my hands upon the shameless wooers,  all alone as I am, '),
('urn:cts:greekLit:tlg0012.tlg002.perseus-grc1',20,40,40,'while they remain always in a body in the house. '),
('urn:cts:greekLit:tlg0012.tlg002.perseus-grc1',20,41,41,'And furthermore this other and harder thing I ponder in my mind:'),
('urn:cts:greekLit:tlg0012.tlg002.perseus-grc1',20,42,43,' even if I were to slay them by the will of Zeus and of thyself, where then should I find escape from bane?'),
('urn:cts:greekLit:tlg0012.tlg002.perseus-grc1',20,43,43,' Of this I bid thee take thought.” '),
('urn:cts:greekLit:tlg0012.tlg002.perseus-grc1',20,44,44,' \nThen the goddess, flashing-eyed Athena, answered him:'),
('urn:cts:greekLit:tlg0012.tlg002.perseus-grc1',20,45,46,'  “Obstinate one, many a man puts his trust even in a weaker friend than I am, one that is mortal, and knows not such wisdom as mine; '),
('urn:cts:greekLit:tlg0012.tlg002.perseus-grc1',20,47,48,' but I am a god, that guard thee to the end in all thy toils.'),
('urn:cts:greekLit:tlg0012.tlg002.perseus-grc1',20,48,48,' And I will tell thee openly; '),
('urn:cts:greekLit:tlg0012.tlg002.perseus-grc1',20,49,51,' if fifty troops of mortal men  should stand about us, eager to slay us in battle, even their cattle and goodly sheep shouldest thou drive off. '),
('urn:cts:greekLit:tlg0012.tlg002.perseus-grc1',20,52,52,' Nay, let sleep now come over thee.'),
('urn:cts:greekLit:tlg0012.tlg002.perseus-grc1',20,52,53,'There is weariness also in keeping wakeful watch the whole night through; and even now shalt thou come forth from out thy perils.\"'),
('urn:cts:greekLit:tlg0012.tlg002.perseus-grc1',20,54,55,'So she spoke, and shed sleep upon his eyelids,  but herself, the fair goddess, went back to Olympus.'),
('urn:cts:greekLit:tlg0012.tlg002.perseus-grc1',20,56,57,'Now while sleep seized him, loosening the cares of his heart, sleep that loosens the limbs of men, his true-hearted wife awoke, '),
('urn:cts:greekLit:tlg0012.tlg002.perseus-grc1',20,58,58,' and wept, as she sat upon her soft bed.'),
('urn:cts:greekLit:tlg0012.tlg002.perseus-grc1',20,59,60,' But when her heart had had its fill of weeping,  to Artemis first of all the fair lady made her prayer:'),
('urn:cts:greekLit:tlg0012.tlg002.perseus-grc1',20,61,65,'\n“Artemis, mighty goddess, daughter of Zeus, would that now thou wouldest fix thy arrow in my breast and take away my life even in this hour; or that a storm-wind might catch me up and bear me hence over the murky ways,  and cast me forth at the mouth of backward-flowing Oceanus,'),
('urn:cts:greekLit:tlg0012.tlg002.perseus-grc1',20,66,66,' even as on a time storm-winds bore away the daughters of Pandareus.'),
('urn:cts:greekLit:tlg0012.tlg002.perseus-grc1',20,67,69,' Their parents the gods had slain, and they were left orphans in the halls, and fair Aphrodite tended them with cheese, and sweet honey, and pleasant wine,'),
('urn:cts:greekLit:tlg0012.tlg002.perseus-grc1',20,70,72,' and Here gave them beauty and wisdom above all women, and chaste Artemis gave them stature, and Athena taught them skill in famous handiwork. '),
('urn:cts:greekLit:tlg0012.tlg002.perseus-grc1',20,73,78,'But while beautiful Aphrodite was going to high Olympus to ask for the maidens the accomplishment of gladsome marriage—  going to Zeus who hurls the thunderbolt, for well he knows all things, both the happiness and the haplessness of mortal men—meanwhile the spirits of the storm snatched away the maidens and gave them to the hateful Erinyes to deal with.'),
('urn:cts:greekLit:tlg0012.tlg002.perseus-grc1',20,79,82,' Would that even so those who have dwellings on Olympus would blot me from sight,  or that fair-tressed Artemis would smite me, so that with Odysseus before my mind I might even pass beneath the hateful earth, and never gladden in any wise the heart of a baser man. '),
('urn:cts:greekLit:tlg0012.tlg002.perseus-grc1',20,83,87,'Yet when a man weeps by day with a heart sore distressed,  but at night sleep holds him, this brings with it an evil that may well be borne—for sleep makes one forget all things, the good and the evil, when once it envelops the eyelids—but upon me a god sends evil dreams as well.'),
('urn:cts:greekLit:tlg0012.tlg002.perseus-grc1',20,88,89,' For this night again there lay by my side one like him, even such as he was when he went forth with the host,  '),
('urn:cts:greekLit:tlg0012.tlg002.perseus-grc1',20,89,90,'and my heart  was glad, for I deemed it was no dream, but the truth at last.”'),
('urn:cts:greekLit:tlg0012.tlg002.perseus-grc1',20,91,91,' \nSo she spoke, and straightway came golden-throned Dawn.'),
('urn:cts:greekLit:tlg0012.tlg002.perseus-grc1',20,92,92,' But as she wept goodly Odysseus heard her voice, '),
('urn:cts:greekLit:tlg0012.tlg002.perseus-grc1',20,93,94,'and thereupon he mused, and it seemed to his heart that she knew him and was standing by his head.'),
('urn:cts:greekLit:tlg0012.tlg002.perseus-grc1',20,95,97,'  Then he gathered up the cloak and the fleeces on which he was lying and laid them on a chair in the hall, and carried the ox-hide out of doors and set it down; and he lifted up his hands and prayed to Zeus:'),
('urn:cts:greekLit:tlg0012.tlg002.perseus-grc1',20,98,101,'\n“Father Zeus, if of your good will ye gods have brought me over land and sea to my own country, when ye had afflicted me sore,  let some one of those who are awaking utter a word of omen for me within, and without let a sign from Zeus be shown besides.\"'),
('urn:cts:greekLit:tlg0012.tlg002.perseus-grc1',20,102,102,'So he spoke in prayer,'),
('urn:cts:greekLit:tlg0012.tlg002.perseus-grc1',20,102,104,' and Zeus the counsellor heard him. Straightway he thundered from gleaming Olympus, from on high from out the clouds; '),
('urn:cts:greekLit:tlg0012.tlg002.perseus-grc1',20,104,104,'and goodly Odysseus was glad. '),
('urn:cts:greekLit:tlg0012.tlg002.perseus-grc1',20,105,108,'   And a woman, grinding at the mill, uttered a word of omen from within the house hard by, where the mills of the shepherd of the people were set. At these mills twelve women in all were wont to ply their tasks, making meal of barley and of wheat, the marrow of men. '),
('urn:cts:greekLit:tlg0012.tlg002.perseus-grc1',20,109,110,' Now the others were sleeping, for they had ground their wheat,  but she alone had not yet ceased, for she was the weakest of all. '),
('urn:cts:greekLit:tlg0012.tlg002.perseus-grc1',20,111,111,'She now stopped her mill and spoke a word, a sign for her master:'),
('urn:cts:greekLit:tlg0012.tlg002.perseus-grc1',20,112,114,' \n“Father Zeus, who art lord over gods and men, verily loud hast thou thundered from the starry sky, yet nowhere is there any cloud:'),
('urn:cts:greekLit:tlg0012.tlg002.perseus-grc1',20,114,114,'surely this is a sign that thou art showing to some man.'),
('urn:cts:greekLit:tlg0012.tlg002.perseus-grc1',20,115,115,' Fulfil now even for wretched me the word that I shall speak.'),
('urn:cts:greekLit:tlg0012.tlg002.perseus-grc1',20,116,118,' May the wooers this day for the last and latest time hold their glad feast in the halls of Odysseus. They that have loosened my limbs with bitter labour,'),
('urn:cts:greekLit:tlg0012.tlg002.perseus-grc1',20,118,119,' as I made them barley meal, '),
('urn:cts:greekLit:tlg0012.tlg002.perseus-grc1',20,119,119,'may they now sup their last.”'),
('urn:cts:greekLit:tlg0012.tlg002.perseus-grc1',20,120,121,'  So she spoke, and goodly Odysseus was glad at the word of omen and at the thunder of Zeus, '),
('urn:cts:greekLit:tlg0012.tlg002.perseus-grc1',20,121,121,'for he thought he had gotten vengeance on the guilty.'),
('urn:cts:greekLit:tlg0012.tlg002.perseus-grc1',20,122,123,'Now the other maidens in the fair palace of Odysseus had gathered together and were kindling on the hearth unwearied fire,'),
('urn:cts:greekLit:tlg0012.tlg002.perseus-grc1',20,124,125,' and Telemachus rose from his bed, a godlike man,  and put on his clothing. '),
('urn:cts:greekLit:tlg0012.tlg002.perseus-grc1',20,125,125,' He slung his sharp sword about his shoulder, '),
('urn:cts:greekLit:tlg0012.tlg002.perseus-grc1',20,126,127,'and beneath his shining feet he bound his fair sandals; and he took his mighty spear,  '),
('urn:cts:greekLit:tlg0012.tlg002.perseus-grc1',20,127,127,'tipped with sharp bronze,'),
('urn:cts:greekLit:tlg0012.tlg002.perseus-grc1',20,128,128,'and went and stood upon the threshold, and spoke to Eurycleia:'),
('urn:cts:greekLit:tlg0012.tlg002.perseus-grc1',20,129,130,'“Dear nurse, have ye honored the stranger in our house  with bed and food, or does he lie all uncared for? '),
('urn:cts:greekLit:tlg0012.tlg002.perseus-grc1',20,131,131,'For such is my mother\'s way, wise though she is:'),
('urn:cts:greekLit:tlg0012.tlg002.perseus-grc1',20,132,132,' in wondrous fashion she honours one of mortal men,'),
('urn:cts:greekLit:tlg0012.tlg002.perseus-grc1',20,133,133,' \n though he be the worse, while the better she sends unhonored away.” '),
('urn:cts:greekLit:tlg0012.tlg002.perseus-grc1',20,134,134,' \nThen wise Eurycleia answered him:'),
('urn:cts:greekLit:tlg0012.tlg002.perseus-grc1',20,135,135,'  “In this matter, child, thou shouldest not blame her, who is without blame.'),
('urn:cts:greekLit:tlg0012.tlg002.perseus-grc1',20,136,137,' He sat here and drank wine as long as he would, but for food he said he had no more hunger,'),
('urn:cts:greekLit:tlg0012.tlg002.perseus-grc1',20,137,137,' for she asked him. '),
('urn:cts:greekLit:tlg0012.tlg002.perseus-grc1',20,138,143,' But when he bethought him of rest and sleep, she bade the maidens strew his bed.\n But he, as one wholly wretched and hapless, would not sleep on a bed and under blankets, but on an undressed ox-hide and fleeces of sheep he slept in the fore-hall, '),
('urn:cts:greekLit:tlg0012.tlg002.perseus-grc1',20,143,143,'and we flung over him a cloak.\"'),
('urn:cts:greekLit:tlg0012.tlg002.perseus-grc1',20,144,145,'So she spoke, and Telemachus went forth through the hall  with his spear in his hand, and with him went two swift hounds.'),
('urn:cts:greekLit:tlg0012.tlg002.perseus-grc1',20,146,146,' And he went his way to the place of assembly to join the company of the well-greaved Achaeans,'),
('urn:cts:greekLit:tlg0012.tlg002.perseus-grc1',20,147,148,' but Eurycleia, the goodly lady, daughter of Ops, son of Peisenor, called to her maidens, saying:'),
('urn:cts:greekLit:tlg0012.tlg002.perseus-grc1',20,149,151,'“Come, let some of you busily sweep the hall  and sprinkle it, and throw on the shapely chairs coverlets of purple, '),
('urn:cts:greekLit:tlg0012.tlg002.perseus-grc1',20,151,153,'  and let others wipe all the tables with sponges and cleanse the mixing-bowls and the well-wrought double cups,'),
('urn:cts:greekLit:tlg0012.tlg002.perseus-grc1',20,153,154,'and others still go to the spring for water and bring it quickly here.'),
('urn:cts:greekLit:tlg0012.tlg002.perseus-grc1',20,155,156,'  For the wooers will not long be absent from the hall, but will return right early; for it is a feast-day for all men.\"'),
('urn:cts:greekLit:tlg0012.tlg002.perseus-grc1',20,157,157,'So she spoke, and they readily hearkened and obeyed.'),
('urn:cts:greekLit:tlg0012.tlg002.perseus-grc1',20,158,159,' Twenty of them went to the spring of dark water, and the others busied themselves there in the house in skilful fashion.'),
('urn:cts:greekLit:tlg0012.tlg002.perseus-grc1',20,160,160,'  Then in came the serving-men of the Acheans, '),
('urn:cts:greekLit:tlg0012.tlg002.perseus-grc1',20,160,162,'who thereafter split logs of wood well and skilfully; and the women came back from the spring.'),
('urn:cts:greekLit:tlg0012.tlg002.perseus-grc1',20,162,163,' After them came the swineherd, driving three boars which were the best in all his herd.'),
('urn:cts:greekLit:tlg0012.tlg002.perseus-grc1',20,164,165,' These he let be to feed in the fair courts,  but himself spoke to Odysseus with gentle words:'),
('urn:cts:greekLit:tlg0012.tlg002.perseus-grc1',20,166,167,'“Stranger, do the Achaeans look on thee with any more regard, or do they dishonor thee in the halls as before?\"'),
('urn:cts:greekLit:tlg0012.tlg002.perseus-grc1',20,168,168,'Then Odysseus of many wiles answered him, and said: '),
('urn:cts:greekLit:tlg0012.tlg002.perseus-grc1',20,169,171,'“Ah, Eumaeus, I would that the gods might take vengeance on the outrage  wherewith these men in wantonness devise wicked folly in another\'s house, and have no place for shame.\"'),
('urn:cts:greekLit:tlg0012.tlg002.perseus-grc1',20,172,173,'Thus they spoke to one another. And near to them came Melanthius the goatherd,'),
('urn:cts:greekLit:tlg0012.tlg002.perseus-grc1',20,174,175,' leading she-goats that were the best in all the herds,  to make a feast for the wooers,'),
('urn:cts:greekLit:tlg0012.tlg002.perseus-grc1',20,175,175,'and two herdsmen followed with him. '),
('urn:cts:greekLit:tlg0012.tlg002.perseus-grc1',20,176,177,'The goats he tethered beneath the echoing portico, and himself spoke to Odysseus with taunting words:'),
('urn:cts:greekLit:tlg0012.tlg002.perseus-grc1',20,178,179,'\n“Stranger, wilt thou even now still be a plague to us here in the hall, asking alms of men, and wilt thou not begone?'),
('urn:cts:greekLit:tlg0012.tlg002.perseus-grc1',20,180,182,'  \'Tis plain, methinks, that we two shall not part company till we taste one another\'s fists, for thy begging is in no wise decent.'),
('urn:cts:greekLit:tlg0012.tlg002.perseus-grc1',20,182,182,' Also it is not here alone that there are feasts of the Achaeans.” '),
('urn:cts:greekLit:tlg0012.tlg002.perseus-grc1',20,183,184,' \nSo he spoke, but Odysseus of many wiles made no answer, but he shook his head in silence, pondering evil in the deep of his heart.'),
('urn:cts:greekLit:tlg0012.tlg002.perseus-grc1',20,185,186,'\n  Besides these a third man came, Philoetius, a leader of men, driving for the wooers a barren heifer and fat she-goats.'),
('urn:cts:greekLit:tlg0012.tlg002.perseus-grc1',20,187,188,' These had been brought over from the mainland by ferrymen, who send other men, too, on their way, whosoever comes to them.'),
('urn:cts:greekLit:tlg0012.tlg002.perseus-grc1',20,189,190,' The beasts he tethered carefully beneath the echoing portico,  but himself came close to the swineherd and questioned him, saying: '),
('urn:cts:greekLit:tlg0012.tlg002.perseus-grc1',20,191,192,'“Who is this stranger, swineherd, who has newly come to our house? '),
('urn:cts:greekLit:tlg0012.tlg002.perseus-grc1',20,192,193,'From what men does he declare himself to be sprung? '),
('urn:cts:greekLit:tlg0012.tlg002.perseus-grc1',20,193,193,' Where are his kinsmen and his native fields? '),
('urn:cts:greekLit:tlg0012.tlg002.perseus-grc1',20,194,194,' Hapless man! Yet truly in form he is like a royal prince; '),
('urn:cts:greekLit:tlg0012.tlg002.perseus-grc1',20,195,196,' howbeit the gods bring to misery far-wandering men, whenever they spin for them the threads of trouble, even though they be kings.\"'),
('urn:cts:greekLit:tlg0012.tlg002.perseus-grc1',20,197,198,'Therewith he drew near to Odysseus, and stretching forth his right hand in greeting, spoke and addressed him with winged words:'),
('urn:cts:greekLit:tlg0012.tlg002.perseus-grc1',20,199,199,'\n“Hail, Sir stranger; '),
('urn:cts:greekLit:tlg0012.tlg002.perseus-grc1',20,199,200,' may happy fortune be thine in time to come, '),
('urn:cts:greekLit:tlg0012.tlg002.perseus-grc1',20,200,200,'though now thou art the thrall of many sorrows!'),
('urn:cts:greekLit:tlg0012.tlg002.perseus-grc1',20,201,201,' Father Zeus, no other god is more baneful than thou;'),
('urn:cts:greekLit:tlg0012.tlg002.perseus-grc1',20,202,203,' thou hast no pity on men when thou hast thyself given them birth, but bringest them into misery and wretched pains. '),
('urn:cts:greekLit:tlg0012.tlg002.perseus-grc1',20,204,207,'The sweat broke out on me when I marked the man, and my eyes are full of tears  as I think of Odysseus; for he, too, I ween, is clothed in such rags and is a wanderer among men, if indeed he still lives and beholds the light of the sun.'),
('urn:cts:greekLit:tlg0012.tlg002.perseus-grc1',20,208,210,' But if he is already dead and in the house of Hades, then woe is me for blameless Odysseus, who  set me over his cattle, when I was yet a boy, in the land of the Cephallenians. '),
('urn:cts:greekLit:tlg0012.tlg002.perseus-grc1',20,211,212,' And now these wax past counting; in no other wise could the breed of broad-browed cattle yield better increase for a mortal man.'),
('urn:cts:greekLit:tlg0012.tlg002.perseus-grc1',20,213,214,' But strangers bid me drive these now for themselves to eat, '),
('urn:cts:greekLit:tlg0012.tlg002.perseus-grc1',20,214,215,' and they care nothing for the son in the house,  nor do they tremble at the wrath of the gods, '),
('urn:cts:greekLit:tlg0012.tlg002.perseus-grc1',20,215,216,'for they are eager now to divide among themselves the possessions of our lord that has long been gone.'),
('urn:cts:greekLit:tlg0012.tlg002.perseus-grc1',20,217,218,' Now, as for myself, the heart in my breast keeps revolving this matter:'),
('urn:cts:greekLit:tlg0012.tlg002.perseus-grc1',20,218,220,' a very evil thing it is, while the son lives, to depart along with my cattle and go to a land of strangers,  even to an alien folk;'),
('urn:cts:greekLit:tlg0012.tlg002.perseus-grc1',20,220,221,' but this is worse still, to remain here and suffer woes in charge of cattle that are given over to others.'),
('urn:cts:greekLit:tlg0012.tlg002.perseus-grc1',20,222,223,' Aye, verily, long ago would I have fled and come to some other of the proud kings, for now things are no more to be borne; '),
('urn:cts:greekLit:tlg0012.tlg002.perseus-grc1',20,224,225,' but still I think of that hapless one, if perchance he might come back I know not whence,  and make a scattering of the wooers in his house.”'),
('urn:cts:greekLit:tlg0012.tlg002.perseus-grc1',20,226,226,' \nThen Odysseus of many wiles answered him, and said:'),
('urn:cts:greekLit:tlg0012.tlg002.perseus-grc1',20,227,229,' “Neatherd, since thou seemest to be neither an evil man nor a witless, and I see for myself that thou hast gotten an understanding heart, therefore will I speak out and swear a great oath to confirm my words.'),
('urn:cts:greekLit:tlg0012.tlg002.perseus-grc1',20,230,232,'  Now be my witness Zeus above all gods, and this hospitable board, and the hearth of noble Odysseus to which I am come, that verily while thou art here Odysseus shall come home,'),
('urn:cts:greekLit:tlg0012.tlg002.perseus-grc1',20,233,234,'and thou shalt see with thine eyes, if thou wilt, the slaying of the wooers, who lord it here.\"'),
('urn:cts:greekLit:tlg0012.tlg002.perseus-grc1',20,235,235,'  Then the herdsman of the cattle answered him: '),
('urn:cts:greekLit:tlg0012.tlg002.perseus-grc1',20,236,236,'“Ah, stranger, I would that the son of Cronos might fulfil this word of thine!'),
('urn:cts:greekLit:tlg0012.tlg002.perseus-grc1',20,237,237,' Then shouldest thou know what manner of might is mine, and how my hands obey.\"'),
('urn:cts:greekLit:tlg0012.tlg002.perseus-grc1',20,238,239,'And even in like manner did Eumaeus pray to all the gods that wise Odysseus might come back to his own home.'),
('urn:cts:greekLit:tlg0012.tlg002.perseus-grc1',20,240,242,'\n  Thus they spoke to one another, but the wooers meanwhile were plotting death and fate for Telemachus; '),
('urn:cts:greekLit:tlg0012.tlg002.perseus-grc1',20,242,243,' howbeit there came to them a bird on their left, an eagle of lofty flight, clutching a timid dove.'),
('urn:cts:greekLit:tlg0012.tlg002.perseus-grc1',20,244,244,' Then Amphinomus spoke in their assembly, and said:'),
('urn:cts:greekLit:tlg0012.tlg002.perseus-grc1',20,245,246,' \n  “Friends, this plan of ours will not run to our liking, even the slaying of Telemachus; '),
('urn:cts:greekLit:tlg0012.tlg002.perseus-grc1',20,246,246,'nay, let us bethink us of the feast.\"'),
('urn:cts:greekLit:tlg0012.tlg002.perseus-grc1',20,247,247,'So spoke Amphinomus, and his word was pleasing to them. '),
('urn:cts:greekLit:tlg0012.tlg002.perseus-grc1',20,248,251,'Then, going into the house of godlike Odysseus, they laid their cloaks on the chairs and high seats,  and men fell to slaying great sheep and fat goats, aye, and fatted swine, and the heifer of the herd.'),
('urn:cts:greekLit:tlg0012.tlg002.perseus-grc1',20,252,253,' Then they roasted the entrails and served them out, and mixed wine in the bowls, '),
('urn:cts:greekLit:tlg0012.tlg002.perseus-grc1',20,253,253,'and the swineherd handed out the cups.'),
('urn:cts:greekLit:tlg0012.tlg002.perseus-grc1',20,254,255,' And Philoetius, a leader of men, handed them bread  in a beautiful basket, and Melanthius poured them wine. '),
('urn:cts:greekLit:tlg0012.tlg002.perseus-grc1',20,256,256,'So they put forth their hands to the good cheer lying ready before them.'),
('urn:cts:greekLit:tlg0012.tlg002.perseus-grc1',20,257,259,'\nBut Telemachus, with crafty thought, made Odysseus sit within the well-built hall by the threshold of stone, and placed for him a mean stool and a little table.'),
('urn:cts:greekLit:tlg0012.tlg002.perseus-grc1',20,260,261,'  Beside him he set portions of the entrails and poured wine in a cup of gold, and said to him:'),
('urn:cts:greekLit:tlg0012.tlg002.perseus-grc1',20,262,262,'\n“Sit down here among the lords and drink thy wine,'),
('urn:cts:greekLit:tlg0012.tlg002.perseus-grc1',20,263,265,'and the revilings and blows of all the wooers will I myself ward from thee; for this is no public  resort, but the house of Odysseus, and it was for me that he won it.'),
('urn:cts:greekLit:tlg0012.tlg002.perseus-grc1',20,266,267,' And for your part, ye wooers, refrain your minds from rebukes and blows, that no strife or quarrel may arise.” '),
('urn:cts:greekLit:tlg0012.tlg002.perseus-grc1',20,268,269,' \nSo he spoke, and they all bit their lips and marvelled at Telemachus for that he spoke boldly; '),
('urn:cts:greekLit:tlg0012.tlg002.perseus-grc1',20,270,270,' and Antinous, son of Eupeithes, spoke among them, saying:'),
('urn:cts:greekLit:tlg0012.tlg002.perseus-grc1',20,271,272,'\n“Hard though it be, Achaeans, let us accept the word of Telemachus,'),
('urn:cts:greekLit:tlg0012.tlg002.perseus-grc1',20,272,272,'though boldly he threatens us in his speech.'),
('urn:cts:greekLit:tlg0012.tlg002.perseus-grc1',20,273,273,' For Zeus, son of Cronos, did not suffer it,'),
('urn:cts:greekLit:tlg0012.tlg002.perseus-grc1',20,273,274,' else would we ere now have silenced him in the halls, clear-voiced talker though he is.\"'),
('urn:cts:greekLit:tlg0012.tlg002.perseus-grc1',20,275,275,'  So spoke Antinous, '),
('urn:cts:greekLit:tlg0012.tlg002.perseus-grc1',20,275,275,'but Telemachus paid no heed to his words.'),
('urn:cts:greekLit:tlg0012.tlg002.perseus-grc1',20,276,277,' Meanwhile the heralds were leading through the city the holy hecatomb of the gods,'),
('urn:cts:greekLit:tlg0012.tlg002.perseus-grc1',20,277,278,' and the long-haired Achaeans gathered together beneath a shady grove of Apollo, the archer-god.'),
('urn:cts:greekLit:tlg0012.tlg002.perseus-grc1',20,279,280,'\nBut when they had roasted the outer flesh and drawn it off the spits,  they divided the portions and feasted a glorious feast. '),
('urn:cts:greekLit:tlg0012.tlg002.perseus-grc1',20,281,282,'And by Odysseus those who served set a portion equal to that which they received themselves, '),
('urn:cts:greekLit:tlg0012.tlg002.perseus-grc1',20,282,283,'for so Telemachus commanded, the dear son of divine Odysseus.'),
('urn:cts:greekLit:tlg0012.tlg002.perseus-grc1',20,284,286,'\nBut the proud wooers Athena  would in no wise suffer to abstain from bitter outrage, that pain might sink yet deeper into the heart of Odysseus, son of Laertes.'),
('urn:cts:greekLit:tlg0012.tlg002.perseus-grc1',20,287,288,' There was among the wooers a man with his heart set on lawlessness—Ctesippus was his name, and in Same was his dwelling—'),
('urn:cts:greekLit:tlg0012.tlg002.perseus-grc1',20,289,290,'who, trusting forsooth in his boundless wealth,  wooed the wife of Odysseus, that had long been gone. '),
('urn:cts:greekLit:tlg0012.tlg002.perseus-grc1',20,291,291,'He it was who now spoke among the haughty wooers:'),
('urn:cts:greekLit:tlg0012.tlg002.perseus-grc1',20,292,292,'\n“Hear me, ye proud wooers, that I may say somewhat.'),
('urn:cts:greekLit:tlg0012.tlg002.perseus-grc1',20,293,294,' A portion has the stranger long had, an equal portion, as is meet; '),
('urn:cts:greekLit:tlg0012.tlg002.perseus-grc1',20,294,295,'for it is not well nor just to rob of their due  the guests of Telemachus, whosoever he be that comes to this house. '),
('urn:cts:greekLit:tlg0012.tlg002.perseus-grc1',20,296,298,' Nay, come, I too will give him a stranger\'s-gift, that he in turn may give a present either to the bath-woman or to some other of the slaves who are in the house of godlike Odysseus.” '),
('urn:cts:greekLit:tlg0012.tlg002.perseus-grc1',20,299,299,' \nSo saying, he hurled with strong hand the hoof of an ox, '),
('urn:cts:greekLit:tlg0012.tlg002.perseus-grc1',20,300,300,' taking it up from the basket where it lay. '),
('urn:cts:greekLit:tlg0012.tlg002.perseus-grc1',20,300,302,'But Odysseus avoided it with a quick turn of his head, and in his heart he smiled a right grim and bitter smile; '),
('urn:cts:greekLit:tlg0012.tlg002.perseus-grc1',20,302,302,' and the ox\'s hoof struck the well-built wall.'),
('urn:cts:greekLit:tlg0012.tlg002.perseus-grc1',20,303,303,' Then Telemachus rebuked Ctesippus, and said:'),
('urn:cts:greekLit:tlg0012.tlg002.perseus-grc1',20,304,304,'\n“Ctesippus, verily this thing fell out more to thy soul\'s profit.'),
('urn:cts:greekLit:tlg0012.tlg002.perseus-grc1',20,305,305,'  Thou didst not smite the stranger,'),
('urn:cts:greekLit:tlg0012.tlg002.perseus-grc1',20,305,305,' for he himself avoided thy missile,'),
('urn:cts:greekLit:tlg0012.tlg002.perseus-grc1',20,306,308,' else surely would I have struck thee through the middle with my sharp spear, and instead of a wedding feast thy father would have been busied with a funeral feast in this land.'),
('urn:cts:greekLit:tlg0012.tlg002.perseus-grc1',20,308,309,' Wherefore let no man, I warn you, make a show of forwardness in my house;'),
('urn:cts:greekLit:tlg0012.tlg002.perseus-grc1',20,309,310,' for now I mark and understand all things,  the good and the evil,'),
('urn:cts:greekLit:tlg0012.tlg002.perseus-grc1',20,310,310,' whereas heretofore I was but a child.'),
('urn:cts:greekLit:tlg0012.tlg002.perseus-grc1',20,311,313,' But none the less we still endure to see these deeds, while sheep are slaughtered, and wine drunk, and bread consumed,'),
('urn:cts:greekLit:tlg0012.tlg002.perseus-grc1',20,313,313,' for hard it is for one man to restrain many.'),
('urn:cts:greekLit:tlg0012.tlg002.perseus-grc1',20,314,314,' Yet come, no longer work me harm of your evil wills.'),
('urn:cts:greekLit:tlg0012.tlg002.perseus-grc1',20,315,319,'  But if you are minded even now to slay me myself with the sword, even that would I choose, and it would be better far to die than continually to behold these shameful deeds, strangers mishandled and men dragging the handmaidens in shameful fashion through the fair hall.\"'),
('urn:cts:greekLit:tlg0012.tlg002.perseus-grc1',20,320,320,'  So he spoke, and they were all hushed in silence,'),
('urn:cts:greekLit:tlg0012.tlg002.perseus-grc1',20,321,321,'but at last there spoke among them Agelaus, son of Damastor:'),
('urn:cts:greekLit:tlg0012.tlg002.perseus-grc1',20,322,323,'“Friends, no man in answer to what has been fairly spoken would wax wroth and make reply with wrangling words.'),
('urn:cts:greekLit:tlg0012.tlg002.perseus-grc1',20,324,325,' Abuse not any more the stranger nor any  of the slaves that are in the house of divine Odysseus. '),
('urn:cts:greekLit:tlg0012.tlg002.perseus-grc1',20,326,327,' But to Telemachus and his mother I would speak a gentle word, if perchance it may find favour in the minds of both.'),
('urn:cts:greekLit:tlg0012.tlg002.perseus-grc1',20,328,332,'So long as the hearts in your breasts had hope that wise Odysseus would return to his own house,  so long there was no ground for blame that you waited, and restrained the wooers in your halls; for this was the better course, had Odysseus returned and come back to his house.'),
('urn:cts:greekLit:tlg0012.tlg002.perseus-grc1',20,333,333,'  But now this is plain, that he will return no more.'),
('urn:cts:greekLit:tlg0012.tlg002.perseus-grc1',20,334,337,'Nay then, come, sit by thy mother and tell her this,  namely that she must wed him whosoever is the best man, and who offers the most gifts; to the end that thou mayest enjoy in peace all the heritage of thy fathers, eating and drinking, and that she may keep the house of another.”'),
('urn:cts:greekLit:tlg0012.tlg002.perseus-grc1',20,338,338,' Then wise Telemachus answered him:'),
('urn:cts:greekLit:tlg0012.tlg002.perseus-grc1',20,339,342,'“Nay, by Zeus, Agelaus, and by the woes of my father,  who somewhere far from Ithaca has perished or is wandering, in no wise do I delay my mother\'s marriage, but I bid her wed what man she will, and I offer besides gifts past counting.'),
('urn:cts:greekLit:tlg0012.tlg002.perseus-grc1',20,343,344,' But I am ashamed to drive her forth from the hall against her will by a word of compulsion. '),
('urn:cts:greekLit:tlg0012.tlg002.perseus-grc1',20,344,344,'May God never bring such a thing to pass.” '),
('urn:cts:greekLit:tlg0012.tlg002.perseus-grc1',20,345,345,' \n  So spoke Telemachus, '),
('urn:cts:greekLit:tlg0012.tlg002.perseus-grc1',20,345,346,'but among the wooers Pallas Athena roused unquenchable laughter, and turned their wits awry.'),
('urn:cts:greekLit:tlg0012.tlg002.perseus-grc1',20,347,348,' And now they laughed with alien lips, and all bedabbled with blood was the flesh they ate,'),
('urn:cts:greekLit:tlg0012.tlg002.perseus-grc1',20,348,349,'and their eyes were filled with tears and their spirits set on wailing.'),
('urn:cts:greekLit:tlg0012.tlg002.perseus-grc1',20,350,350,' Then among them spoke godlike Theoclymenus:'),
('urn:cts:greekLit:tlg0012.tlg002.perseus-grc1',20,351,351,'\n“Ah, wretched men, what evil is this that you suffer?'),
('urn:cts:greekLit:tlg0012.tlg002.perseus-grc1',20,351,352,' Shrouded in night are your heads and your faces and your knees beneath you; '),
('urn:cts:greekLit:tlg0012.tlg002.perseus-grc1',20,353,354,' kindled is the sound of wailing, bathed in tears are your cheeks, and sprinkled with blood are the walls and the fair rafters.'),
('urn:cts:greekLit:tlg0012.tlg002.perseus-grc1',20,355,356,'  And full of ghosts is the porch and full the court, of ghosts that hasten down to Erebus beneath the darkness,'),
('urn:cts:greekLit:tlg0012.tlg002.perseus-grc1',20,356,357,'and the sun has perished out of heaven and an evil mist hovers over all.\"'),
('urn:cts:greekLit:tlg0012.tlg002.perseus-grc1',20,358,358,'So he spoke, but they all laughed merrily at him.'),
('urn:cts:greekLit:tlg0012.tlg002.perseus-grc1',20,359,359,' And among them Eurymachus, son of Polybus, was the first to speak:'),
('urn:cts:greekLit:tlg0012.tlg002.perseus-grc1',20,360,360,'  “Mad is the stranger that has newly come from abroad. '),
('urn:cts:greekLit:tlg0012.tlg002.perseus-grc1',20,361,362,'Quick, ye youths, convey him forth out of doors to go his way to the place of assembly, since here he finds it like night.\"'),
('urn:cts:greekLit:tlg0012.tlg002.perseus-grc1',20,363,363,'Then godlike Theoclymenus answered him:'),
('urn:cts:greekLit:tlg0012.tlg002.perseus-grc1',20,364,364,' “Eurymachus, in no wise do I bid thee give me guides for my way.'),
('urn:cts:greekLit:tlg0012.tlg002.perseus-grc1',20,365,366,'  I have eyes and ears and my two feet, and a mind in my breast that is in no wise meanly fashioned.'),
('urn:cts:greekLit:tlg0012.tlg002.perseus-grc1',20,367,370,' With these will I go forth out of doors, for I mark evil coming upon you which not one of the wooers may escape or avoid, of all you who in the house of godlike Odysseus  insult men and devise wicked folly.”'),
('urn:cts:greekLit:tlg0012.tlg002.perseus-grc1',20,371,372,'So saying, he went forth from the stately halls and came to Piraeus, who received him with a ready heart.'),
('urn:cts:greekLit:tlg0012.tlg002.perseus-grc1',20,373,374,' But all the wooers, looking at one another, sought to provoke Telemachus by laughing at his guests.'),
('urn:cts:greekLit:tlg0012.tlg002.perseus-grc1',20,375,375,'  And thus would one of the proud youths speak:'),
('urn:cts:greekLit:tlg0012.tlg002.perseus-grc1',20,376,376,'“Telemachus, no man is more unlucky in his guests than thou, '),
('urn:cts:greekLit:tlg0012.tlg002.perseus-grc1',20,377,379,'seeing that thou keepest such a filthy vagabond as this man here, always wanting bread and wine, and skilled neither in the works of peace nor those of war, but a mere burden of the earth.'),
('urn:cts:greekLit:tlg0012.tlg002.perseus-grc1',20,380,380,'  And this other fellow again stood up to prophesy. '),
('urn:cts:greekLit:tlg0012.tlg002.perseus-grc1',20,381,381,'Nay, if thou wouldst hearken to me it would be better far:'),
('urn:cts:greekLit:tlg0012.tlg002.perseus-grc1',20,382,383,' let us fling these strangers on board a benched ship, and send them to the Sicilians, whence they would bring thee in a fitting price.\"'),
('urn:cts:greekLit:tlg0012.tlg002.perseus-grc1',20,384,384,'So spake the wooers,'),
('urn:cts:greekLit:tlg0012.tlg002.perseus-grc1',20,384,386,'  but he paid no heed to their words.  Nay, in silence he watched his father, ever waiting until he should put forth his hands upon the shameless wooers.'),
('urn:cts:greekLit:tlg0012.tlg002.perseus-grc1',20,387,389,'\nBut the daughter of Icarius, wise Penelope, had set her beautiful chair over against them, and heard the words of each man in the hall.'),
('urn:cts:greekLit:tlg0012.tlg002.perseus-grc1',20,390,391,'  For they had made ready their meal in the midst of their laughing, a sweet meal, and one to satisfy the heart, for they had slain many beasts.'),
('urn:cts:greekLit:tlg0012.tlg002.perseus-grc1',20,392,394,' But never could meal have been more graceless than a supper such as a goddess and a mighty man were soon to set before them.'),
('urn:cts:greekLit:tlg0012.tlg002.perseus-grc1',20,394,394,' For unprovoked they were contriving deeds of shame.');
REPLACE INTO Sentence_Translation 
         SELECT sent_id, sent_en 
         FROM Para_gr_sents 
         INNER JOIN temp_align 
         USING(poem_id,book_id,sent_start,sent_end);
         