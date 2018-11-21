package com.derekleerock.todolistapi.todolist

import org.springframework.http.HttpStatus.CREATED
import org.springframework.web.bind.annotation.*

@RestController
@RequestMapping("/todos")
class ToDoListController(val toDoListRepo: ToDoListRepo) {
    @GetMapping
    fun getToDoList(): List<ToDoItem>? {
        return toDoListRepo.getAll()
    }

    @PostMapping
    @ResponseStatus(value = CREATED)
    fun createToDoItem() {
    }
}
