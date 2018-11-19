# Sorts the Xcode project file to helps with minimizing merge conflicts.
sort:
	@perl ./bin/sortXcodeProject ToDoList.xcodeproj/project.pbxproj

# Check out and build the project's dependencies.
bootstrap:
	@carthage bootstrap --platform iOS --no-use-binaries --use-ssh

# Update and rebuild the project's dependencies.
update:
	@carthage update --platform iOS --no-use-binaries --use-ssh

unit-tests:
	@xcodebuild -project ToDoList.xcodeproj -scheme "ToDoList" -destination "platform=iOS Simulator,OS=12.0,name=iPhone 8" build test

units tests: sort unit-tests

ci: bootstrap unit-tests
