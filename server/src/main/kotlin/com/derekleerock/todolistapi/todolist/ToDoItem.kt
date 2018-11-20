package com.derekleerock.todolistapi.todolist

data class ToDoItem(
        val id: Long,
        val title: String,
        val completed: Boolean
)
