# To Do List iOS Client App + Kotlin Spring Server

[![Build Status](https://travis-ci.org/derekleerock/ToDoList.svg?branch=master)](https://travis-ci.org/derekleerock/ToDoList)

The world clearly doesn't need another to-do list app - however I wanted to build a simple iOS app to illustrate how I have been approaching test-driving iOS development lately.

The purpose of this app is to showcase how to test-drive out various typical aspects of an iOS app client with a Kotlin Spring back-end.

I typically don't write many, of any, comments in code these days. However I broke this rule for this project specifically so readers could understand some of the "why?" behind these approaches.

This code is the result of several years of TDD'ing iOS apps, reading books on testing and engineering topics, and input and influence from a number of people who have taught me so many things.

## iOS Client Functionality
Ideally my goal is to illustrate at least the following features and functionality, completely test-driven:

### Project Organization / Automation / Discoverability
- [x] How to arrange your folders and files using an "Application", "Components", and "UI" structure to provide separation of concerns. Inspired by the [App Continuum](https://www.appcontinuum.io/).
- [x] How to sort your Xcode project file to minimize merge conflicts within the team.
- [x] How to use a Makefile to automate repetitive tasks and increase discoverability.
- [x] CI integration with Travis.
  - [x] iOS Client Unit Test Job
  - [x] Kotlin Unit Test Job
  - [x] Kotlin Integration Test Job
- [x] How to automate bumping the build # for your app.
- [x] How to manage different release types (local development, beta, release, etc).

### Testing
- [x] How to execute your tests without launching the application's AppDelegate class.
- [x] How to test-drive your app delegate and use dependency injection (DI) from the moment the app starts.
- [ ] How to roll your own test-doubles using protocol-oriented programming as well as examples of each [kind of test double](https://engineering.pivotal.io/post/the-test-double-rule-of-thumb/).
  - [x] Dummy
  - [x] Spy
  - [x] Stub
  - [ ] Mock
  - [ ] Fake
- [x] How to implement the Repository pattern using an asynchronous Http call using promises/futures.
- [x] How to deserialize JSON data into a model object using the Codable protocol.

### Networking
- [ ] How to make HTTP requests without importing a networking framework.
  - [x] GET request
  - [x] POST request
  - [ ] PUT request
  - [ ] DELETE request
- [ ] Examples of how to handle errors from HTTP requests

### Navigation
- [x] Displaying a modal view controller.
- [x] Dismissing a modal view controller.
- [ ] Using the Router pattern to push a new view controller onto the stack. (Tap cell to navigate to detail VC.)
- [ ] Popping a view controller off of the stack.

### UI
- [x] How to make an Http call to retrieve data from a repository.
- [x] How to test-drive reloading a UITableView or UICollectionView.
- [x] How to use PureLayout to lay out the view hierarchy without using Storyboards.
- [ ] How to access images using an enum for compile-time safety when working with images.
- [ ] How to style UI components using pre-defined enum styles.
- [ ] How to configure a scrollview for a View Controller using PureLayout.

## Kotlin Spring Server Functionality

### REST API Endpoints
- [ ] Using unit-tests to test-drive controller endpoints.
  - [x] GET Endpoint - List of ToDoItems
  - [x] POST Endpoint - Create a new ToDoItem
  - [ ] PUT Endpoint - Update an existing ToDoItem
  - [ ] DELETE Endpoint - Delete an existing ToDoItem

### Testing
- [x] How to break out your integration tests from your unit tests so they can be run separately.

### Repository
- [ ] How to implement the Repository pattern for an in-memory store.
  - [x] Get list of ToDoItems
  - [x] Create a new ToDoItem
  - [ ] Update an existing ToDoItem
  - [ ] Delete an existing ToDoItem

## License
ToDoList is licensed under the MIT License. Please see the [`LICENSE`](https://github.com/derekleerock/ToDoList/blob/master/LICENSE) file.
