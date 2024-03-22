import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

void main() {
  runApp(PersonalForm());
}

class PersonalForm extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Form(),
      theme: ThemeData().copyWith(
          colorScheme: ThemeData()
              .colorScheme
              .copyWith(primary: Colors.blueGrey.shade700)),
    );
  }
}

class Form extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.primary,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () {},
        ),
        title: Text(
          "Aplication",
          style: TextStyle(color: Colors.white),
        ),
        actions: [
          IconButton(
              onPressed: () {},
              icon: Icon(Icons.more_vert, color: Colors.white))
        ],
      ),
      body: Container(
        padding: EdgeInsets.symmetric(horizontal: 16, vertical: 25),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("Personal Info", style: TextStyle(fontSize: 20)),
            TextField(
              decoration: InputDecoration(labelText: "First name"),
            ),
            SizedBox(height: 15),
            TextField(
              decoration: InputDecoration(labelText: "Last name"),
            ),
            SizedBox(height: 15),
            Row(
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      TextField(
                        decoration: InputDecoration(labelText: "Birth Day"),
                      ),
                      Text("MM/DD/YYYY")
                    ],
                  ),
                ),
                SizedBox(width: 15),
                Expanded(
                    child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    TextField(
                      decoration: InputDecoration(
                        labelText: "Social security",
                      ),
                    ),
                    Text("###-##-###")
                  ],
                ))
              ],
            ),
            SizedBox(height: 25),
            Text("Personal Info", style: TextStyle(fontSize: 20)),
          ],
        ),
      ),
    );
  }
}
