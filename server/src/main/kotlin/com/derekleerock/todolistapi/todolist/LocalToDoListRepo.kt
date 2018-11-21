package com.derekleerock.todolistapi.todolist

import org.springframework.stereotype.Repository
import java.util.Arrays.asList

@Repository
class LocalToDoListRepo : ToDoListRepo {
    override fun getAll(): List<ToDoItem> {
        return emptyList()
    }

    override fun create(newToDo: NewToDo): ToDoItem {
        TODO("not implemented") //To change body of created functions use File | Settings | File Templates.
    }
}
