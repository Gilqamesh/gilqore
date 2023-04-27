.PHONY: update_modules
update_modules: ## update modules
	@$(PYTHON) $(PATH_MK_FILES)/module_template.py

.PHONY: update_tests
update_tests: ## update tests
	@$(PYTHON) $(PATH_MK_FILES)/test_template.py

.PHONY: update_rst
update_rst: ## update rst
	@$(PYTHON) $(PATH_MK_FILES)/sphinx_update.py
