package com.derekleerock.todolistapi.todolist

import org.springframework.stereotype.Repository
import java.util.Arrays.asList

@Repository
class LocalToDoListRepo : ToDoListRepo {
    override fun getAll(): List<ToDoItem> {
        return emptyList()
    }

    override fun create(newToDo: NewToDo): ToDoItem {
        return ToDoItem(1, newToDo.title, false)
    }
}
