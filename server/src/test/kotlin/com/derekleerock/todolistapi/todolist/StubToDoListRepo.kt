package com.derekleerock.todolistapi.todolist

class StubToDoListRepo : ToDoListRepo {
    var getAll_returnValue: List<ToDoItem> = emptyList()
    override fun getAll(): List<ToDoItem> {
        return getAll_returnValue
    }
}
