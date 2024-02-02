import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import 'package:flutter/material.dart';
import 'dart:convert';

import 'api.dart';
// import 'package:soko_api/soko_api.dart';



class SignupScreen extends StatefulWidget {
  @override
  _SignupScreenState createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  Future<void> signup() async {
    final String url = 'https://soko.ug/api/v2/auth/signup'; // Replace with your actual API endpoint
    final Map<String, dynamic> data = {
      'name': nameController.text,
      'email_or_phone': emailController.text,
      'password': passwordController.text,
    };

    try {
      final response = await http.post(
        Uri.parse(url),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode(data),
      );

      if (response.statusCode == 201) {
        // Registration successful
        // You can navigate to the login screen or handle success accordingly
        print('Registration successful');
      } else {
        // Handle errors, e.g., display an error message
        print('Error: ${response.statusCode}');
      }
    } catch (e) {
      // Handle exceptions
      print('Exception: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Signup'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextField(
              controller: nameController,
              decoration: InputDecoration(labelText: 'Name'),
            ),
            TextField(
              controller: emailController,
              decoration: InputDecoration(labelText: 'Email'),
            ),
            TextField(
              controller: passwordController,
              decoration: InputDecoration(labelText: 'Password'),
              obscureText: true,
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: signup,
              child: Text('Signup'),
            ),
          ],
        ),
      ),
    );
  }
}

void main() {
  runApp(MaterialApp(
    home: SokoApp(),
  ));
}





class SokoApp extends StatefulWidget {
  @override
  _SokoAppState createState() => _SokoAppState();
}

class _SokoAppState extends State<SokoApp> {
  List<Datum> brands = [];

  @override
  void initState() {
    super.initState();
    _fetchBrands();
  }

  void _fetchBrands() async {
    final response = await SokoApi.getBrands();
    if (response.success) {
      setState(() {
        brands = response.data;
      });
    } else {
      // Handle error.
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Soko App'),
      ),
      body: ListView.builder(
        itemCount: brands.length,
        itemBuilder: (context, index) {
          return ListTile(
            title: Text(brands[index].name),
          );
        },
      ),
    );
  }
}




// To parse this JSON data, do
//
//     final brand = brandFromJson(jsonString);


Brand brandFromJson(String str) => Brand.fromJson(json.decode(str));

String brandToJson(Brand data) => json.encode(data.toJson());

class Brand {
    List<Datum> data;
    bool success;
    int status;

    Brand({
        required this.data,
        required this.success,
        required this.status,
    });

    factory Brand.fromJson(Map<String, dynamic> json) => Brand(
        data: List<Datum>.from(json["data"].map((x) => Datum.fromJson(x))),
        success: json["success"],
        status: json["status"],
    );

    Map<String, dynamic> toJson() => {
        "data": List<dynamic>.from(data.map((x) => x.toJson())),
        "success": success,
        "status": status,
    };
}

class Datum {
    String name;
    String logo;
    Links links;

    Datum({
        required this.name,
        required this.logo,
        required this.links,
    });

    factory Datum.fromJson(Map<String, dynamic> json) => Datum(
        name: json["name"],
        logo: json["logo"],
        links: Links.fromJson(json["links"]),
    );

    Map<String, dynamic> toJson() => {
        "name": name,
        "logo": logo,
        "links": links.toJson(),
    };
}

class Links {
    String products;

    Links({
        required this.products,
    });

    factory Links.fromJson(Map<String, dynamic> json) => Links(
        products: json["products"],
    );

    Map<String, dynamic> toJson() => {
        "products": products,
    };
}

