.PHONY:default activate-tools clean create-package test

default:
	melos bs

activate-tools:
	dart pub global activate fvm
	fvm use
	dart pub global activate melos

clean:
	melos clean
	melos bs

create-package:
	chmod +x scripts/create-flutter-package.sh
	@scripts/create-flutter-package.sh $(name) $(folder)

test-flutter:
	melos run test:flutter --no-select

test-flutter-coverage:
	melos run test:flutterWithHtmlCoverage --no-select
