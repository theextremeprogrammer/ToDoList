package com.derekleerock.todolistapi.todolist

import org.hamcrest.CoreMatchers.`is`
import org.hamcrest.CoreMatchers.equalTo
import org.hamcrest.MatcherAssert.assertThat
import org.junit.Before
import org.junit.Test

class LocalToDoListRepoTest {
    lateinit var localToDoListRepo: LocalToDoListRepo

    @Before
    fun setUp() {
        localToDoListRepo = LocalToDoListRepo()
    }

    @Test
    fun getAll_returnsEmptyList_whenNoItems() {
        val toDos = localToDoListRepo.getAll()


        assertThat(toDos.size, `is`(equalTo(0)))
    }

    @Test
    fun create_returnsCreatedItem() {
        val toDoItem = localToDoListRepo.create(
                NewToDo("Buy groceries")
        )


        val expectedToDoItem = ToDoItem(1, "Buy groceries", false)
        assertThat(toDoItem, `is`(equalTo(expectedToDoItem)))
    }

    @Test
    fun getAll_returnsItem_whenCreatingSingleItem() {
        localToDoListRepo.create(
                NewToDo("Buy groceries")
        )


        val toDos = localToDoListRepo.getAll()
        assertThat(toDos.size, `is`(equalTo(1)))
        assertThat(toDos.first(), `is`(equalTo(ToDoItem(1, "Buy groceries", false))))
    }
}
