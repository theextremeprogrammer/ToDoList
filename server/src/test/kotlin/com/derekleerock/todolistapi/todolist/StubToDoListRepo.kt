package com.derekleerock.todolistapi.todolist

class StubToDoListRepo : ToDoListRepo {
    var getAll_returnValue: List<ToDoItem> = emptyList()
    override fun getAll(): List<ToDoItem> {
        return getAll_returnValue
    }



    var create_argument_newToDo: NewToDo? = null
        private set
    var create_returnValue: ToDoItem = ToDoItemFixture.empty()

    override fun create(newToDo: NewToDo): ToDoItem {
        create_argument_newToDo = newToDo
        return create_returnValue
    }
}
