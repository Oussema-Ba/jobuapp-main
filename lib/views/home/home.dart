import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:jobuapp/providers/app_provider.dart';
import 'package:jobuapp/views/home/widgets/title_widget.dart';

import '../addservice.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    var style = context.watch<ThemeNotifier>();
    return SizedBox(
      height: size.height,
      width: size.width,
      child: Stack(
        children: [
          Container(
            height: size.height,
            width: size.width,
            color: style.bgColor,
            child: SingleChildScrollView(
              child: Column(
                children: const [
                  // SearchWidget(),
                  TitleWidget(),
                  // EmergencyWidget(),
                  // SendAlertWidget(),
                  // GetHomeWidget(),
                ],
              ),
            ),
          ),
          Positioned(right: 20,bottom: 100,
              child: FloatingActionButton(
            onPressed: (){Navigator.push(context,
                MaterialPageRoute(builder: (context)=>const Addservice()));
            },
                 child: const Icon(Icons.add),
          ))
        ],
      ),
    );
  }
}
