package com.derekleerock.todolistapi.todolist

class StubToDoListRepo : ToDoListRepo {
    var getAll_returnValue: List<ToDoItem> = emptyList()
    override fun getAll(): List<ToDoItem> {
        return getAll_returnValue
    }



    var create_argument_newToDo: NewToDo? = null
        private set
    override fun create(newToDo: NewToDo) {
        create_argument_newToDo = newToDo
    }
}
