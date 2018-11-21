package com.derekleerock.todolistapi.todolist

import org.springframework.stereotype.Repository
import java.util.Arrays.asList

@Repository
class DefaultToDoListRepo : ToDoListRepo {
    override fun getAll(): List<ToDoItem> {
        return asList(
                ToDoItem(1L, "Pick up dry cleaning", false),
                ToDoItem(2L, "Mail holiday cards", false),
                ToDoItem(3L, "Buy birthday present for mom", false)
        )
    }

    override fun create(newToDo: NewToDo) {
        TODO("not implemented") //To change body of created functions use File | Settings | File Templates.
    }
}
