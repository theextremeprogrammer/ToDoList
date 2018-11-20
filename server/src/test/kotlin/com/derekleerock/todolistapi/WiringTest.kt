package com.derekleerock.todolistapi

import org.hamcrest.CoreMatchers.equalTo
import org.hamcrest.MatcherAssert.assertThat
import org.hamcrest.Matchers.`is`
import org.junit.Test

class WiringTest {
    @Test
    fun wiringTest() {
        val twelve = 12


        assertThat(twelve, `is`(equalTo(12)))
    }
}