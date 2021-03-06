## Show commands help git
.PHONY: git.help
git.help:
	@echo '    git:'
	@echo ''
	@echo '        git                 show help'
	@echo '        git.hooks           install hooks script to git'
	@echo '        git.setup           install dependences to application'
	@echo '        git.ignore          ignore dependences to application'
	@echo '        git.reviews         add revieweers to git config'
	@echo ''

## Show commands git
.PHONY: git
git:
	@if [ -z "${command}" ]; then \
		make git.help;\
	fi


## Setup all actions git ignore.
.PHONY: git.setup
git.setup:
	@echo "==> setup git..."
	make git.ignore
	make git.hooks
	make git.reviews

## Setup git hooks files.
.PHONY: git.hooks
git.hooks:
	@echo "==> git setup hooks..."
	@rsync -avhP  provision/git/hooks/ .git/hooks/
	@chmod +x .git/hooks/*
	@echo ${MESSAGE_HAPPY}

## Generate git ignore of files.
.PHONY: git.ignore
git.ignore:
	@echo "==> git ignore generated..."
	@$(GI) ${GIT_IGNORES} > .gitignore
	@for ignore in ${GIT_IGNORES_CUSTOM} ; do \
		echo "$${ignore}" >> .gitignore ; \
    done
	@echo ${MESSAGE_HAPPY}

## Add reviewers to git config.
.PHONY: git.reviews
git.reviews:
	@echo "==> add issues revievers..."
	@git config github.reviews "${REVIEWERS}"
	@echo ${MESSAGE_HAPPY}
