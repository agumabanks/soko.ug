// import 'package:http/http.dart' as http;
// import 'dart:convert';



//   Future<void> signup() async {
//     final String url = 'https://soko.ug/api/v2/auth/signup'; // Replace with your actual API endpoint
//     final Map<String, dynamic> data = {
//       'name': nameController.text,
//       'email_or_phone': emailController.text,
//       'password': passwordController.text,
//     };

//     try {
//       final response = await http.post(
//         Uri.parse(url),
//         headers: {'Content-Type': 'application/json'},
//         body: jsonEncode(data),
//       );

//       if (response.statusCode == 201) {
//         // Registration successful
//         // You can navigate to the login screen or handle success accordingly
//         print('Registration successful');
//       } else {
//         // Handle errors, e.g., display an error message
//         print('Error: ${response.statusCode}');
//       }
//     } catch (e) {
//       // Handle exceptions
//       print('Exception: $e');
//     }
//   }
