package io.pivotal.beach.todolistapi.todolist

import org.springframework.stereotype.Repository

@Repository
class DefaultToDoListRepo : ToDoListRepo {
    override fun getAll(): List<ToDoItem> {
        return emptyList()
    }
}