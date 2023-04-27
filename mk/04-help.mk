# Makefile help system

.PHONY: help
help:	## display help messages
	@$(PYTHON) mk/pyhelp.py $(MAKEFILE_LIST)
