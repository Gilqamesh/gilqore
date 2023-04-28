.PHONY: update_modules
update_modules: ## update modules
	@$(PYTHON) $(PATH_MK_FILES)/module_template.py $(PLATFORM)

.PHONY: update_tests
update_tests: ## update tests
	@$(PYTHON) $(PATH_MK_FILES)/test_template.py $(PLATFORM)

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
