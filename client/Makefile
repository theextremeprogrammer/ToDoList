# Sorts the Xcode project file to helps with minimizing merge conflicts.
sort:
	@perl ./bin/sortXcodeProject ToDoList.xcodeproj/project.pbxproj

# Check out and build the project's dependencies.
bootstrap:
	@carthage bootstrap --platform iOS --no-use-binaries --cache-builds

# Update and rebuild the project's dependencies.
update:
	@carthage update --platform iOS --no-use-binaries --cache-builds

unit-tests:
	@/usr/bin/time xcodebuild -project ToDoList.xcodeproj -scheme "ToDoList" -destination "platform=iOS Simulator,OS=latest,name=iPhone XR" build test

units tests: sort unit-tests

ci: bootstrap unit-tests

bumpbuild:
	@xcrun agvtool next-version -all
