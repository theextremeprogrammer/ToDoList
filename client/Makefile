# Sorts the Xcode project folder/file structure. This helps with minimizing merge conflicts in teams.
sort:
	@perl ./bin/sortXcodeProject ToDoList.xcodeproj/project.pbxproj

unit-tests:
	@/usr/bin/time xcodebuild -project ToDoList.xcodeproj -scheme "ToDoList" -destination "platform=iOS Simulator,OS=latest,name=iPhone 11" build test

units tests: sort unit-tests

ci: unit-tests

bumpbuild:
	@xcrun agvtool next-version -all
