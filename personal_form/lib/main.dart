import 'package:flutter/material.dart';

void main() {
  runApp(PersonalForm());
}

class PersonalForm extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Form(),
      theme: ThemeData().copyWith(
        colorScheme:
            ThemeData().colorScheme.copyWith(primary: Colors.blueGrey.shade700),
      ),
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
          "Application",
          style: TextStyle(color: Colors.white),
        ),
        actions: [
          IconButton(
            onPressed: () {},
            icon: Icon(Icons.more_vert, color: Colors.white),
          )
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
                decoration: InputDecoration(
                  hintText: "First name",
                  enabledBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: Colors.grey.shade400),
                  ),
                  hintStyle: TextStyle(color: Colors.grey.shade400),
                ),
              ),
              SizedBox(height: 15),
              TextField(
                decoration: InputDecoration(
                  hintText: "Last name",
                  enabledBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: Colors.grey.shade400),
                  ),
                  hintStyle: TextStyle(color: Colors.grey.shade400),
                ),
              ),
              SizedBox(height: 15),
              Row(
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        TextField(
                          decoration: InputDecoration(
                            hintText: "Birth Day",
                            helperText: "MM/DD/YYYY",
                            enabledBorder: UnderlineInputBorder(
                              borderSide:
                                  BorderSide(color: Colors.grey.shade400),
                            ),
                            hintStyle: TextStyle(color: Colors.grey.shade400),
                            helperStyle: TextStyle(color: Colors.grey.shade400),
                          ),
                        ),
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
                            hintText: "Social security",
                            helperText: "###-##-###",
                            enabledBorder: UnderlineInputBorder(
                              borderSide:
                                  BorderSide(color: Colors.grey.shade400),
                            ),
                            hintStyle: TextStyle(color: Colors.grey.shade400),
                            helperStyle: TextStyle(color: Colors.grey.shade400),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              SizedBox(height: 25),
              Text("Residence Address", style: TextStyle(fontSize: 20)),
              TextField(
                decoration: InputDecoration(
                  hintText: "Address",
                  enabledBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: Colors.grey.shade400),
                  ),
                  hintStyle: TextStyle(color: Colors.grey.shade400),
                ),
              ),
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Expanded(
                    child: TextField(
                      decoration: InputDecoration(
                        hintText: "City",
                        enabledBorder: UnderlineInputBorder(
                          borderSide: BorderSide(color: Colors.grey.shade400),
                        ),
                        hintStyle: TextStyle(color: Colors.grey.shade400),
                      ),
                    ),
                  ),
                  SizedBox(width: 10),
                  Expanded(
                    child: Column(
                      children: [
                        SizedBox(height: 17),
                        DropdownButton(
                          isExpanded: true,
                          underline: Container(
                            height: 1,
                            color: Colors.grey.shade400,
                          ),
                          hint: Text("State",
                              style: TextStyle(color: Colors.grey.shade400)),
                          onChanged: (s) => {},
                          items: <String>['State 1', 'State 2', 'State 3']
                              .map<DropdownMenuItem<String>>((String value) {
                            return DropdownMenuItem<String>(
                              value: value,
                              child: Text(value),
                            );
                          }).toList(),
                        )
                      ],
                    ),
                  ),
                ],
              ),
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Expanded(
                    child: TextField(
                      decoration: InputDecoration(
                        hintText: "Zip Code",
                        enabledBorder: UnderlineInputBorder(
                          borderSide: BorderSide(color: Colors.grey.shade400),
                        ),
                        hintStyle: TextStyle(color: Colors.grey.shade400),
                      ),
                    ),
                  ),
                  SizedBox(width: 10),
                  Expanded(
                    child: Column(
                      children: [
                        SizedBox(height: 17),
                        DropdownButton(
                          isExpanded: true,
                          underline: Container(
                            height: 1,
                            color: Colors.grey.shade400,
                          ),
                          hint: Text("Country",
                              style: TextStyle(color: Colors.grey.shade400)),
                          onChanged: (s) => {},
                          items: <String>['State 1', 'State 2', 'State 3']
                              .map<DropdownMenuItem<String>>((String value) {
                            return DropdownMenuItem<String>(
                              value: value,
                              child: Text(value),
                            );
                          }).toList(),
                        )
                      ],
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
