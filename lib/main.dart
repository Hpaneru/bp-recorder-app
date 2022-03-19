import 'package:bp_record/helpers/colors.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:bp_record/screens/home_screen.dart';
import 'package:bp_record/models/blood_pressure_data.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  // final dir = await p.getApplicationDocumentsDirectory();
  // Hive.init(dir.path);

  await Hive.initFlutter();
  Hive.registerAdapter(BloodPressureAdapter());
  await Hive.openBox<BloodPressure>('blood_pressure_data');
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.purple,
        primaryColor: AppColors.primaryColor,
        // primarySwatch: AppColors.primaryColor,
        scaffoldBackgroundColor: AppColors.scaffoldBackgroundColor,
      ),
      home: const HomeScreen(),
    );
  }
}
