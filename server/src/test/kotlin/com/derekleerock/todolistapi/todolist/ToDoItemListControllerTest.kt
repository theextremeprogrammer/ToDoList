package com.derekleerock.todolistapi.todolist

import org.hamcrest.CoreMatchers.equalTo
import org.junit.Before
import org.junit.Test
import org.springframework.test.web.servlet.MockMvc
import org.springframework.test.web.servlet.request.MockMvcRequestBuilders.get
import org.springframework.test.web.servlet.result.MockMvcResultMatchers.jsonPath
import org.springframework.test.web.servlet.result.MockMvcResultMatchers.status
import org.springframework.test.web.servlet.setup.MockMvcBuilders
import java.util.Arrays.asList

class ToDoItemListControllerTest {
    lateinit var stubToDoListRepo: StubToDoListRepo
    lateinit var mockMvc: MockMvc

    @Before
    fun setUp() {
        stubToDoListRepo = StubToDoListRepo()
        mockMvc = MockMvcBuilders
                .standaloneSetup(ToDoListController(stubToDoListRepo))
                .build()
    }

    @Test
    fun getToDoList_returnsOK() {
        mockMvc.perform(get("/todos"))
                .andExpect(status().isOk())
    }

    @Test
    fun getToDoList_returnsEmptyList_whenEmptyList() {
        stubToDoListRepo.getAll_returnValue = emptyList()


        mockMvc.perform(get("/todos"))
                .andExpect(jsonPath("$.size()", equalTo(0)))
    }

    @Test
    fun getToDoList_returnsTheExpectedNumberOfItems() {
        stubToDoListRepo.getAll_returnValue = asList(
                ToDoItem(1L, "Title", false),
                ToDoItem(2L, "Title", false)
        )


        mockMvc.perform(get("/todos"))
                .andExpect(jsonPath("$.size()", equalTo(2)))
    }

    @Test
    fun getToDoList_returnsToDoItems() {
        stubToDoListRepo.getAll_returnValue = asList(
                ToDoItem(1L, "Get groceries", false)
        )


        mockMvc.perform(get("/todos"))
                .andExpect(jsonPath("$[0].id", equalTo(1)))
                .andExpect(jsonPath("$[0].title", equalTo("Get groceries")))
                .andExpect(jsonPath("$[0].completed", equalTo(false)))
    }
}