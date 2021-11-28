defaults := defaults/site
md_dir := markdown
md_sources := $(wildcard $(md_dir)/*.md)
html_dir := portfolio_web
html_targets := $(subst $(md_dir), $(html_dir),$(subst .md,.html,$(md_sources)))
html_layout := ./layouts/site.html

sitepath=/Users/heades/website/heades.github.io/portfolio

all : $(html_targets)

$(html_dir)/%.html : $(md_dir)/%.md Makefile ${html_layout} ${defaults}.yaml
	pandoc -s -d $(defaults) -o $@ $<

serve :
	http-server

watch :
	find $(md_dir) layouts | entr -c 'make'

push: all
	cp -R $(html_dir)/* $(sitepath)
	cd $(sitepath) && git add . && git commit -a -m 'Updating Portfolio Website.' && git push

clean :
	rm -f $(html_dir)/*.html
