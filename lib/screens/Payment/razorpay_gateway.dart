import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:razorpay_flutter/razorpay_flutter.dart';

class RazorpayIntegration extends StatefulWidget {
  const RazorpayIntegration({Key? key}) : super(key: key);

  @override
  _RazorPayPageState createState() => _RazorPayPageState();
}

class _RazorPayPageState extends State<RazorpayIntegration> {
  late Razorpay _razorpay;
  TextEditingController amtController = TextEditingController();

  void openCheckout(String amount) async {
    double numericAmount = double.parse(amount) * 100;
    var options = {
      'key': 'rzp_test_0pETLqnkNlWqdV',
      'amount': numericAmount.toInt(),
      'name': 'Pratik Rathod',
      'prefill': {
        'contact': '9637832563',
        'email': 'pratikrathod3954@gmail.com'
      },
      'external': {
        'wallets': ['paytm']
      }
    };
    try {
      _razorpay.open(options);
    } catch (e) {
      debugPrint('Error: $e');
    }
  }

  void handlePaymentSuccess(PaymentSuccessResponse response) {
    Fluttertoast.showToast(
        msg: "Payment Successful${response.paymentId!}",
        toastLength: Toast.LENGTH_SHORT);
  }

  void handlePaymentError(PaymentFailureResponse response) {
    Fluttertoast.showToast(
        msg: "Payment Fail${response.message!}", toastLength: Toast.LENGTH_SHORT);
  }

  void handleExternalWallet(ExternalWalletResponse response) {
    Fluttertoast.showToast(
        msg: "External Wallet${response.walletName!}", toastLength: Toast.LENGTH_SHORT);
  }

  @override
  void dispose() {
    super.dispose();
    _razorpay.clear();
  }

  @override
  void initState() {
    super.initState();
    _razorpay = Razorpay();
    _razorpay.on(Razorpay.EVENT_PAYMENT_SUCCESS, handlePaymentSuccess);
    _razorpay.on(Razorpay.EVENT_PAYMENT_ERROR, handlePaymentError);
    _razorpay.on(Razorpay.EVENT_EXTERNAL_WALLET, handleExternalWallet);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text("Payment Page"),
          centerTitle: true,
        ),
        body: SingleChildScrollView(
          child: Column(
            children: [
              const SizedBox(height: 10,),
              const Text("Razorpay Payment Gateway", style: TextStyle(
                  color: Colors.black, fontWeight: FontWeight.bold, fontSize: 18
              ), textAlign: TextAlign.center),

              const SizedBox(height: 30,),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextFormField(
                  controller: amtController,
                  cursorColor: Colors.black,
                  autofocus: false,
                  style: const TextStyle(color: Colors.black),
                  decoration: const InputDecoration(
                      labelText: "Enter Amount",
                      labelStyle: TextStyle(fontSize: 15.0, color: Colors.black),
                      border: OutlineInputBorder(
                          borderSide: BorderSide(
                            color: Colors.black,
                            width: 1.0,
                          )
                      ),
                      enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                              color: Colors.black,
                              width: 1.0
                          )
                      ),
                      errorStyle: TextStyle(color: Colors.redAccent, fontSize: 15)
                  ),
                  validator: (value){
                    if(value == null || value.isEmpty){
                      return "Please Enter Amount to be Paid";
                    }
                    return null;
                  },
                ),
              ),
              const SizedBox(height: 30,),
              ElevatedButton(
                onPressed: () {
                  if(amtController.text.toString().isNotEmpty){
                    setState(() {
                      String amount = amtController.text.toString();
                      openCheckout(amount);
                    });
                  }
                },
                child: const Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Text("Make Payment"),
                ),
              ),

            ],
          ),
        )
    );
  }
}
