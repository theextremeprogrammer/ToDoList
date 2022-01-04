import XCTest
import Quick
import Nimble
import Succinct
@testable import ToDoList

final class NetworkToDoListRepositoryTest: XCTestCase {
    func testGettingAllToDoListItems() async {
        let spyHttp = SpyHttp()
        spyHttp.get_returnValue = "[]".data(using: .utf8)!
        let toDoListRepo = NetworkToDoListRepository(http: spyHttp)


        do {
            let _ = try await toDoListRepo.getAll()
        } catch {}


        XCTAssertEqual(spyHttp.get_argument_endpoint, "/todos")
    }
    
    func testWhenTheRequestIsSuccessful_returnsToDoItems() async {
        let spyHttp = SpyHttp()
        let jsonResponse = """
            [
              {
                "id": 1,
                "title": "Get groceries",
                "completed": false
              },
              {
                "id": 2,
                "title": "Pick up dry cleaning",
                "completed": true
              }
            ]
           """
        spyHttp.get_returnValue = jsonResponse.data(using: .utf8)!

        let toDoListRepo = NetworkToDoListRepository(http: spyHttp)


        var toDoItems: [ToDoItem] = []
        do {
            toDoItems = try await toDoListRepo.getAll()
        } catch {}

        
        XCTAssertEqual(toDoItems.count, 2)
        XCTAssertEqual(toDoItems.first?.id, 1)
        XCTAssertEqual(toDoItems.first?.title, "Get groceries")
        XCTAssertEqual(toDoItems.first?.completed, false)
        XCTAssertEqual(toDoItems.last?.id, 2)
        XCTAssertEqual(toDoItems.last?.title, "Pick up dry cleaning")
        XCTAssertEqual(toDoItems.last?.completed, true)
    }
    
    func testCreatingNewToDoItemHitsTheExpectedEndpoint() async {
        let spyHttp = SpyHttp()
        let jsonResponse = """
            {
              "id": 0,
              "title": "",
              "completed": false
            }
           """
        spyHttp.post_returnValue = jsonResponse.data(using: .utf8)!
        let toDoListRepo = NetworkToDoListRepository(http: spyHttp)

        let newToDo = NewToDoItemBuilder()
            .withTitle("Make restaurant reservation")
            .build()
        
        
        do {
            let _ = try await toDoListRepo.create(newToDo: newToDo)
        } catch {}
        
        
        expect(spyHttp.post_argument_endpoint).to(equal("/todos"))
    }
    
    func testCreatingNewToDoItemPassesRequestBody() async {
        let spyHttp = SpyHttp()
        let jsonResponse = """
            {
              "id": 0,
              "title": "",
              "completed": false
            }
           """
        spyHttp.post_returnValue = jsonResponse.data(using: .utf8)!
        let toDoListRepo = NetworkToDoListRepository(http: spyHttp)

        let newToDo = NewToDoItemBuilder()
            .withTitle("Make restaurant reservation")
            .build()
        
        
        do {
            let _ = try await toDoListRepo.create(newToDo: newToDo)
        } catch {}

        
        // Sadly if the JSON here doesn't perfectly match the JSON coming
        //      back from the call then this test fails - so we cannot format
        //      the JSON inside this string in a more readable way. This means
        //      that auto-formatting will break this layout. There must be a
        //      better way.
        let expectedJSON = """
            {"title":"Make restaurant reservation"}
            """
        let expectedJSONData = expectedJSON.data(using: .utf8)!
        expect(spyHttp.post_argument_requestBody).to(equal(expectedJSONData))
    }
    
    func testCreatingNewToDoItem_whenTheRequestIsSuccessful_returnsCreatedToDoItem() async {
        let spyHttp = SpyHttp()
        let jsonResponse = """
            {
              "id": 99,
              "title": "Make restaurant reservation",
              "completed": false
            }
           """
        spyHttp.post_returnValue = jsonResponse.data(using: .utf8)!
        let toDoListRepo = NetworkToDoListRepository(http: spyHttp)

        let newToDo = NewToDoItemBuilder()
            .withTitle("Make restaurant reservation")
            .build()
        
        
        var returnedToDoItem: ToDoItem? = nil
        do {
            returnedToDoItem = try await toDoListRepo.create(newToDo: newToDo)
        } catch {}

        
        let expectedToDoItem = ToDoItemBuilder()
            .withId(99)
            .withTitle("Make restaurant reservation")
            .withCompleted(false)
            .build()
        expect(returnedToDoItem).to(equal(expectedToDoItem))
    }
}
