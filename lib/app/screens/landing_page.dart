import 'package:flutter/material.dart';
import 'package:flutter_mobile/app/screens/register_page.dart';
import 'package:flutter_mobile/app/widgets/custom_slider.dart';
import 'package:velocity_x/velocity_x.dart';
// ignore: depend_on_referenced_packages
import 'package:intl/intl.dart' show DateFormat, NumberFormat;

class LandingPage extends StatefulWidget {
  const LandingPage({super.key});

  @override
  State<LandingPage> createState() => _LandingPageState();
}

class _LandingPageState extends State<LandingPage> {
  double loanAmount = 0;
  double loanPeriod = 1;
  List<String> periodDivisions = ['4.5', '5.5', '6.5', '7.5', '8.5'];

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: SafeArea(
        child: Scaffold(
          appBar: AppBar(
            flexibleSpace: Container(
              color: Colors.white,
              padding: const EdgeInsets.symmetric(horizontal: 24),
              child: HStack([
                Image.asset('assets/images/ic-afpi.png', width: 64),
                const Spacer(),
                Image.asset('assets/images/ic-ojk-2.png', width: 64)
              ]),
            ),
            elevation: 0,
          ),
          backgroundColor: Colors.white,
          body: Stack(
            children: <Widget>[
              Positioned.fill(
                child: Image.asset(
                  "assets/images/img-background-element.png",
                  fit: BoxFit.fitWidth,
                  alignment: Alignment.bottomCenter,
                ),
              ),
              Container(
                child: _showContent(),
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget _showContent() {
    return VStack([
      SizedBox(
        child: Image.asset('assets/images/ic-logo-horizontal.png',
            width: MediaQuery.of(context).size.width, height: 34),
      ),
      46.heightBox,
      Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            'Bayar Hingga'.text.color(const Color(0xFF1F46A1)).make(),
            _showDueDate(loanPeriod)
          ],
        ),
      ),
      32.heightBox,
      Container(
        alignment: Alignment.center,
        child: 'Kamu mengambil pinjaman'
            .text
            .center
            .size(16)
            .color(const Color(0xFF1F46A1))
            .bold
            .make(),
      ),
      CustomSlider(
          value: loanAmount,
          label: _renderLoanLabel(loanAmount),
          divisions: const ['500 rb', '1 jt', '1,5 jt', '2 jt', '2,5 jt'],
          onPress: (value) => {
                setState(() {
                  print(loanAmount);
                  loanAmount = value;
                })
              }),
      16.heightBox,
      CustomSlider(
          value: loanPeriod,
          label: _renderPeriodLabel(loanPeriod),
          divisions: periodDivisions,
          onPress: (value) => {
                setState(() {
                  print(loanPeriod);
                  loanPeriod = value;
                })
              }),
      42.heightBox,
      Container(
        alignment: Alignment.center,
        padding: const EdgeInsets.symmetric(horizontal: 8),
        child: SizedBox(
          width: MediaQuery.of(context).size.width * 0.75,
          height: 46,
          child: TextButton(
              style: TextButton.styleFrom(
                backgroundColor: const Color(0xFF1F46A1),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(23),
                ),
              ),
              onPressed: () {
                var registerRoute = MaterialPageRoute(
                    builder: (BuildContext context) => const RegisterPage());
                Navigator.of(context).push(registerRoute);
              },
              child: "Dapatkan dana sekarang!".text.white.make()),
        ),
      ),
      16.heightBox,
      Container(
        alignment: Alignment.center,
        padding: const EdgeInsets.symmetric(horizontal: 8),
        child: SizedBox(
          width: MediaQuery.of(context).size.width * 0.75,
          height: 46,
          child: TextButton(
            onPressed: () {
              var registerRoute = MaterialPageRoute(
                  builder: (BuildContext context) => const RegisterPage());
              Navigator.of(context).push(registerRoute);
            },
            child: _outlinedText(),
          ),
        ),
      ),
      const Expanded(child: SizedBox()),
    ]);
  }

  Widget _showDueDate(double value) {
    var date = DateTime.now();
    var period = 3 + value.toInt();
    var dueDate =
        DateTime(date.year, date.month + period.toInt(), date.day + 15);
    var dueDateTxt = DateFormat('dd.MM.yyyy').format(dueDate);
    return dueDateTxt.text.color(const Color(0xFF1F46A1)).make();
  }

  String _renderLoanLabel(double value) {
    final format = NumberFormat.simpleCurrency(
        locale: 'in', decimalDigits: 0, name: 'Rp. ');
    const labels = [500000, 1000000, 1500000, 2000000, 2500000];
    var label = labels.last;
    if (value.toInt() < periodDivisions.length) {
      label = labels[value.toInt()];
    }
    return format.format(int.parse(label.toString()));
  }

  String _renderPeriodLabel(double value) {
    var index = value.toInt();
    var period = periodDivisions.last;
    if (value.toInt() < periodDivisions.length) {
      period = periodDivisions[index];
    }
    return 'Untuk $period bulan';
  }

  Stack _outlinedText() {
    return Stack(
      children: <Widget>[
        Text(
          'Sudah menjadi peminjam',
          style: TextStyle(
            fontSize: 16,
            foreground: Paint()
              ..style = PaintingStyle.stroke
              ..strokeWidth = 2
              ..color = Colors.blue,
          ),
        ),
        Text(
          'Sudah menjadi peminjam',
          style: TextStyle(
            fontSize: 16,
            color: Colors.grey[300],
          ),
        ),
      ],
    );
  }
}
