package com.derekleerock.todolistapi.todolist

import org.hamcrest.CoreMatchers.`is`
import org.hamcrest.CoreMatchers.equalTo
import org.hamcrest.MatcherAssert.assertThat
import org.junit.Before
import org.junit.Test
import org.springframework.http.MediaType
import org.springframework.test.web.servlet.MockMvc
import org.springframework.test.web.servlet.request.MockMvcRequestBuilders.get
import org.springframework.test.web.servlet.request.MockMvcRequestBuilders.post
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

    @Test
    fun createToDoItem_returnsCreatedStatus() {
        val jsonRequest = "" +
                "{" +
                "    \"title\": \"Make turkey reservation\"" +
                "}"


        mockMvc.perform(post("/todos")
                .contentType(MediaType.APPLICATION_JSON_UTF8)
                .content(jsonRequest)
        )
                .andExpect(status().isCreated)
    }

    @Test
    fun createToDoItem_returnsExpectedJSON() {
        stubToDoListRepo.create_returnValue = ToDoItem(10, "Make turkey reservation", false)

        val jsonRequest = "" +
                "{" +
                "    \"title\": \"Make turkey reservation\"" +
                "}"

        mockMvc.perform(post("/todos")
                .contentType(MediaType.APPLICATION_JSON_UTF8)
                .content(jsonRequest)
        )
                .andExpect(jsonPath("$.id", equalTo(10)))
                .andExpect(jsonPath("$.title", equalTo("Make turkey reservation")))
                .andExpect(jsonPath("$.completed", equalTo(false)))
    }

    @Test
    fun createToDoItem_passesToDoDataToRepo() {
        val jsonRequest = "" +
                "{" +
                "    \"title\": \"Make turkey reservation\"" +
                "}"

        mockMvc.perform(post("/todos")
                .contentType(MediaType.APPLICATION_JSON_UTF8)
                .content(jsonRequest)
        )

        val expectedNewToDo = NewToDo("Make turkey reservation")
        assertThat(stubToDoListRepo.create_argument_newToDo, `is`(equalTo(expectedNewToDo)))
    }
}
