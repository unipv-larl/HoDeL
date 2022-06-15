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
('urn:cts:greekLit:tlg0012.tlg002.perseus-grc1',7,1,2,' So he prayed there, the much-enduring goodly Odysseus, while the two strong mules bore the maiden to the city. '),
('urn:cts:greekLit:tlg0012.tlg002.perseus-grc1',7,3,6,'But when she had come to the glorious palace of her father, she halted the mules at the outer gate, and her brothers  thronged about her, men like the immortals, and loosed the mules from the wagon, and bore the raiment within; '),
('urn:cts:greekLit:tlg0012.tlg002.perseus-grc1',7,7,7,'and she herself went to her chamber.'),
('urn:cts:greekLit:tlg0012.tlg002.perseus-grc1',7,7,9,' There a fire was kindled for her by her waiting-woman, Eurymedusa, an aged dame from Apeire. Long ago the curved ships had brought her from Apeire, '),
('urn:cts:greekLit:tlg0012.tlg002.perseus-grc1',7,10,11,' and men had chosen her from the spoil as a gift of honor for Alcinous, for that he was king over all the Phaeacians, and the people hearkened to him as to a god.'),
('urn:cts:greekLit:tlg0012.tlg002.perseus-grc1',7,12,12,' She it was who had reared the white-armed Nausicaa in the palace,'),
('urn:cts:greekLit:tlg0012.tlg002.perseus-grc1',7,13,13,'and she it was who kindled the fire for her, and made ready her supper in the chamber.'),
('urn:cts:greekLit:tlg0012.tlg002.perseus-grc1',7,14,14,'\nThen Odysseus roused himself to go to the city,'),
('urn:cts:greekLit:tlg0012.tlg002.perseus-grc1',7,14,17,'and Athena,  with kindly purpose, cast about him a thick mist, that no one of the great-hearted Phaeacians, meeting him, should speak mockingly to him, and ask him who he was.'),
('urn:cts:greekLit:tlg0012.tlg002.perseus-grc1',7,18,20,' But when he was about to enter the lovely city, then the goddess, flashing-eyed Athena, met him  in the guise of a young maiden carrying a pitcher, '),
('urn:cts:greekLit:tlg0012.tlg002.perseus-grc1',7,21,21,'and she stood before him; and goodly Odysseus questioned her, saying:'),
('urn:cts:greekLit:tlg0012.tlg002.perseus-grc1',7,22,23,'\n“My child, couldst thou not guide me to the house of him they call Alcinous, who is lord among the people here?'),
('urn:cts:greekLit:tlg0012.tlg002.perseus-grc1',7,24,25,' For I am come hither a stranger sore-tried  from afar, from a distant country; '),
('urn:cts:greekLit:tlg0012.tlg002.perseus-grc1',7,25,26,'wherefore I know no one of the people who possess this city and land.\"'),
('urn:cts:greekLit:tlg0012.tlg002.perseus-grc1',7,27,27,'Then the goddess, flashing-eyed Athena, answered him:'),
('urn:cts:greekLit:tlg0012.tlg002.perseus-grc1',7,28,29,' “Then verily, Sir stranger, I will shew thee the palace as thou dost bid me, for it lies hard by the house of my own noble father.'),
('urn:cts:greekLit:tlg0012.tlg002.perseus-grc1',7,30,31,'  Only go thou quietly, and I will lead the way.  But turn not thine eyes upon any man nor question any,'),
('urn:cts:greekLit:tlg0012.tlg002.perseus-grc1',7,32,33,' for the men here endure not stranger-folk, nor do they give kindly welcome to him who comes from another land.'),
('urn:cts:greekLit:tlg0012.tlg002.perseus-grc1',7,34,35,' They, indeed, trusting in the speed of their swift ships,  cross over the great gulf of the sea, for this the Earth-shaker has granted them; '),
('urn:cts:greekLit:tlg0012.tlg002.perseus-grc1',7,36,36,'and their ships are swift as a bird on the wing or as a thought.” '),
('urn:cts:greekLit:tlg0012.tlg002.perseus-grc1',7,37,38,' \nSo speaking, Pallas Athena led the way quickly, '),
('urn:cts:greekLit:tlg0012.tlg002.perseus-grc1',7,38,38,' and he followed in the footsteps of the goddess. '),
('urn:cts:greekLit:tlg0012.tlg002.perseus-grc1',7,39,40,' And as he went through the city in the midst of them, the Phaeacians, famed for their ships, took no heed of him, '),
('urn:cts:greekLit:tlg0012.tlg002.perseus-grc1',7,40,42,'for fair-tressed Athena, the dread goddess, would not suffer it, but shed about him a wondrous mist, for her heart was kind toward him.'),
('urn:cts:greekLit:tlg0012.tlg002.perseus-grc1',7,43,45,' And Odysseus marvelled at the harbors and the stately ships, at the meeting-places where the heroes themselves gathered, and the walls, long and  high and crowned with palisades, a wonder to behold. '),
('urn:cts:greekLit:tlg0012.tlg002.perseus-grc1',7,46,47,' But when they had come to the glorious palace of the king, the goddess, flashing-eyed Athena, was the first to speak, saying:'),
('urn:cts:greekLit:tlg0012.tlg002.perseus-grc1',7,48,49,'“Here, Sir stranger, is the house which thou didst bid me shew to thee,'),
('urn:cts:greekLit:tlg0012.tlg002.perseus-grc1',7,49,50,' and thou wilt find the kings, fostered of Zeus,  feasting at the banquet.'),
('urn:cts:greekLit:tlg0012.tlg002.perseus-grc1',7,50,51,' Go thou within, and let thy heart fear nothing;'),
('urn:cts:greekLit:tlg0012.tlg002.perseus-grc1',7,51,52,' for a bold man is better in all things, though he be a stranger from another land.'),
('urn:cts:greekLit:tlg0012.tlg002.perseus-grc1',7,53,53,'The queen shalt thou approach first in the palace;'),
('urn:cts:greekLit:tlg0012.tlg002.perseus-grc1',7,54,55,'  Arete is the name by which she is called,  and she is sprung from the same line as is the king Alcinous. '),
('urn:cts:greekLit:tlg0012.tlg002.perseus-grc1',7,56,59,'Nausithous at the first was born from the earth-shaker Poseidon and Periboea, the comeliest of women, youngest daughter of great-hearted Eurymedon, who once was king over the insolent Giants.'),
('urn:cts:greekLit:tlg0012.tlg002.perseus-grc1',7,60,60,'  But he brought destruction on his froward people, and was himself destroyed.'),
('urn:cts:greekLit:tlg0012.tlg002.perseus-grc1',7,61,62,' But with Periboea lay Poseidon and begat a son, great-hearted Nausithous, who ruled over the Phaeacians; '),
('urn:cts:greekLit:tlg0012.tlg002.perseus-grc1',7,63,63,'and Nausithous begat Rhexenor and Alcinous.'),
('urn:cts:greekLit:tlg0012.tlg002.perseus-grc1',7,64,66,' Rhexenor, when as yet he had no son, Apollo of the silver bow smote  in his hall, a bridegroom though he was, and he left only one daughter, Arete.'),
('urn:cts:greekLit:tlg0012.tlg002.perseus-grc1',7,66,68,' Her Alcinous made his wife, and honored her as no other woman on earth is honored, of all those who in these days direct their households in subjection to their husbands;'),
('urn:cts:greekLit:tlg0012.tlg002.perseus-grc1',7,69,72,'so heartily is she honored,  and has ever been, by her children and by Alcinous himself and by the people, who look upon her as upon a goddess, and greet her as she goes through the city.'),
('urn:cts:greekLit:tlg0012.tlg002.perseus-grc1',7,73,73,'For she of herself is no wise lacking in good understanding,'),
('urn:cts:greekLit:tlg0012.tlg002.perseus-grc1',7,74,74,'  and for the women to whom she has good will she makes an end of strife even among their husbands. '),
('urn:cts:greekLit:tlg0012.tlg002.perseus-grc1',7,78,81,' \nSo saying, flashing-eyed Athena departed over the unresting sea, and left lovely Scheria.  She came to Marathon and broad-wayed Athens, and entered the well-built house of Erectheus; '),
('urn:cts:greekLit:tlg0012.tlg002.perseus-grc1',7,81,82,'but Odysseus went to the glorious palace of Alcinous.'),
('urn:cts:greekLit:tlg0012.tlg002.perseus-grc1',7,82,83,' There he stood, and his heart pondered much before he reached the threshold of bronze;'),
('urn:cts:greekLit:tlg0012.tlg002.perseus-grc1',7,84,85,'for there was a gleam as of sun or moon  over the high-roofed house of great-hearted Alcinous. '),
('urn:cts:greekLit:tlg0012.tlg002.perseus-grc1',7,86,87,'Of bronze were the walls that stretched this way and that from the threshold to the innermost chamber, and around was a cornice of cyanus.'),
('urn:cts:greekLit:tlg0012.tlg002.perseus-grc1',7,88,88,' Golden were the doors that shut in the well-built house, '),
('urn:cts:greekLit:tlg0012.tlg002.perseus-grc1',7,89,90,'and doorposts of silver were set in a threshold of bronze. Of silver was the lintel above, and of gold the handle.'),
('urn:cts:greekLit:tlg0012.tlg002.perseus-grc1',7,91,94,'  On either side of the door there stood gold and silver dogs, which Hephaestus had fashioned with cunning skill to guard the palace of great-hearted Alcinous; immortal were they and ageless all their days.'),
('urn:cts:greekLit:tlg0012.tlg002.perseus-grc1',7,95,97,'  Within, seats were fixed along the wall on either hand, from the threshold to the innermost chamber, and on them were thrown robes of soft fabric, cunningly woven, the handiwork of women.'),
('urn:cts:greekLit:tlg0012.tlg002.perseus-grc1',7,98,99,' On these the leaders of the Phaeacians were wont to sit drinking and eating,'),
('urn:cts:greekLit:tlg0012.tlg002.perseus-grc1',7,99,99,'for they had unfailing store.'),
('urn:cts:greekLit:tlg0012.tlg002.perseus-grc1',7,100,102,'  And golden youths stood on well-built pedestals, holding lighted torches in their hands to give light by night to the banqueters in the hall. '),
('urn:cts:greekLit:tlg0012.tlg002.perseus-grc1',7,103,107,'And fifty slave-women he had in the house, of whom some grind the yellow grain on the millstone,  and others weave webs, or, as they sit, twirl the yarn, like unto the leaves of a tall poplar tree; and from the closely-woven linen the soft olive oil drips down. '),
('urn:cts:greekLit:tlg0012.tlg002.perseus-grc1',7,108,110,' For as the Phaeacian men are skilled above all others in speeding a swift ship upon the sea, so are the women  cunning workers at the loom, '),
('urn:cts:greekLit:tlg0012.tlg002.perseus-grc1',7,110,111,'for Athena has given to them above all others skill in fair handiwork, and an understanding heart.'),
('urn:cts:greekLit:tlg0012.tlg002.perseus-grc1',7,112,113,' But without the courtyard, hard by the door, is a great orchard of four acres, '),
('urn:cts:greekLit:tlg0012.tlg002.perseus-grc1',7,113,113,' and a hedge runs about it on either side. '),
('urn:cts:greekLit:tlg0012.tlg002.perseus-grc1',7,114,116,'Therein grow trees, tall and luxuriant,  pears and pomegranates and apple-trees with their bright fruit, and sweet figs, and luxuriant olives.'),
('urn:cts:greekLit:tlg0012.tlg002.perseus-grc1',7,117,118,' Of these the fruit perishes not nor fails in winter or in summer, but lasts throughout the year; '),
('urn:cts:greekLit:tlg0012.tlg002.perseus-grc1',7,118,119,'and ever does the west wind, as it blows, quicken to life some fruits, and ripen others; '),
('urn:cts:greekLit:tlg0012.tlg002.perseus-grc1',7,120,121,' pear upon pear waxes ripe, apple upon apple, cluster upon cluster, and fig upon fig.'),
('urn:cts:greekLit:tlg0012.tlg002.perseus-grc1',7,122,125,' There, too, is his fruitful vineyard planted, one part of which, a warm spot on level ground, is being dried in the sun, while other grapes men are gathering,  and others, too, they are treading; '),
('urn:cts:greekLit:tlg0012.tlg002.perseus-grc1',7,125,126,'but in front are unripe grapes that are shedding the blossom, and others that are turning purple.'),
('urn:cts:greekLit:tlg0012.tlg002.perseus-grc1',7,127,128,' There again, by the last row of the vines, grow trim garden beds of every sort, blooming the year through, '),
('urn:cts:greekLit:tlg0012.tlg002.perseus-grc1',7,129,131,'and therein are two springs, one of which sends its water throughout all the garden,  while the other, over against it, flows beneath the threshold of the court toward the high house; from this the townsfolk drew their water. '),
('urn:cts:greekLit:tlg0012.tlg002.perseus-grc1',7,132,132,'Such were the glorious gifts of the gods in the palace of Alcinous.'),
('urn:cts:greekLit:tlg0012.tlg002.perseus-grc1',7,133,133,' There the much-enduring goodly Odysseus stood and gazed. '),
('urn:cts:greekLit:tlg0012.tlg002.perseus-grc1',7,134,135,'But when he had marvelled in his heart at all things,  he passed quickly over the threshold into the house. '),
('urn:cts:greekLit:tlg0012.tlg002.perseus-grc1',7,136,138,'There he found the leaders and counsellors of the Phaeacians pouring libations from their cups to the keen-sighted Argeiphontes, to whom they were wont to pour the wine last of all, when they were minded to go to their rest. '),
('urn:cts:greekLit:tlg0012.tlg002.perseus-grc1',7,139,141,'But the much-enduring goodly Odysseus went through the hall,  wrapped in the thick mist which Athena had shed about him, till he came to Arete and to Alcinous the king.'),
('urn:cts:greekLit:tlg0012.tlg002.perseus-grc1',7,142,143,' About the knees of Arete Odysseus cast his hands, and straightway the wondrous mist melted from him, '),
('urn:cts:greekLit:tlg0012.tlg002.perseus-grc1',7,144,144,' and a hush fell upon all that were in the room at sight of the man, '),
('urn:cts:greekLit:tlg0012.tlg002.perseus-grc1',7,145,145,' and they marvelled as they looked upon him. '),
('urn:cts:greekLit:tlg0012.tlg002.perseus-grc1',7,145,145,'But Odysseus made his prayer:'),
('urn:cts:greekLit:tlg0012.tlg002.perseus-grc1',7,146,148,'“Arete, daughter of godlike Rhexenor, to thy husband and to thy knees am I come after many toils,—aye and to these banqueters, '),
('urn:cts:greekLit:tlg0012.tlg002.perseus-grc1',7,148,150,'to whom may the gods grant happiness in life, and may each of them hand down to his children  the wealth in his halls, and the dues of honor which the people have given him. But for me do ye speed my sending, that I may come to my native land, and that quickly; for long time have I been suffering woes far from my friends.” '),
('urn:cts:greekLit:tlg0012.tlg002.perseus-grc1',7,153,154,' \nSo saying he sat down on the hearth in the ashes by the fire, '),
('urn:cts:greekLit:tlg0012.tlg002.perseus-grc1',7,154,154,'and they were all hushed in silence.'),
('urn:cts:greekLit:tlg0012.tlg002.perseus-grc1',7,155,157,'  But at length there spoke among them the old lord Echeneus, who was an elder among the Phaeacians, well skilled in speech, and understanding all the wisdom of old.'),
('urn:cts:greekLit:tlg0012.tlg002.perseus-grc1',7,158,158,' He with good intent addressed the assembly, and said: '),
('urn:cts:greekLit:tlg0012.tlg002.perseus-grc1',7,159,161,'“Alcinous, lo, this is not the better way, nor is it seemly,  that a stranger should sit upon the ground on the hearth in the ashes; but these others hold back waiting for thy word.'),
('urn:cts:greekLit:tlg0012.tlg002.perseus-grc1',7,162,165,' Come, make the stranger to arise, and set him upon a silver-studded chair, and bid the heralds mix wine,  that we may pour libations also to Zeus, who hurls the thunderbolt; for he ever attends upon reverend suppliants. '),
('urn:cts:greekLit:tlg0012.tlg002.perseus-grc1',7,166,166,' And let the housewife give supper to the stranger of the store that is in the house.”'),
('urn:cts:greekLit:tlg0012.tlg002.perseus-grc1',7,167,171,'When the strong and mighty Alcinous heard this, he took by the hand Odysseus, the wise and crafty-minded, and raised him from the hearth, and set him upon a bright chair  from which he bade his son, the kindly Laodamas, to rise; for he sat next to him, and was his best beloved.'),
('urn:cts:greekLit:tlg0012.tlg002.perseus-grc1',7,172,174,' Then a handmaid brought water for the hands in a fair pitcher of gold, and poured it over a silver basin, for him to wash, '),
('urn:cts:greekLit:tlg0012.tlg002.perseus-grc1',7,174,174,'and beside him drew up a polished table.'),
('urn:cts:greekLit:tlg0012.tlg002.perseus-grc1',7,175,176,'  And the grave housewife brought and set before him bread, and therewith dainties in abundance, giving freely of her store.'),
('urn:cts:greekLit:tlg0012.tlg002.perseus-grc1',7,177,177,' So the much-enduring goodly Odysseus drank and ate; '),
('urn:cts:greekLit:tlg0012.tlg002.perseus-grc1',7,178,178,'and then the mighty Alcinous spoke to the herald, and said:'),
('urn:cts:greekLit:tlg0012.tlg002.perseus-grc1',7,179,181,'“Pontonous, mix the bowl, and serve wine  to all in the hall, that we may pour libations also to Zeus, who hurls the thunderbolt; for he ever attends upon reverend suppliants.\"'),
('urn:cts:greekLit:tlg0012.tlg002.perseus-grc1',7,182,183,'He spoke, and Pontonous mixed the honey-hearted wine, and served out to all, pouring first drops for libation into the cups.'),
('urn:cts:greekLit:tlg0012.tlg002.perseus-grc1',7,184,185,' But when they had poured libations, and had drunk to their heart\'s content,  Alcinous addressed the assembly, and spoke among them:'),
('urn:cts:greekLit:tlg0012.tlg002.perseus-grc1',7,186,187,'“Hearken to me, leaders and counsellors of the Phaeacians, that I may say what the heart in my breast bids me.'),
('urn:cts:greekLit:tlg0012.tlg002.perseus-grc1',7,188,188,' Now that ye have finished your feast, go each of you to his house to rest. '),
('urn:cts:greekLit:tlg0012.tlg002.perseus-grc1',7,189,198,'But in the morning we will call more of the elders together,  and will entertain the stranger in our halls and offer goodly victims to the gods. After that we will take thought also of his sending, that without toil or pain yon stranger may under our sending, come to his native land speedily and with rejoicing, though he come from never so far.  Nor shall he meanwhile suffer any evil or harm, until he sets foot upon his own land; but thereafter he shall suffer whatever Fate and the dread Spinners spun with their thread for him at his birth, when his mother bore him. '),
('urn:cts:greekLit:tlg0012.tlg002.perseus-grc1',7,199,200,' But if he is one of the immortals come down from heaven,  then is this some new thing which the gods are planning; '),
('urn:cts:greekLit:tlg0012.tlg002.perseus-grc1',7,201,203,'for ever heretofore have they been wont to appear to us in manifest form, when we sacrifice to them glorious hecatombs, and they feast among us, sitting even where we sit. '),
('urn:cts:greekLit:tlg0012.tlg002.perseus-grc1',7,204,206,'Aye, and if one of us as a lone wayfarer meets them,  they use no concealment, for we are of near kin to them, as are the Cyclopes and the wild tribes of the Giants.\"'),
('urn:cts:greekLit:tlg0012.tlg002.perseus-grc1',7,207,207,'Then Odysseus of many wiles answered him, and said:'),
('urn:cts:greekLit:tlg0012.tlg002.perseus-grc1',7,208,208,' “Alcinous, far from thee be that thought; '),
('urn:cts:greekLit:tlg0012.tlg002.perseus-grc1',7,208,210,'for I am not like the immortals, who hold broad heaven,  either in stature or in form, but like mortal men. '),
('urn:cts:greekLit:tlg0012.tlg002.perseus-grc1',7,211,212,'Whomsoever ye know among men who bear greatest burden of woe, to them might I liken myself in my sorrows.'),
('urn:cts:greekLit:tlg0012.tlg002.perseus-grc1',7,213,214,' Yea, and I could tell a yet longer tale of all the evils which I have endured by the will of the gods.'),
('urn:cts:greekLit:tlg0012.tlg002.perseus-grc1',7,215,215,'  But as for me, suffer me now to eat, despite my grief; '),
('urn:cts:greekLit:tlg0012.tlg002.perseus-grc1',7,216,221,'for there is nothing more shameless than a hateful belly, which bids a man perforce take thought thereof, be he never so sore distressed and laden with grief at heart, even as I, too, am laden with grief at heart, yet ever does my belly  bid me eat and drink, and makes me forget all that I have suffered, and commands me to eat my fill.'),
('urn:cts:greekLit:tlg0012.tlg002.perseus-grc1',7,222,224,' But do ye make haste at break of day, that ye may set me, hapless one, on the soil of my native land, even after my many woes.'),
('urn:cts:greekLit:tlg0012.tlg002.perseus-grc1',7,224,225,' Yea, let life leave me, when I have seen once more  my possessions, my slaves, and my great high-roofed house.”'),
('urn:cts:greekLit:tlg0012.tlg002.perseus-grc1',7,226,227,'So he spoke, and they all praised his words, and bade send the stranger on his way, since he had spoken fittingly. '),
('urn:cts:greekLit:tlg0012.tlg002.perseus-grc1',7,228,232,'Then when they had poured libations, and had drunk to their heart\'s content, they went each man to his home, to take their rest,  and goodly Odysseus was left behind in the hall, and beside him sat Arete and godlike Alcinous; '),
('urn:cts:greekLit:tlg0012.tlg002.perseus-grc1',7,232,232,'and the handmaids cleared away the dishes of the feast.'),
('urn:cts:greekLit:tlg0012.tlg002.perseus-grc1',7,233,233,' Then white-armed Arete was the first to speak; '),
('urn:cts:greekLit:tlg0012.tlg002.perseus-grc1',7,234,235,' for, as she saw it, she knew his  fair raiment, the mantle and tunic, which she herself had wrought with her handmaids. '),
('urn:cts:greekLit:tlg0012.tlg002.perseus-grc1',7,236,236,' And she spoke, and addressed him with winged words:'),
('urn:cts:greekLit:tlg0012.tlg002.perseus-grc1',7,237,237,'\n“Stranger, this question will I myself ask thee first.'),
('urn:cts:greekLit:tlg0012.tlg002.perseus-grc1',7,238,238,' Who art thou among men, and from whence?'),
('urn:cts:greekLit:tlg0012.tlg002.perseus-grc1',7,238,238,' Who gave thee this raiment?'),
('urn:cts:greekLit:tlg0012.tlg002.perseus-grc1',7,239,239,' Didst thou not say that thou camest hither wandering over the sea?” '),
('urn:cts:greekLit:tlg0012.tlg002.perseus-grc1',7,240,240,' Then Odysseus of many wiles answered her, and said: '),
('urn:cts:greekLit:tlg0012.tlg002.perseus-grc1',7,241,242,' “Hard were it, O queen, to tell to the end the tale of my woes, since full many have the heavenly gods given me.'),
('urn:cts:greekLit:tlg0012.tlg002.perseus-grc1',7,243,243,' But this will I tell thee, of which thou dost ask and enquire.'),
('urn:cts:greekLit:tlg0012.tlg002.perseus-grc1',7,244,244,' There is an isle, Ogygia, which lies far off in the sea.'),
('urn:cts:greekLit:tlg0012.tlg002.perseus-grc1',7,245,246,'  Therein dwells the fair-tressed daughter of Atlas, guileful Calypso, a dread goddess, '),
('urn:cts:greekLit:tlg0012.tlg002.perseus-grc1',7,246,247,' and with her no one either of gods or mortals hath aught to do; '),
('urn:cts:greekLit:tlg0012.tlg002.perseus-grc1',7,248,250,'but me in my wretchedness did fate bring to her hearth alone, for Zeus had smitten my swift ship with his bright thunderbolt,  and had shattered it in the midst of the wine-dark sea. '),
('urn:cts:greekLit:tlg0012.tlg002.perseus-grc1',7,251,253,' There all the rest of my trusty comrades perished, but I clasped in my arms the keel of my curved ship and was borne drifting for nine days, '),
('urn:cts:greekLit:tlg0012.tlg002.perseus-grc1',7,253,257,'and on the tenth black night the gods brought me to the isle, Ogygia, where  the fair-tressed Calypso dwells, a dread goddess. She took me to her home with kindly welcome, and gave me food, and said that she would make me immortal and ageless all my days;'),
('urn:cts:greekLit:tlg0012.tlg002.perseus-grc1',7,258,258,' but she could never persuade the heart in my breast.'),
('urn:cts:greekLit:tlg0012.tlg002.perseus-grc1',7,259,260,' There for seven years\' space I remained continually, and ever  with my tears would I wet the immortal raiment which Calypso gave me. '),
('urn:cts:greekLit:tlg0012.tlg002.perseus-grc1',7,261,263,'But when the eight year came in circling course, then she roused me and bade me go, either because of some message from Zeus, or because her own mind was turned. '),
('urn:cts:greekLit:tlg0012.tlg002.perseus-grc1',7,264,266,' And she sent me on my way on a raft, stoutly bound, and gave me abundant store  of bread and sweet wine, and clad me in immortal raiment, and sent forth a gentle wind and warm.'),
('urn:cts:greekLit:tlg0012.tlg002.perseus-grc1',7,267,270,' So for seventeen days I sailed over the sea, and on the eighteenth appeared the shadowy mountains of your land; and my heart was glad,  ill-starred that I was;'),
('urn:cts:greekLit:tlg0012.tlg002.perseus-grc1',7,270,274,'for verily I was yet to have fellowship with great woe, which Poseidon, the earth-shaker, sent upon me. For he stirred up the winds against me and stayed my course, and wondrously roused the sea, nor would the wave suffer me to be borne upon my raft, as I groaned ceaselessly.'),
('urn:cts:greekLit:tlg0012.tlg002.perseus-grc1',7,275,275,' My raft indeed the storm shattered,'),
('urn:cts:greekLit:tlg0012.tlg002.perseus-grc1',7,275,277,' but by swimming I clove my way through yon gulf of the sea, until the wind and the waves, as they bore me, brought me to your shores.'),
('urn:cts:greekLit:tlg0012.tlg002.perseus-grc1',7,278,279,' There, had I sought to land, the waves would have hurled me upon the shore, and dashed me against the great crags and a cheerless place, '),
('urn:cts:greekLit:tlg0012.tlg002.perseus-grc1',7,280,282,' but I gave way, and swam back until I came to a river, where seemed to me the best place, since it was smooth of rocks, and besides there was shelter from the wind.'),
('urn:cts:greekLit:tlg0012.tlg002.perseus-grc1',7,283,284,' Forth then I staggered, and sank down, gasping for breath, and immortal night came on. '),
('urn:cts:greekLit:tlg0012.tlg002.perseus-grc1',7,284,286,'Then I went forth from the heaven-fed river,  and lay down to sleep in the bushes, gathering leaves about me; '),
('urn:cts:greekLit:tlg0012.tlg002.perseus-grc1',7,286,286,' and a god shed over me infinite sleep. '),
('urn:cts:greekLit:tlg0012.tlg002.perseus-grc1',7,287,288,' So there among the leaves I slept, my heart sore stricken, the whole night through, until the morning and until midday; '),
('urn:cts:greekLit:tlg0012.tlg002.perseus-grc1',7,289,289,'and the sun turned to his setting ere sweet sleep released me.'),
('urn:cts:greekLit:tlg0012.tlg002.perseus-grc1',7,290,291,'  Then I saw the handmaids of thy daughter on the shore at play, and amid them was she, fair as the goddesses.'),
('urn:cts:greekLit:tlg0012.tlg002.perseus-grc1',7,292,292,'To her I made my prayer;'),
('urn:cts:greekLit:tlg0012.tlg002.perseus-grc1',7,292,294,' and she in no wise failed in good understanding, to do as thou wouldst not deem that one of younger years would do on meeting thee; '),
('urn:cts:greekLit:tlg0012.tlg002.perseus-grc1',7,294,294,'for younger folk are ever thoughtless.'),
('urn:cts:greekLit:tlg0012.tlg002.perseus-grc1',7,295,296,'  She gave bread in plenty and sparkling wine, and bathed me in the river, and gave me this raiment.'),
('urn:cts:greekLit:tlg0012.tlg002.perseus-grc1',7,297,297,' In this, for all my sorrows, have I told thee the truth.”'),
('urn:cts:greekLit:tlg0012.tlg002.perseus-grc1',7,298,298,'\nThen in turn Alcinous answered him, and said:'),
('urn:cts:greekLit:tlg0012.tlg002.perseus-grc1',7,299,301,'“Stranger, verily my daughter was not minded aright in this,  that she did not bring thee to our house with her maidens. Yet it was to her first that thou didst make thy prayer.”'),
('urn:cts:greekLit:tlg0012.tlg002.perseus-grc1',7,302,302,'Then Odysseus of many wiles answered him, and said:'),
('urn:cts:greekLit:tlg0012.tlg002.perseus-grc1',7,303,303,' “Prince, rebuke not for this, I pray thee, thy blameless daughter. '),
('urn:cts:greekLit:tlg0012.tlg002.perseus-grc1',7,304,306,'She did indeed bid me follow with her maidens,  but I would not for fear and shame, lest haply thy heart should darken with wrath as thou sawest it; '),
('urn:cts:greekLit:tlg0012.tlg002.perseus-grc1',7,307,307,'for we are quick to anger, we tribes of men upon the earth.\"'),
('urn:cts:greekLit:tlg0012.tlg002.perseus-grc1',7,308,308,'And again Alcinous answered him, and said:'),
('urn:cts:greekLit:tlg0012.tlg002.perseus-grc1',7,309,310,'“Stranger, not such is the heart in my breast,  to be filled with wrath without a cause. '),
('urn:cts:greekLit:tlg0012.tlg002.perseus-grc1',7,310,310,' Better is due measure in all things.'),
('urn:cts:greekLit:tlg0012.tlg002.perseus-grc1',7,311,314,'I would, O father Zeus, and Athena and Apollo, that thou, so goodly a man, and like-minded with me, wouldst have my daughter to wife, and be called my son, and abide here; '),
('urn:cts:greekLit:tlg0012.tlg002.perseus-grc1',7,314,315,'a house and possessions would I give thee,  if thou shouldst choose to remain, '),
('urn:cts:greekLit:tlg0012.tlg002.perseus-grc1',7,315,316,'but against thy will shall no one of the Phaeacians keep thee; '),
('urn:cts:greekLit:tlg0012.tlg002.perseus-grc1',7,316,316,'let not that be the will of father Zeus. '),
('urn:cts:greekLit:tlg0012.tlg002.perseus-grc1',7,317,318,' But as for thy sending, that thou mayest know it surely, I appoint a time thereto, even the morrow. '),
('urn:cts:greekLit:tlg0012.tlg002.perseus-grc1',7,318,324,'Then shalt thou lie down, overcome by sleep, and they shall row thee over the calm sea until thou comest  to thy country and thy house, or to whatsoever place thou wilt, aye though it be even far beyond Euboea, which those of our people who saw it, when they carried fair-haired Rhadamanthus to visit Tityus, the son of Gaea, say is the furthest of lands.'),
('urn:cts:greekLit:tlg0012.tlg002.perseus-grc1',7,325,326,'  Thither they went, and without toil accomplished their journey, and on the selfsame day came back home.'),
('urn:cts:greekLit:tlg0012.tlg002.perseus-grc1',7,327,328,' So shalt thou, too, know for thyself how far my ships are the best, and my youths at tossing the brine with the oar-blade.\"'),
('urn:cts:greekLit:tlg0012.tlg002.perseus-grc1',7,329,330,'So said he, and the much-enduring goodly Odysseus was glad;  and he spoke in prayer, and said: '),
('urn:cts:greekLit:tlg0012.tlg002.perseus-grc1',7,331,332,'“Father Zeus, grant that Alcinous may bring to pass all that he has said.'),
('urn:cts:greekLit:tlg0012.tlg002.perseus-grc1',7,332,333,' So shall his fame be unquenchable over the earth, the giver of grain, and I shall reach my native land.\"'),
('urn:cts:greekLit:tlg0012.tlg002.perseus-grc1',7,334,334,'Thus they spoke to one another, '),
('urn:cts:greekLit:tlg0012.tlg002.perseus-grc1',7,335,338,' and white-armed Arete bade her maidens place a bedstead under cover of the portico, and to lay on it fair blankets of purple, and to spread there over coverlets, and on these to put fleecy cloaks for clothing.'),
('urn:cts:greekLit:tlg0012.tlg002.perseus-grc1',7,339,339,' So they went forth from the hall with torches in their hands.'),
('urn:cts:greekLit:tlg0012.tlg002.perseus-grc1',7,340,341,'  But when they had busily spread the stout-built bedstead, they came to Odysseus, and called to him, and said:'),
('urn:cts:greekLit:tlg0012.tlg002.perseus-grc1',7,342,342,' “Rouse thee now, stranger, to go to thy rest; '),
('urn:cts:greekLit:tlg0012.tlg002.perseus-grc1',7,342,342,'thy bed is made.”'),
('urn:cts:greekLit:tlg0012.tlg002.perseus-grc1',7,343,343,'Thus they spoke, and welcome did it seem to him to lay him down to sleep.'),
('urn:cts:greekLit:tlg0012.tlg002.perseus-grc1',7,344,345,' So there he slept, the much-enduring goodly Odysseus,  on the corded bedstead under the echoing portico. ');
REPLACE INTO Sentence_Translation 
         SELECT sent_id, sent_en 
         FROM Para_gr_sents 
         INNER JOIN temp_align 
         USING(poem_id,book_id,sent_start,sent_end);
         