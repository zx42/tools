# TOOLS_DIR := ../../../tools
# TOOL := goplate

all: export-win

export-win:
	bash -x make/release-scoop.sh
