// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';

import 'dart:convert';

import 'package:http/http.dart' as http;

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: LoveCalculator(),
      theme: ThemeData(primarySwatch: Colors.pink),
    );
  }
}

class LoveCalculator extends StatefulWidget {
  const LoveCalculator({Key? key}) : super(key: key);

  @override
  State<LoveCalculator> createState() => _LoveCalculatorState();
}

class _LoveCalculatorState extends State<LoveCalculator> {
  dynamic list;
  String first = '';
  String second = '';
  bool isloading = true;

  Future lovedata() async {
    var url =
        "https://simple-love-calculator.p.rapidapi.com/calculate_with_random_seed/$first/$second";
    var headers = {
      "X-RapidAPI-Key": "aa88f229a0msh5dedef82ddfc4ddp1e64fbjsn95ad32b6de04",
    };

    final response = await http.get(Uri.parse(url), headers: headers);
    if (response.statusCode == 200) {
      var data = jsonDecode(response.body);
      setState(() {
        list = data['value'];
        debugPrint(list.toString());
        isloading = false;
      });
    } else {
      throw Exception("get data failed");
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Container(
          decoration: BoxDecoration(
              image: DecorationImage(
                  image: AssetImage("Asset/love.jpg"), fit: BoxFit.cover)),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              isloading
                  ? Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        "",
                        style: TextStyle(fontSize: 25, color: Colors.yellow),
                      ),
                    )
                  : Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        list.toString() + '% ♥',
                        style: TextStyle(
                            fontSize: 50,
                            color: Colors.black38,
                            fontWeight: FontWeight.bold),
                      ),
                    ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextFormField(
                  decoration: InputDecoration(
                      hintText: "Enter King Name",
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(20))),
                  onChanged: (a) {
                    setState(() {
                      first = a.trim();
                    });
                  },
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextField(
                    decoration: InputDecoration(
                        hintText: "Enter queen Name",
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(20))),
                    onChanged: (b) {
                      setState(() {
                        second = b.trim();
                      });
                    }),
              ),
              SizedBox(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Center(
                      child: ElevatedButton(
                          onPressed: () {
                            setState(() async {
                              await lovedata();
                            });
                          },
                          child: Text(
                            "♡",
                            style: TextStyle(color: Colors.white, fontSize: 30),
                          ))),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
