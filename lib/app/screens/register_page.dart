import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:pinput/pinput.dart';
import 'package:velocity_x/velocity_x.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  TextEditingController phoneController = TextEditingController();
  TextEditingController pinController = TextEditingController();
  final focusNode = FocusNode();
  String phoneNumber = "";
  String pinCode = "";
  final formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    phoneController.dispose();
    pinController.dispose();
    focusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: SafeArea(
        child: Scaffold(
          appBar: AppBar(
            flexibleSpace: Container(
              height: AppBar().preferredSize.height,
              color: Colors.white,
              padding: const EdgeInsets.symmetric(horizontal: 24),
              child: HStack([
                Image.asset('assets/images/ic-delete.png', width: 32),
                ' Kembali'.text.size(18).color(const Color(0xFF1F46A1)).make(),
              ]),
            ),
            elevation: 0,
          ),
          backgroundColor: Colors.white,
          body: Stack(
            children: <Widget>[
              Positioned.fill(
                child: Image.asset(
                  "assets/images/img-background-element-2.png",
                  fit: BoxFit.fitWidth,
                  alignment: Alignment.bottomCenter,
                ),
              ),
              Container(
                height: MediaQuery.of(context).size.height,
                child: _showContent(),
              ).scrollVertical()
            ],
          ),
        ),
      ),
    );
  }

  Widget _showContent() {
    return VStack([
      24.heightBox,
      SizedBox(
        child: Image.asset('assets/images/ic-logo-horizontal.png',
            width: MediaQuery.of(context).size.width, height: 34),
      ),
      16.heightBox,
      Container(
        alignment: Alignment.center,
        child:
            'Masuk ke akun Anda untuk dapatkan\nPinjaman yang lebih dan besar'
                .text
                .center
                .color(const Color(0xFF1F46A1))
                .make(),
      ),
      46.heightBox,
      Form(
        key: formKey,
        child: Container(
          alignment: Alignment.center,
          margin: const EdgeInsets.symmetric(horizontal: 48),
          child: Card(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(15.0),
            ),
            elevation: 4.0,
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: VStack([
                'Nomor Telepon Anda'.text.make(),
                8.heightBox,
                _showInputPhone(),
                16.heightBox,
                HStack([
                  'PIN Anda'.text.make(),
                ]),
                8.heightBox,
                _showInputPIN(context),
                16.heightBox,
                _showButtonRegister(),
                _showButtonForgot(),
              ]),
            ),
          ),
        ),
      ),
      const Expanded(child: SizedBox()),
    ]);
  }

  Widget _showInputPhone() {
    return Container(
      width: MediaQuery.of(context).size.width * 0.8,
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 0),
      decoration: BoxDecoration(
        color: const Color(0xFFF0F0F0),
        borderRadius: BorderRadius.circular(8),
      ),
      child: TextFormField(
        keyboardType: TextInputType.number,
        style: const TextStyle(
          color: Color(0xFF1F46A1),
        ),
        decoration: const InputDecoration(
          border: InputBorder.none,
          hintText: 'Nomor Handphone',
        ),
        validator: (value) {
          if ((value ?? '').isEmpty) {
            return 'Please enter your phone number';
          }
          return null;
        },
        onChanged: (value) => {phoneNumber = value},
      ),
    );
  }

  Widget _showInputPIN(BuildContext context) {
    const focusedBorderColor = Color(0xFF1F46A1);
    const fillColor = Color(0xFFF0F0F0);

    final defaultPinTheme = PinTheme(
      width: 56,
      height: 64,
      textStyle: const TextStyle(
        fontSize: 22,
        color: Color(0xFF1F46A1),
      ),
      decoration: BoxDecoration(
        color: fillColor,
        borderRadius: BorderRadius.circular(8),
      ),
    );

    return Directionality(
      // Specify direction if desired
      textDirection: TextDirection.ltr,
      child: Pinput(
        controller: pinController,
        focusNode: focusNode,
        androidSmsAutofillMethod: AndroidSmsAutofillMethod.smsUserConsentApi,
        listenForMultipleSmsOnAndroid: true,
        defaultPinTheme: defaultPinTheme,
        validator: (value) {
          return value == '1234' ? null : 'Pin is incorrect';
        },
        hapticFeedbackType: HapticFeedbackType.lightImpact,
        onCompleted: (pin) {
          debugPrint('onCompleted: $pin');
        },
        onChanged: (value) {
          debugPrint('onChanged: $value');
          pinCode = value;
        },
        cursor: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Container(
              margin: const EdgeInsets.only(bottom: 9),
              width: 22,
              height: 1,
              color: focusedBorderColor,
            ),
          ],
        ),
        focusedPinTheme: defaultPinTheme.copyWith(
          decoration: defaultPinTheme.decoration!.copyWith(
            borderRadius: BorderRadius.circular(8),
            border: Border.all(color: focusedBorderColor),
          ),
        ),
        errorPinTheme: defaultPinTheme.copyBorderWith(
          border: Border.all(color: Colors.redAccent),
        ),
      ),
    );
  }

  Widget _showButtonRegister() {
    var buttonColor = const Color(0xFF1F46A1);
    if (pinCode.isEmpty || phoneNumber.isEmpty) {
      buttonColor = const Color(0xFFE0E0E0);
    }
    return Container(
      alignment: Alignment.center,
      padding: const EdgeInsets.symmetric(horizontal: 8),
      child: SizedBox(
        width: MediaQuery.of(context).size.width * 0.75,
        height: 46,
        child: TextButton(
            style: TextButton.styleFrom(
              backgroundColor: buttonColor,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(23),
              ),
            ),
            onPressed: () {
              if (pinCode.isEmpty || phoneNumber.isEmpty) {
                print('AWESOME');
              } else {
                print('OKE');
              }
            },
            child: "Masuk!".text.white.make()),
      ),
    );
  }

  Widget _showButtonForgot() {
    return Container(
      alignment: Alignment.center,
      padding: const EdgeInsets.symmetric(horizontal: 8),
      child: SizedBox(
        width: MediaQuery.of(context).size.width * 0.75,
        height: 46,
        child: TextButton(
          onPressed: () {},
          child: 'Lupa PIN Saya'.text.color(const Color(0xFF1F46A1)).make(),
        ),
      ),
    );
  }
}
