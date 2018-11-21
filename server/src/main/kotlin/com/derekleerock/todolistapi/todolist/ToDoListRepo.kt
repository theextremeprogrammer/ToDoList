package com.derekleerock.todolistapi.todolist

interface ToDoListRepo {
    fun getAll(): List<ToDoItem>
    fun create(newToDo: NewToDo): ToDoItem
}
