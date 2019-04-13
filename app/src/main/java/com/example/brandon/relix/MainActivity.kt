package com.example.brandon.relix

import android.graphics.Color
import android.support.v7.app.AppCompatActivity
import android.os.Bundle
import android.view.View
import android.widget.*
import kotlinx.android.synthetic.main.activity_main.*
import kotlinx.android.synthetic.main.activity_main.view.*

/**
* VS Code Better Comments
* * Different Color
* ! Important
* ? Question
* TODO: Notes
* @param parameters
*/

 //*different color
 //!important
 //?question
 //TODO: Notes
 ///// strike out code


class MainActivity : AppCompatActivity() {
    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        setContentView(R.layout.activity_main)

        // Example of a call to a native method
        //sample_text.text = stringFromJNI()

        /*val addButton: Button = findViewById(R.id.addButton)
        addButton.setOnClickListener({
            val firstNum: EditText = findViewById(R.id.firstNumEditText)
            val secNum: EditText = findViewById(R.id.secondNumEditText)
            val result: TextView = findViewById(R.id.resultText)

            val num1: Int? = if(firstNum.text.toString().isNullOrEmpty()) null else firstNum.text.toString().toInt()
            val num2: Int? = if(secNum.text.toString().isNullOrEmpty()) null else secNum.text.toString().toInt()

            if(num1 != null && num2 != null)result.setText(add(num1,num2).toString())
            else{
                if(num1==null){
                    firstNum.setHint("Please enter a number")
                    firstNum.setHintTextColor(Color.RED)
                }
                if(num2==null){
                    secNum.setHint("Please enter a number")
                    secNum.setHintTextColor(Color.RED)
                }
            }
        })*/

        val types: Array<String> = GetItemTypeEnumArray()
        val spin: Spinner = findViewById((R.id.ItemTypesSpinner))
        val dataAdapter = ArrayAdapter(this, android.R.layout.simple_spinner_item, types)
        spin.adapter = dataAdapter

        /*spin.onItemSelectedListener = object : AdapterView.OnItemSelectedListener{
            override fun onItemSelected(parent: AdapterView<*>, view: View, position: Int, id: Long){

            }
            override fun onNothingSelected(p0: AdapterView<*>?) {

            }
        }*/

    }

    external fun add(num1: Int?,num2: Int?): Int
    external fun GetItemTypeEnumArray(): Array<String>

    companion object {

        // Used to load the 'native-lib' library on application startup.
        init {
            System.loadLibrary("native-lib")
            System.loadLibrary("Test")
            System.loadLibrary("Item")
        }
    }
}
