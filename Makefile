FILENAME_FA18=vonLaszewski-proceedings-fa18
FILENAME_SP19=vonLaszewski-proceedings-sp19
INDEX=all.md
IMAGE_DIRS=$(shell ./bin/find-image-dirs.py)

MARKDOWN-OPTIONS=--verbose $(MERMAID) --filter pandoc-fignos -f markdown+header_attributes -f markdown+smart -f markdown+emoji --indented-code-classes=bash,python,yaml
FORMAT=--toc --number-sections
BIB=--bibliography all.bib
FONTS=--epub-embed-font='fonts/*.ttf'
RESOURCE=--resource-path=$(IMAGE_DIRS)
CSL=--csl=template/ieee-with-url.csl



BROKEN=fa18-523-70

SPRING19_PAPERS=\
 fa18-516-29\
 fa18-523-68\
 fa18-523-85\
 fa18-523-86\
 fa18-423-08\
 hid-sp18-709  

SPRING19_PROJECTS=\
 fa18-516-29\
 fa18-523-68\
 fa18-523-85\
 fa18-523-86\
 fa18-423-08\
 hid-sp18-709  


OTHER=fa18-516-19 fa18-423-08


# FINAL
FALL18_PROJECTS=\
 fa18-516-08\
 fa18-516-11\
 fa18-516-14\
 fa18-516-17\
 fa18-516-18\
 fa18-516-21\
 fa18-516-22\
 fa18-523-52\
 fa18-523-53\
 fa18-523-56\
 fa18-523-57\
 fa18-523-60\
 fa18-523-61\
 fa18-523-62\
 fa18-523-65\
 fa18-523-66\
 fa18-523-71\
 fa18-523-80\
 fa18-523-83\
 fa18-523-88\
 fa18-423-03\
 hid-sp18-602\
 hid-sp18-705\
 hid-sp18-523\
 fa18-523-81\
 fa18-523-73\
 fa18-523-63

FALL18_PAPERS=\
 fa18-516-06\
 fa18-516-08\
 fa18-516-17\
 fa18-523-52\
 fa18-523-53\
 fa18-523-56\
 fa18-523-57\
 fa18-523-58\
 fa18-523-61\
 fa18-523-65\
 fa18-523-62\
 fa18-523-71\
 fa18-523-73\
 fa18-523-74\
 fa18-523-79\
 fa18-523-85\
 hid-sp18-602\
 hid-sp18-520\
 hid-sp18-523\
 fa18-523-82\
 fa18-523-66\
 fa18-523-80\
 fa18-523-81\
 fa18-523-88\
 fa18-523-63



DIRS=$(DIRS_516) $(DIRS_523) $(DIRS_423) $(DIRS_SP18) $(TODO)

DIRS_PAPERS=$(DIRS_516) $(DIRS_523) $(DIRS_SP18)

.PHONY: $(DIRS) all bib dest

#all: clean $(DIRS)
all: clean $(DIRS) bib projects papers

#PROJECT_VOL10: 

#PAPER_VOL10: fa18-516-04/section/vs-code.md

help:
	@cat README.md


spring19: spring19projects spring19papers
	ebook-convert vonLaszewski-proceedings-sp19-projects.epub vonLaszewski-proceedings-sp19-projects.pdf
	ebook-convert vonLaszewski-proceedings-sp19-papers.epub vonLaszewski-proceedings-sp19-papers.pdf

#bib dest/fonts $(SPRING19_PROJECTS)


spring19projects:
	make -f Makefile clean
	echo $(SPRING19_PROJECTS)
	mkdir -p dest
	echo > dest/projects.md
	cat project-report/report.md >> dest/report.md
	echo > dest/all-in.md
	echo > dest/all.bib
	for i in $(SPRING19_PROJECTS); do \
		cat $$i/project-report/report.md >> dest/all-in.md ; \
		echo "\n" >> dest/all-in.md ; \
		cat $$i/project-report/report.bib >> dest/all.bib ; \
		cat $$i/paper/paper.bib >> dest/all.bib ; \
	done ;
	cd dest; iconv -t utf-8 all-in.md >> all.md
	#cd dest; cat ../other-papers.md > all.md
	#cd dest; cat ../list.md >> all.md

	cp -r template dest
	cp metadata-projects.yaml dest/metadata.yaml
	cd dest; pandoc $(RESOURCE) $(MARKDOWN-OPTIONS)  $(FORMAT) $(FONTS) $(BIB)  $(CSL) $(CSS) -o $(FILENAME_SP19)-projects.epub metadata.yaml all.md
	cp dest/$(FILENAME_SP19)-projects.epub . 
#	cd dest; pandoc $(RESOURCE) --number-sections -V secnumdepth:5 --pdf-engine=xelatex -f markdown+smart --toc --epub-embed-font='fonts/*.ttf' --template=../template/eisvogel/eisvogel.latex --listings --bibliography all.bib -o $(FILENAME_SP19).pdf metadata.txt $(INDEX)
	echo "open $(FILENAME_SP19)-projects.epub"



#bib dest/fonts $(SPRING19_PAPERS)
spring19papers:
	make -f Makefile clean
	echo $(SPRING19_PAPERS)
	mkdir -p dest
	echo > dest/projects.md
	cat paper/paper.md >> dest/paper.md
	echo > dest/all-in.md
	echo > dest/all.bib
	for i in $(SPRING19_PAPERS); do \
		cat $$i/paper/paper.md >> dest/all-in.md ; \
		echo "\n" >> dest/all-in.md ; \
		cat $$i/paper/paper.bib >> dest/all.bib ; \
	done ;
	cd dest; iconv -t utf-8 all-in.md >> all.md
	#cd dest; cat ../other-papers.md > all.md
	#cd dest; cat ../list.md >> all.md
	cd dest; echo "# Refernces\n\n" >> all.md
	cp -r template dest
	cp metadata-papers.yaml dest/metadata.yaml
	cd dest; pandoc $(RESOURCE) $(MARKDOWN-OPTIONS)  $(FORMAT) $(FONTS) $(BIB)  $(CSL) $(CSS) -o $(FILENAME_SP19)-papers.epub metadata.yaml all.md
	cp dest/$(FILENAME_SP19)-papers.epub . 
#	cd dest; pandoc $(RESOURCE) --number-sections -V secnumdepth:5 --pdf-engine=xelatex -f markdown+smart --toc --epub-embed-font='fonts/*.ttf' --template=../template/eisvogel/eisvogel.latex --listings --bibliography all.bib -o $(FILENAME_SP19).pdf metadata.txt $(INDEX)
	echo "open $(FILENAME_SP19)-papers.epub"




fall18: fall18projects fall18papers
	ebook-convert vonLaszewski-proceedings-fa18-projects.epub vonLaszewski-proceedings-fa18-projects.pdf
	ebook-convert vonLaszewski-proceedings-fa18-papers.epub vonLaszewski-proceedings-fa18-papers.pdf

#bib dest/fonts $(FALL18_PROJECTS)

fall18projects:
	make -f Makefile clean
	echo $(FALL18_PROJECTS)
	mkdir -p dest
	echo > dest/projects.md
	cat project-report/report.md >> dest/report.md
	echo > dest/all-in.md
	echo > dest/all.bib
	for i in $(FALL18_PROJECTS); do \
		cat $$i/project-report/report.md >> dest/all-in.md ; \
		echo "\n" >> dest/all-in.md ; \
		cat $$i/project-report/report.bib >> dest/all.bib ; \
		cat $$i/paper/paper.bib >> dest/all.bib ; \
	done ;
	cd dest; iconv -t utf-8 all-in.md >> all.md
	#cd dest; cat ../other-papers.md > all.md
	#cd dest; cat ../list.md >> all.md

	cp -r template dest
	cp metadata-projects.yaml dest/metadata.yaml
	cd dest; pandoc $(RESOURCE) $(MARKDOWN-OPTIONS)  $(FORMAT) $(FONTS) $(BIB)  $(CSL) $(CSS) -o $(FILENAME_FA18)-projects.epub metadata.yaml all.md
	cp dest/$(FILENAME_FA18)-projects.epub . 
#	cd dest; pandoc $(RESOURCE) --number-sections -V secnumdepth:5 --pdf-engine=xelatex -f markdown+smart --toc --epub-embed-font='fonts/*.ttf' --template=../template/eisvogel/eisvogel.latex --listings --bibliography all.bib -o $(FILENAME_FA18).pdf metadata.txt $(INDEX)
	echo "open $(FILENAME_FA18)-projects.epub"



#bib dest/fonts $(FALL18_PAPERS)
fall18papers:
	make -f Makefile clean
	echo $(FALL18_PAPERS)
	FILENAME_FA18=vonLaszewski-proceedings-fa18
	mkdir -p dest
	echo > dest/projects.md
	cat paper/paper.md >> dest/paper.md
	echo > dest/all-in.md
	echo > dest/all.bib
	for i in $(FALL18_PAPERS); do \
		cat $$i/paper/paper.md >> dest/all-in.md ; \
		echo "\n" >> dest/all-in.md ; \
		cat $$i/paper/paper.bib >> dest/all.bib ; \
	done ;
	cd dest; iconv -t utf-8 all-in.md >> all.md
	#cd dest; cat ../other-papers.md > all.md
	#cd dest; cat ../list.md >> all.md
	cd dest; echo "# Refernces\n\n" >> all.md
	cp -r template dest
	cp metadata-papers.yaml dest/metadata.yaml
	cd dest; pandoc $(RESOURCE) $(MARKDOWN-OPTIONS)  $(FORMAT) $(FONTS) $(BIB)  $(CSL) $(CSS) -o $(FILENAME_FA18)-papers.epub metadata.yaml all.md
	cp dest/$(FILENAME_FA18)-papers.epub . 
#	cd dest; pandoc $(RESOURCE) --number-sections -V secnumdepth:5 --pdf-engine=xelatex -f markdown+smart --toc --epub-embed-font='fonts/*.ttf' --template=../template/eisvogel/eisvogel.latex --listings --bibliography all.bib -o $(FILENAME_FA18).pdf metadata.txt $(INDEX)
	echo "open $(FILENAME_FA18)-papers.epub"



$(DIRS):
	[ -e $@ ] ||	git clone git@github.com:cloudmesh-community/$@.git 
	cd $@; git pull


fix:
	-for i in $(DIRS); do \
		echo "\n-------------\n"$$i"\n-------------\n"; cd $$i ; git commit -m "update" . ; git push ; cd .. ; \
	done ;

status:
	-for i in $(DIRS); do \
		echo "\n-------------\n"$$i"\n-------------\n"; cd $$i ; git status; cd .. ; \
	done ;

pull:
	-for i in $(DIRS); do \
		echo $$i; cd $$i ; git pull; cd .. ; \
	done ;

update: $(DIRS)

list:
	python list.py  > list.md
	pandoc list.md -o list.html --css=template/table.css
	git commit -m "update the list" list.md; git push


pdf:
	ebook-convert vonLaszewski-proceedings-fa18-projects.epub vonLaszewski-proceedings-fa18-projects.pdf
	ebook-convert vonLaszewski-proceedings-fa18-papers.epub vonLaszewski-proceedings-fa18-papers.pdf

push:
	-for i in $(DIRS); do \
		echo $$i ;\
		cd $$i ; git push; cd ..; \
	done ;

bib: dest/all.bib

dest/fonts:
	cp -r ../book/template/fonts dest/fonts


dest/all.bib: dest/projects.bib dest/papers.bib dest/tech.bib dest/report.bib dest/all.bib 
	cat dest/projects.bib dest/papers.bib dest/tech.bib dest/report.bib > dest/all.bib
	cd dest; dos2unix all.bib

dest/tech.bib:
	-for i in ../../cloudmesh/technologies/bib/*.bib; do \
			echo $$i; \
			cp $$i bib; \
			biber -q --tool -V $$i >> biber.log ; \
			cat $$i >> dest/tech.bib; \
	done

dest/report.bib:
	cp bib/report.bib dest

dest/projects.bib:
	mkdir -p dest
	mkdir -p bib
	rm -f */*.blg
	rm -f biber.log
	echo >> dest/projects.bib
	cp project-report/*.bib bib
	-for i in $(DIRS); do \
		if [ -e $$i/project-report/report.bib ] ; then \
			cp $$i/project-report/report.bib bib/report-$$i.bib; \
			biber -q --tool -V bib/report-$$i.bib >> biber.log ; \
			cat bib/report-$$i.bib >> dest/projects.bib; \
		fi ; \
	done ;
	rm -f */*.blg

dest/papers.bib:
	mkdir -p dest
	mkdir -p bib
	rm -f */*.blg
	rm -f biber.log
	echo >> dest/papers.bib
	mkdir -p dest/images
	cp */paper/images/* dest/images
	#cp papers/*.bib bib
	-for i in $(DIRS_PAPERS); do \
		if [ -e $$i/paper/paper.bib ] ; then \
			cp $$i/paper/paper.bib bib/paper-$$i.bib; \
			biber -q --tool -V bib/papr-$$i.bib >> biber.log ; \
			cat bib/paper-$$i.bib >> dest/papers.bib; \
		fi ; \
	done ;
	rm -f */*.blg

biblog:
	cat biber.log | fgrep "does not parse correctly"

#	cat biber.log | fgrep -v INFO | fgrep -v "Cannot find"



clean:
	rm -rf dest bib *.log
	find . -type f -name "*.blg" -exec rm -f {} \;
	find . -type f -name "*.bbl" -exec rm -f {} \;
	find . -type f -name "*_bibertool.bib" -exec rm -f {} \;

real-clean: clean
	rm -rf fa18*
