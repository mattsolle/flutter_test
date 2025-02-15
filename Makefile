.PHONY:default activate-tools clean

default:
	melos bs

activate-tools:
	dart pub global activate fvm
	flutter pub global activate melos

clean:
	melos clean
	melos bs
