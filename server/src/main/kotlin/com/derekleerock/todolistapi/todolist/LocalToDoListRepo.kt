package com.derekleerock.todolistapi.todolist

import org.springframework.stereotype.Repository

@Repository
class LocalToDoListRepo : ToDoListRepo {
    private var toDoItems: MutableList<ToDoItem> = mutableListOf()

    override fun getAll(): List<ToDoItem> {
        return toDoItems
    }

    override fun create(newToDo: NewToDo): ToDoItem {
        val nextId = toDoItems.size + 1L
        val toDoItem = ToDoItem(nextId, newToDo.title, false)

        toDoItems.add(toDoItem)

        return toDoItem
    }
}
