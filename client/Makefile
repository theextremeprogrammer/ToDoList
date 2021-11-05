# Sorts the Xcode project folder/file structure. This helps with minimizing merge conflicts in teams.
sort:
	@perl ./bin/sortXcodeProject ToDoList.xcodeproj/project.pbxproj

# Check out and build all project dependencies using Carthage.
#    --platform iOS      Only build iOS frameworks. No need to waste time building for other platforms like MacOS or tvOS or WatchOS.
#    --no-use-binaries   Build dependencies locally instead of using a pre-built dependency (if provided)
#    --use-xcframeworks  XCFrameworks are required to support all architectures
#    --cache-builds      Speed up future dependency updates by only building those dependencies whose version has changed.
bootstrap:
	@carthage bootstrap --platform iOS --no-use-binaries --use-xcframeworks --cache-builds

# Update and rebuild the project's dependencies using Carthage.
update:
	@carthage update --platform iOS --no-use-binaries --use-xcframeworks --cache-builds

unit-tests:
	@/usr/bin/time xcodebuild -project ToDoList.xcodeproj -scheme "ToDoList" -destination "platform=iOS Simulator,OS=latest,name=iPhone 11" build test

units tests: sort unit-tests

ci: bootstrap unit-tests

bumpbuild:
	@xcrun agvtool next-version -all
