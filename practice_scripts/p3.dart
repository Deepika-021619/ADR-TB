import 'dart:io';
String isName (){
    print("Please enter your name:");
    String? name=stdin.readLineSync();
    if (name==null || name.trim().isEmpty){
        return"Name required.";
    } else {
        return "Hello, $name! How are you doing today?";
    }
}

void main (){
    print (isName());
}