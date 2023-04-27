# LINT		:= clang-format
# # LINTFLAGS	:= --repository=. --recursive --extensions=c,h --quiet
# LINTFLAGS	:= --style=file -i
# # LINTFLAGS	+= --filter=-build/include_subdir

# .PHONY: lint 
# lint:	$(ALLSRCS) $(ALLHDRS) $(TSTSRCS) ## Run c lint over project files
# 	@$(LINT) $(LINTFLAGS) $(ALLSRCS) $(ALLHDRS) $(TSTSRCS)
