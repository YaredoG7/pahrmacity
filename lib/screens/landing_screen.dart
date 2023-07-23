import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_iconly/flutter_iconly.dart';
import 'package:splash/screens/auth/login_screen.dart';
import 'package:splash/widgets/banner_widget.dart';
import 'package:splash/widgets/brand_highlight.dart';

class LandingScreen extends StatelessWidget {
  const LandingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey,
      appBar: AppBar(
        backgroundColor: Colors.white30,
        foregroundColor: Colors.white,
        elevation: 0,
        centerTitle: true,
        title: const Text(
          "PharmaCity",
          style: TextStyle(letterSpacing: 2),
        ),
        actions: [
          IconButton(
            icon: const Icon(IconlyLight.logout),
            onPressed: () async {
              await FirebaseAuth.instance.signOut();
              Navigator.pushReplacementNamed(context, LoginScreen.id);
            },
          ),
        ],
      ),
      body: ListView(
        children: const [
          SearchWidget(),
          SizedBox(
            height: 10,
          ),
          BannerWidget(),
          BrandHighlightWidget()
        ],
      ),
    );
  }
}

class SearchWidget extends StatelessWidget {
  const SearchWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          height: 55,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(4),
              child: const TextField(
                decoration: InputDecoration(
                  filled: true,
                  fillColor: Colors.white,
                  border: InputBorder.none,
                  contentPadding: EdgeInsets.fromLTRB(8, 0, 8, 5),
                  hintText: "Search medicine",
                  hintStyle: TextStyle(color: Colors.grey),
                  prefixIcon: Icon(
                    Icons.search,
                    color: Colors.grey,
                  ),
                ),
              ),
            ),
          ),
        ),
        SizedBox(
          height: 20,
          width: MediaQuery.of(context).size.width,
          child: const Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Row(
                children: [
                  Icon(
                    IconlyLight.infoSquare,
                    size: 12,
                    color: Colors.white,
                  ),
                  Text(
                    " Delivery in hours",
                    style: TextStyle(color: Colors.white, fontSize: 12),
                  )
                ],
              ),
              Row(
                children: [
                  Icon(
                    IconlyLight.activity,
                    size: 12,
                    color: Colors.white,
                  ),
                  Text(
                    "Every phamacies",
                    style: TextStyle(color: Colors.white, fontSize: 12),
                  )
                ],
              ),
              Row(
                children: [
                  Icon(
                    IconlyLight.notification,
                    size: 12,
                    color: Colors.white,
                  ),
                  Text(
                    " Alerts and Info ",
                    style: TextStyle(color: Colors.white, fontSize: 12),
                  )
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }
}
