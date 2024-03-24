// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/cupertino.dart';
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
      body: SingleChildScrollView(
        child: Container(
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
              Text("Residence Address", style: TextStyle(fontSize: 20)),
              TextField(decoration: InputDecoration(labelText: "Address")),
              Row(children: [
                Expanded(
                  child: TextField(
                    decoration: InputDecoration(labelText: "City"),
                  ),
                ),
                Expanded(
                  child: DropdownMenu(
                    initialSelection: "State",
                    dropdownMenuEntries: <DropdownMenuEntry<String>>[
                      DropdownMenuEntry(value: "State", label: "State"),
                      DropdownMenuEntry(value: "State", label: "State"),
                      DropdownMenuEntry(value: "State", label: "State"),
                    ],
                  ),
                ),
              ]),
              Row(children: [
                Expanded(
                  child: TextField(
                    decoration: InputDecoration(labelText: "Zip Code"),
                  ),
                ),
                Expanded(
                  child: DropdownMenu(
                    initialSelection: "Country",
                    dropdownMenuEntries: <DropdownMenuEntry<String>>[
                      DropdownMenuEntry(value: "Country", label: "Country"),
                      DropdownMenuEntry(value: "Country", label: "Country"),
                      DropdownMenuEntry(value: "Country", label: "Country"),
                    ],
                  ),
                ),
              ]),
              // Row(children: [
              //   Expanded(
              //     child: Column(
              //       crossAxisAlignment: CrossAxisAlignment.start,
              //       children: [
              //         TextField(
              //             decoration: InputDecoration(labelText: "Zip Code")),
              //         SizedBox(width: 15),
              //         // DropdownButton(items: const [
              //         //   DropdownMenuItem(child: Text("Country")),
              //         //   DropdownMenuItem(child: Text("Country")),
              //         //   DropdownMenuItem(child: Text("Country")),
              //         // ], onChanged: (dynamic) {})
              //       ],
              //     ),
              //   ),
              // ])
            ],
          ),
        ),
      ),
    );
  }
}
