.PHONY: update_modules
update_modules: ## update modules
	@python $(PATH_MK_FILES)/module_template.py

.PHONY: update_tests
update_tests: ## update tests
	@python $(PATH_MK_FILES)/test_template.py
