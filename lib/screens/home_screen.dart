import 'package:intl/intl.dart';

import '../boxes.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:bp_record/widgets/action_dialog.dart';
import 'package:bp_record/widgets/custom_container.dart';
import 'package:bp_record/screens/add_record_screen.dart';
import 'package:bp_record/models/blood_pressure_data.dart';
import 'package:bp_record/widgets/custom_key_value_card.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void dispose() {
    Hive.close();
    super.dispose();
  }

  void showLongPressDialog(BuildContext context, BloodPressure bloodPressure) {
    actionDialog(
      context: context,
      actions: <ActionItem>[
        ActionItem(
          icon: Icons.edit,
          title: "Edit",
          onPressed: () {
            Navigator.pop(context);
            Navigator.push(context, MaterialPageRoute(builder: (context) {
              return AddRecordScreen(
                bloodPressure: bloodPressure,
              );
            }));
          },
        ),
        ActionItem(
          icon: Icons.delete,
          title: "Delete",
          onPressed: () {
            Navigator.pop(context);
            bloodPressure.delete();
          },
        ),
      ],
    );
  }

  Widget buildContent(List<BloodPressure> bloodPressureData) {
    if (bloodPressureData.isEmpty) {
      return const Center(
        child: Text(
          'No record found',
          style: TextStyle(fontSize: 24),
        ),
      );
    } else {
      return Column(
        children: <Widget>[
          Expanded(
            child: ListView.builder(
              physics: const BouncingScrollPhysics(),
              padding: const EdgeInsets.all(8),
              itemCount: bloodPressureData.length,
              itemBuilder: (BuildContext context, int index) {
                return BloodPressureRecordCard(
                  bloodPressure: bloodPressureData[index],
                  onLongPress: () {
                    showLongPressDialog(context, bloodPressureData[index]);
                  },
                );
              },
            ),
          ),
        ],
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Home'),
      ),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.add),
        onPressed: () {
          Navigator.push(context, MaterialPageRoute(builder: (context) {
            return const AddRecordScreen();
          }));
        },
      ),
      body: ValueListenableBuilder<Box<BloodPressure>>(
        valueListenable: Boxes.getBloodPressureRecords().listenable(),
        builder: (context, box, _) {
          final records = box.values.toList().cast<BloodPressure>();
          return buildContent(records);
        },
      ),
    );
  }
}

class BloodPressureRecordCard extends StatelessWidget {
  final BloodPressure bloodPressure;
  final VoidCallback onLongPress;
  const BloodPressureRecordCard(
      {Key? key, required this.bloodPressure, required this.onLongPress})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CustomContainer(
      onLongPress: onLongPress,
      child: Column(
        children: <Widget>[
          CustomKeyValueCard(
              keyValue: "Recorded Date:",
              value: DateFormat("dd/MM/yyyy").format(
                  DateTime.fromMillisecondsSinceEpoch(
                      bloodPressure.recordedDate))),
          CustomKeyValueCard(
              keyValue: "Right Hand Record:",
              value: "${bloodPressure.rightHand} mmHg"),
          CustomKeyValueCard(
              keyValue: "Left Hand Record:",
              value: "${bloodPressure.leftHand} mmHg"),
        ],
      ),
    );
  }
}
