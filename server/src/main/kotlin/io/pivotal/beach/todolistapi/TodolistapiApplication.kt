package io.pivotal.beach.todolistapi

import org.springframework.boot.autoconfigure.SpringBootApplication
import org.springframework.boot.runApplication

@SpringBootApplication
class TodolistapiApplication

fun main(args: Array<String>) {
    runApplication<TodolistapiApplication>(*args)
}
