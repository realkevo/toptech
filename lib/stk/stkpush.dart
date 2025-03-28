import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class SafaricomSTKForm extends StatefulWidget {
  @override
  _SafaricomSTKFormState createState() => _SafaricomSTKFormState();
}

class _SafaricomSTKFormState extends State<SafaricomSTKForm> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _phoneNumberController = TextEditingController();
  final String consumerKey = '6PJQEIrZhCA3SHEiOG0M3prExeXnWcGmLVFlTa76alZZrjcV';
  final String consumerSecret = 'Cwjc2yVN6iAQrHyM4hNHEUiTf7fmLGL2CulMv2rVGEjMMwERq4I1zo8MXfHkya7s';
  final String shortcode = 'N/A'; // You need the correct shortcode from Safaricom

  // Function to get the Access Token
  Future<String> getAccessToken() async {
    String basicAuth = 'Basic '
        + base64Encode(utf8.encode('$consumerKey:$consumerSecret'));
    final response = await http.get(
      Uri.parse(
          'https://sandbox.safaricom.co.ke/oauth/v1/generate?grant_type=client_credentials'
      ),
      headers: {
        'Authorization': basicAuth,
      },
    );

    if (response.statusCode == 200) {
      var jsonResponse = json.decode(response.body);
      return jsonResponse['access_token'];
    } else {
      throw Exception('Failed to get access token');
    }
  }

  // Function to send STK Push
  Future<void> sendSTKPush(String phoneNumber) async {
    try {
      String accessToken = await getAccessToken();

      var headers = {
        'Authorization': 'Bearer $accessToken',
        'Content-Type': 'application/json',
      };

      var body = json.encode({
        "BusinessShortcode": "",
        // Replace with your Safaricom shortcode
        "LipaNaMpesaOnlineShortcode": "",  // Use the same shortcode or the Lipa na M-Pesa shortcode
        "LipaNaMpesaOnlineShortcode": "9243011",
        "PhoneNumber": phoneNumber,
        "Amount": 1,  // Amount in Kenyan Shillings (for example 1 KES)
        "AccountReference": "Test123",
        "TransactionDescription": "Payment for goods"
      });

      final response = await http.post(
        Uri.parse
          ('https://api.safaricom.'
            'co.ke/mpesa/stkpush/v1/processrequest'),
        headers: headers,
        body: body,
      );

      if (response.statusCode == 200) {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text('STK Push Sent to $phoneNumber'),
        ));
      } else {
        throw Exception('Failed to send STK request');
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text('Error: $e'),
      ));
    }
  }

  void handleSTKRequest() {
    String phoneNumber = _phoneNumberController.text;

    if (phoneNumber.isNotEmpty) {
      sendSTKPush(phoneNumber);
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Please enter a valid phone number')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Safaricom STK Request'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              TextFormField(
                controller: _phoneNumberController,
                decoration: InputDecoration(
                  labelText: 'Enter Safaricom Number',
                  border: OutlineInputBorder(),
                  hintText: 'e.g., 0712345678',
                ),
                keyboardType: TextInputType.phone,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter a phone number';
                  }
                  return null;
                },
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    handleSTKRequest();
                  }
                },
                child: Text('Send STK'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

/*
import 'dart:convert';
import 'package:http/http.dart' as http;

import 'constants.dart';

Future<String> getAccessToken() async {
  final response = await http.get(
    Uri.parse(Constants.tokenUrl),
    headers: {
      'Authorization': 'Basic ' +
          base64Encode(utf8.encode('${Constants.consumerKey}:${Constants.consumerSecret}')),
    },
  );
  if (response.statusCode == 200) {
    final tokenData = jsonDecode(response.body);
    return tokenData['access_token'];
  } else {
    throw Exception('Failed to get access token');
  }
}
Future<void> sendStkPush({
  required String phoneNumber,
  required double amount,
}) async {
  try {
    String token = await getAccessToken();

    final headers = {
      'Authorization': 'Bearer $token',
      'Content-Type': 'application/json',
    };
    final body = jsonEncode({
      "BusinessShortCode": Constants.lipaNaMpesaShortcode,
      "Password": Constants.lipaNaMpesaShortcodePassword,
      "LipaNaMpesaOnlineShortcode": Constants.lipaNaMpesaShortcodeSecret,
      "PhoneNumber": phoneNumber,
      "Amount": amount,
      "AccountReference": "Test123",  // You can customize the account reference
      "TransactionDesc": "Payment for goods",
      "Shortcode": Constants.shortcode,
    });
    final response = await http.post(
      Uri.parse(Constants.lipaNaMpesaShortcodeURL),
      headers: headers,
      body: body,
    );

    if (response.statusCode == 200) {
      print('STK Push sent successfully');
    } else {print('Failed to send STK Push: ${response.statusCode}, ${response.body}');
    }
  } catch (e) {
    print('Error occurred: $e');
  }
}*/
