import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:flutternetflix/repositories/data_repository.dart';
import 'package:flutternetflix/ui/screens/home_screen.dart';
import 'package:flutternetflix/utils/constant.dart';
import 'package:provider/provider.dart';

class LoadingScreen extends StatefulWidget {
  const LoadingScreen({Key? key}) : super(key: key);

  @override
  State<LoadingScreen> createState() => _LoadingScreenState();
}

class _LoadingScreenState extends State<LoadingScreen> {
  @override
  void initState() {
    super.initState();
    initData();
  }

  void initData() async {
    // Initialyse data
    final dataProvider = Provider.of<DataRepository>(context, listen: false);
    await dataProvider.initData();

    // Present HomeScreen
    Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) {
      return const HomeScreen();
    }));
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: kBackgroundColor,
      child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
        Image.asset('assets/images/netflix_logo_1.png'),
        SpinKitFadingCircle(
          color: kPrimaryColor,
          size: 30,
        )
      ]),
    );
  }
}
