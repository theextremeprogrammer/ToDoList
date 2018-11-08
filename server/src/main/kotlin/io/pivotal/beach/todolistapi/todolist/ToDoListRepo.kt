package io.pivotal.beach.todolistapi.todolist

interface ToDoListRepo {
    fun getAll(): List<ToDoItem>
}
