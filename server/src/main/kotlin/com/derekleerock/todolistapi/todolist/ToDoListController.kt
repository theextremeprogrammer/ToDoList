package com.derekleerock.todolistapi.todolist

import org.springframework.web.bind.annotation.GetMapping
import org.springframework.web.bind.annotation.RequestMapping
import org.springframework.web.bind.annotation.RestController

@RestController
@RequestMapping("/todolist")
class ToDoListController(val toDoListRepo: ToDoListRepo) {
    @GetMapping
    fun getToDoList(): List<ToDoItem>? {
        return toDoListRepo.getAll()
    }
}
