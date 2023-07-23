import 'package:dots_indicator/dots_indicator.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get_storage/get_storage.dart';
import 'package:splash/screens/auth/login_screen.dart';

class OnBoardingScreen extends StatefulWidget {
  const OnBoardingScreen({super.key});
  static const String id = "onboarding-screen";

  @override
  State<OnBoardingScreen> createState() => _OnBoardingScreenState();
}

class _OnBoardingScreenState extends State<OnBoardingScreen> {
  double scrollerPosition = 0;
  final store = GetStorage();

  onButtonPressed(context) {
    store.write('onBoarding', true);
    // by defualt when app starts it will be local
    store.write('remote', false);
    return Navigator.pushReplacementNamed(context, LoginScreen.id);
  }

  @override
  Widget build(BuildContext context) {
    // prevent landscape mode
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);

    return Scaffold(
        backgroundColor: Colors.yellow.shade700,
        body: Stack(
          children: [
            PageView(
              onPageChanged: (value) {
                setState(() {
                  scrollerPosition = value.toDouble();
                });
              },
              children: [
                OnBoardPage(
                  textColumn: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const Text(
                        "Welcome \nTo Pharma-City",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                            fontSize: 32),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      const Text(
                        "Your Medicines \n delivered to your home ",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Colors.green,
                            fontSize: 28),
                      ),
                      const SizedBox(height: 20),
                      SizedBox(
                        height: 300,
                        width: 300,
                        child: Image.asset("assets/images/10.png"),
                      )
                    ],
                  ),
                ),
                OnBoardPage(
                  textColumn: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const Text(
                        "Browse pharmacies",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                            fontSize: 32),
                      ),
                      const Text(
                        "in your city ",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Colors.green,
                            fontSize: 28),
                      ),
                      const SizedBox(height: 20),
                      SizedBox(
                        height: 300,
                        width: 300,
                        child: Image.asset("assets/images/11.png"),
                      )
                    ],
                  ),
                ),
                OnBoardPage(
                  textColumn: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const Text(
                        "Search for any medicine",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                            fontSize: 32),
                      ),
                      const Text(
                        "or scan your prescription ",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Colors.green,
                            fontSize: 28),
                      ),
                      const SizedBox(height: 20),
                      SizedBox(
                        height: 300,
                        width: 300,
                        child: Image.asset("assets/images/12.png"),
                      )
                    ],
                  ),
                ),
                OnBoardPage(
                  textColumn: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const Text(
                        "We deliver it",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                            fontSize: 32),
                      ),
                      const Text(
                        "to your home ",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Colors.green,
                            fontSize: 28),
                      ),
                      const SizedBox(height: 20),
                      SizedBox(
                        height: 300,
                        width: 300,
                        child: Image.asset("assets/images/13.png"),
                      )
                    ],
                  ),
                ),
              ],
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  DotsIndicator(
                    dotsCount: 4,
                    position: scrollerPosition,
                    decorator: const DotsDecorator(
                      activeColor: Colors.white,
                    ),
                  ),
                  scrollerPosition == 3
                      ? Padding(
                          padding: const EdgeInsets.only(left: 20, right: 20),
                          child: ElevatedButton(
                            style: ButtonStyle(
                                backgroundColor:
                                    MaterialStateProperty.all(Colors.blue)),
                            onPressed: () {
                              onButtonPressed(context);
                            },
                            child: const Text(
                              "Start Using",
                              style: TextStyle(
                                fontSize: 20,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        )
                      : TextButton(
                          onPressed: () {
                            onButtonPressed(context);
                          },
                          child: const Text(
                            "Skip to the APP",
                            style: TextStyle(
                              fontSize: 20,
                              color: Colors.white,
                            ),
                          ),
                        ),
                  const SizedBox(
                    height: 40,
                  )
                ],
              ),
            )
          ],
        ));
  }
}

class OnBoardPage extends StatelessWidget {
  final Column? textColumn;
  OnBoardPage({Key? key, this.textColumn});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          child: Center(
            child: textColumn,
          ),
        ),
        Align(
          alignment: Alignment.bottomCenter,
          child: Container(
            width: MediaQuery.of(context).size.width,
            height: 120,
            decoration: const BoxDecoration(
                color: Color.fromARGB(255, 236, 177, 1),
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(100),
                    topRight: Radius.circular(100))),
          ),
        )
      ],
    );
  }
}
