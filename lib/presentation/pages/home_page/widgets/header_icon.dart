import 'package:flutter/material.dart';

import 'circle_icon.dart';

class HeaderIcon extends StatelessWidget {
  const HeaderIcon({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Color(0xFF121e3c),
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(75.0),
          bottomRight: Radius.circular(75.0),
        ),
      ),
      child: Column(
        children: [
          Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      IconButton(
                          onPressed: () {},
                          icon: Icon(
                            Icons.more_horiz,
                            color: Colors.white,
                          )),
                      IconButton(
                          onPressed: () {},
                          icon: Icon(
                            Icons.notifications,
                            color: Colors.white,
                          )),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Column(
                        children: [
                          Text(
                            "R\$ 1.400,00",
                            style: TextStyle(color: Colors.white, fontSize: 56),
                          ),
                          Text(
                            "Balanço",
                            style: TextStyle(color: Colors.grey, fontSize: 18),
                          ),
                        ],
                      )
                    ],
                  ),
                  Padding(
                    padding: EdgeInsets.only(bottom: 40.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        CircleIcon(color: Colors.white, icon: Icons.add, size: 50, onPressed: (){},),
                        CircleIcon(color: Colors.green, icon: Icons.arrow_upward_outlined, size: 50,onPressed: (){}),
                        CircleIcon(color: Colors.red, icon: Icons.arrow_downward_outlined, size: 50,onPressed: (){})
                      ],
                    ),
                  )
                ],
              )),
          //Expanded(child: child),
          //Expanded(child: child),
        ],
      ),
    );
  }
}