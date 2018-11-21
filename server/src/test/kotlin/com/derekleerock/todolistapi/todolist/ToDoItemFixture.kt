package com.derekleerock.todolistapi.todolist

class ToDoItemFixture {
    companion object {
        fun empty(): ToDoItem = ToDoItem(-1, "", false)
    }
}