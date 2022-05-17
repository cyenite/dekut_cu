import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:mpesa/mpesa.dart';

class PaymentHelper {
  static Future<String> stkPush(String phone, String amount) async {
    String phoneFormat = phone;
    final Map<String, dynamic> paymentData = {
      "amount": amount,
      "phone": phone,
      "customerId": "1",
      "orderId": "Test",
    };
    var response = await http.post(
      Uri.parse(
          "https://us-central1-test-69dc3.cloudfunctions.net/payments/mpesa/request/"),
      body: paymentData,
      headers: {'apiKey': "CR0wDuC4T3"},
    );

    print(response.body);
    final Map<String, dynamic> responseData = json.decode(response.body);
    return responseData['message'];
  }

  static Mpesa mpesa = Mpesa(
    clientKey: "jjjABXY5KtrZFK4xTYicbIe1voCWi6yP",
    clientSecret: "tBein4KmPI11iMgb",
    passKey: "bfb279f9aa9bdbcf158e97dd71a467cd2e0c893059b10f78e6b72ada1ed2c919",
    //initiatorPassword: "Akron254",
    environment: "sandbox",
  );
}
