all: conf.inc.sh~ ../cdots.sh ../cdots-completion.sh ../cdots-function.sh

conf.inc.sh~: conf.xml xsl/sh.xsl
	xsltproc xsl/sh.xsl conf.xml > conf.inc.sh~

../cdots.sh: ../VERSION~
	../compile

../cdots-completion.sh: ../VERSION~
	../compile

../cdots-function.sh: ../VERSION~
	../compile

../VERSION~: conf.xml
	cat conf.xml | xmlstarlet sel -t -m project -v name -o - -v version > ../VERSION~



.PHONY: release
release:
	
