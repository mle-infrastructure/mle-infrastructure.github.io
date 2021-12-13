build-docs:
	# Deploy documentation homepage: https://mle-infrastructure.github.io
	python -m pip install --upgrade pip
	pip install mkdocs-material
	mkdocs build
