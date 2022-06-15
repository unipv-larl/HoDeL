#!/bin/bash

sh scripts/bin/doallAndCorrect.AGDT.sh hodel_test Treebank_1.xml scripts/todeleterefs.txt
sh scripts/bin/doallAndCorrect.AGDT.sh hodel_test_2 Treebank_2.xml scripts/todeleterefs.txt
sh scripts/bin/cpDB.AGDT.sh hodel_test_2 hodel_test
sh scripts/buildHODEL-DB.sh hodel_test
