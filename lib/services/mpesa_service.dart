import 'package:dekut_cu/services/database_helper.dart';
import 'package:mpesa/mpesa.dart';

class PaymentHelper {
  static Mpesa mpesa = Mpesa(
    clientKey: "jjjABXY5KtrZFK4xTYicbIe1voCWi6yP",
    clientSecret: "tBein4KmPI11iMgb",
    passKey: "bfb279f9aa9bdbcf158e97dd71a467cd2e0c893059b10f78e6b72ada1ed2c919",
    //initiatorPassword: "Akron254",
    environment: "sandbox",
  );

  static makePayment(String phoneNumber, String amount, String reference) {
    mpesa
        .lipaNaMpesa(
      phoneNumber: phoneNumber,
      amount: double.parse(amount),
      businessShortCode: "174379",
      accountReference: reference,
      callbackUrl: "https://dekutcallback.herokuapp.com/callback",
    )
        .then((result) {
      DbHelper.createTempTransaction(result.CheckoutRequestID, reference);
      print(result.CheckoutRequestID);
      print(result.CustomerMessage);
    }).catchError((error) {
      print(error);
    });
  }
}
