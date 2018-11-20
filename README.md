# To Do List iOS Client App + Kotlin Spring Server

[![Build Status](https://travis-ci.org/derekleerock/ToDoList.svg?branch=master)](https://travis-ci.org/derekleerock/ToDoList)

The world clearly doesn't need another to-do list app - however I wanted to build a simple iOS app to illustrate how I have been approaching test-driving iOS development lately.

The purpose of this app is to showcase how to test-drive out various typical aspects of an iOS app client with a Kotlin Spring back-end.

I typically don't write many, of any, comments in code these days. However I broke this rule for this project specifically so readers could understand some of the "why?" behind these approaches.

This code is the result of several years of TDD'ing iOS apps, reading books on testing and engineering topics, and input and influence from a number of people who have taught me so many things.

## iOS Client Functionality
Ideally my goal is to illustrate at least the following features and functionality, complete with tests:

### Project Organization / Automation / Discoverability
- [x] How to arrange your folders and files using an "Application", "Components", and "UI" structure to provide separation of concerns.
- [x] How to sort your Xcode project file to minimize merge conflicts within the team.
- [x] How to use a Makefile to automate repetitive tasks and increase discoverability.
- [ ] CI integration with Travis.
- [ ] How to automate bumping the build # for your app.
- [ ] How to manage different release types (local development, beta, release).

### Testing
- [x] How to execute your tests without launching the application's AppDelegate class.
- [x] How to test-drive your app delegate and use dependency injection (DI) from the moment the app starts.
- [ ] How to roll your own test-doubles using protocols as well as examples of each different kind of test double.
  - [ ] Dummy
  - [x] Spy
  - [ ] Stub
  - [ ] Mock
  - [ ] Fake
- [x] How to implement the Repository pattern using an asynchronous Http call using promises/futures.
- [x] How to deserialize JSON data into a model object using the Codable protocol.

### Networking
- [ ] How to make various HTTP requests without importing a framework.
  - [x] GET request
  - [ ] POST request
  - [ ] PUT request
  - [ ] DELETE request
- [ ] How to handle errors from HTTP requests

### Navigation
- [ ] Using the Router pattern to push a new view controller onto the stack.
- [ ] Popping a view controller off of the stack.
- [ ] Displaying a modal view controller.

### UI
- [x] How to test-drive reloading a UITableView or UICollectionView.
- [x] How to use PureLayout to lay out the view hierarchy without using Storyboards.
- [ ] How to access images using an enum for compile-time safety when working with images.
- [ ] How to style UI components using pre-defined enum styles.

## Kotlin Spring Server
- [x] Using unit-tests to test-drive controller endpoints.
- [x] How to break out your integration tests from your unit tests so they can be run separately.
- [x] How to implement the Repository pattern for retrieving data.

## License
ToDoList is licensed under the MIT License. Please see the [`LICENSE`](https://github.com/derekleerock/ToDoList/blob/master/LICENSE) file.
