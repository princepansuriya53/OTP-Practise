// ignore_for_file: depend_on_referenced_packages
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:fluttertoast/fluttertoast.dart';

class Logineithphone extends StatefulWidget {
  @override
  _LogineithphoneState createState() => _LogineithphoneState();
}

class _LogineithphoneState extends State<Logineithphone> {
  TextEditingController phoneController = TextEditingController(text: "+91");
  TextEditingController otpController = TextEditingController();
  FirebaseAuth auth = FirebaseAuth.instance;

  bool otpVisibility = false;
  String verificationID = "";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Enter Number'),
      ),
      body: Center(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(10),
              child: TextField(
                controller: phoneController,
                decoration: InputDecoration(
                  labelText: "Enter mobile number",
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Visibility(
                child: TextField(
                  controller: otpController,
                  decoration: InputDecoration(
                    labelText: "Enter OTP",
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                ),
                visible: otpVisibility,
              ),
            ),
            ElevatedButton(
              onPressed: () {
                if (otpVisibility) {
                  otpverify();
                } else {
                  loginwithphone();
                }
              },
              child: Text(otpVisibility ? "Verification" : "Login"),
            ),
          ],
        ),
      ),
    );
  }

  void loginwithphone() async {
    auth.verifyPhoneNumber(
        phoneNumber: phoneController.text,
        verificationCompleted: (PhoneAuthCredential credential) async {
          await auth.signInWithCredential(credential).then((value) {
            print("You are logged in successfully");
          });
        },
        verificationFailed: (FirebaseAuthException e) {
          print(e.message);
        },
        codeSent: (String verificationId, int? resendToken) {
          otpVisibility = true;
          verificationID = verificationId;
          setState(() {});
        },
        codeAutoRetrievalTimeout: (String verificationId) {});
  }

  void otpverify() async {
    PhoneAuthCredential credential = PhoneAuthProvider.credential(
        verificationId: verificationID, smsCode: otpController.text);
    await auth.signInWithCredential(credential).then(
      (value) {
        print('login successfully');
        Fluttertoast.showToast(
          msg: 'login successfully',
          backgroundColor: Colors.green,
          textColor: Colors.white,
          fontSize: 20,
          gravity: ToastGravity.CENTER,
          timeInSecForIosWeb: 1,
          toastLength: Toast.LENGTH_SHORT,
        );
      },
    );
  }
}
