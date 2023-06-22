.PHONY: update_rst
update_rst: ## update rst
	@$(PYTHON) $(PATH_MK_FILES)/sphinx_update.py

.PHONY: help
help:	## display help messages
	@$(PYTHON) $(PATH_MK_FILES)/pyhelp.py $(MAKEFILE_LIST)

.PHONY: html
html:	## run Sphinx to generate html pages
	cd rst && \
	sphinx-build -b html -d _build/doctrees . ../docs
