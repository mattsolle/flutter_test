.PHONY:default activate-tools clean create-package

default:
	melos bs

activate-tools:
	dart pub global activate fvm
	flutter pub global activate melos

clean:
	melos clean
	melos bs

create-package:
	chmod +x scripts/create-flutter-package.sh
	@scripts/create-flutter-package.sh $(name) $(folder)
