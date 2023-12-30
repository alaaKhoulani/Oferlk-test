import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:test/constants/MyColors.dart';
import 'package:test/providers/MainScreenProvider.dart';
import 'package:test/ui/HomePage.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int selectedValue = 0;
  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
          body: HomePage(),
          bottomNavigationBar: BottomAppBar(
              padding: EdgeInsets.zero,
              elevation: 0,
              color: Colors.white,
              // height: 77,
              child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  // mainAxisSize: MainAxisSize.min,
                  children: [
                    buildItem("الرئيسية", Icons.home_outlined, 0),
                    SizedBox(
                      width: 40,
                    ),
                    buildItem("مراكز بيع البطاقة", Icons.padding, 1)
                  ]))),
    );
  }

  Widget buildItem(String text, IconData icon, int value) {
    var provTrue = Provider.of<MainScreenPrvider>(context, listen: true);
    return Column(
      children: [
        Stack(alignment: AlignmentDirectional.center, children: [
          Container(
            alignment: Alignment.center,
            width: 40,
            height: 40,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(20)),
                color:
                    value == provTrue.selectedScreen ? MyColors.myred2 : null),
          ),
          IconButton(
            icon: Icon(
              icon,
              color: value == provTrue.selectedScreen
                  ? Colors.white
                  : Colors.black,
              size: 20,
            ),
            onPressed: () {
              provTrue.changeScreen(value);
            },
          )
        ]),
        SizedBox(
          height: 8,
        ),
        Text(
          text,
          style: TextStyle(
              fontSize: 9,
              color: provTrue.selectedScreen == value
                  ? MyColors.myred2
                  : Colors.black),
        )
      ],
    );
  }
}
