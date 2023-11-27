import 'package:flutter/material.dart';
import 'package:smart_wallet/presentation/pages/home_page/home_page_screen.dart';
import 'package:smart_wallet/presentation/pages/transacoes_page/transacoes_screen.dart';

class CustomBottomNavigation extends StatelessWidget {
  final int index;
  const CustomBottomNavigation({required this.index,super.key});

  @override
  Widget build(BuildContext context) {
    return Theme(
      data: Theme.of(context).copyWith(
        canvasColor: const Color(0xFF121e3c),
        primaryColor: const Color(0xFF121e3c),
        splashColor: const Color(0xff10172c),
      ),
      child: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        selectedItemColor: Colors.white,
        unselectedItemColor: Colors.grey.shade700,
        onTap: (i) {
          switch(i){
            case 0:
              //Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>const ThanksScreen()));
              break;
            case 1:
              Navigator.push(context, MaterialPageRoute(builder: (context)=> TransacoesScreen()));
              break;
            case 2:
              Navigator.push(context, MaterialPageRoute(builder: (context)=> HomePage()));
              break;
            case 3:
            //Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>const ThanksScreen()));
              break;
            case 4:
            //Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>const ThanksScreen()));
              break;
            default:
              Navigator.push(context, MaterialPageRoute(builder: (context)=> HomePage()));
              break;
          }
        },
        currentIndex: index,
        items: const [
          BottomNavigationBarItem(
              icon: Icon(Icons.folder, size: 40), label: ""),
          BottomNavigationBarItem(
              icon: Icon(Icons.compare_arrows, size: 40), label: ""),
          BottomNavigationBarItem(
              icon: Icon(Icons.monetization_on, size: 40), label: ""),
          BottomNavigationBarItem(
              icon: Icon(Icons.bar_chart, size: 40), label: ""),
          BottomNavigationBarItem(
              icon: Icon(Icons.settings, size: 40), label: "")
        ],
      ),
    );
  }
}
