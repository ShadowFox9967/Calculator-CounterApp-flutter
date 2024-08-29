import 'package:flutter/material.dart';
class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Home Page"),
        backgroundColor: Colors.blue,
        centerTitle: true,
      ),
      drawer: Drawer(
        backgroundColor: Colors.deepPurple[100],
        child:Column(
          children: [
            //Drawer Header
            DrawerHeader(
              child:Icon(
                Icons.favorite,
                size:48,
                ),
              ),
              //Home List Tile
              ListTile(
                leading: Icon(Icons.home),
                title: Text("H O M E"),
                onTap: (){
                  //pop drawer first
                  Navigator.pop(context);
                  //go to Home Page
                  Navigator.pushNamed(context,"/homepage");
                },
              ),
              //Calculator List Tile
              ListTile(
                leading: Icon(Icons.calculate),
                title: Text("C A L C U L A T O R"),
                onTap: (){
                  //pop
                  Navigator.pop(context);
                  //go to Calculator Page
                  Navigator.pushNamed(context, "/calculatorpage");
                }
              ),
              //Counter list Tile
              ListTile(
                leading:Icon(Icons.add_circle),
                title: Text("C O U N T E R"),
                onTap:(){
                  //pop
                  Navigator.pop(context);
                  //go to Counter page
                  Navigator.pushNamed(context,"/counterpage");
                }
              )
          ],
        )
      ),
      body: Center(
        child: Container(
          child: Text(
            "Welcome!",
            style:TextStyle(fontSize: 32, fontWeight: FontWeight.bold, color:Colors.black),
            ),
        ),
      ),
    );
  }
}