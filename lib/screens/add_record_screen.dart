import '../boxes.dart';
import 'package:intl/intl.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:bp_record/widgets/custom_text_field.dart';
import 'package:bp_record/models/blood_pressure_data.dart';
import 'package:bp_record/widgets/custom_date_picker.dart';

class AddRecordScreen extends StatefulWidget {
  final BloodPressure? bloodPressure;
  const AddRecordScreen({
    Key? key,
    this.bloodPressure,
  }) : super(key: key);

  @override
  State<AddRecordScreen> createState() => _AddRecordScreenState();
}

class _AddRecordScreenState extends State<AddRecordScreen> {
  late BloodPressure bloodPressure;
  final dateController = TextEditingController();

  @override
  void initState() {
    bloodPressure = widget.bloodPressure ?? BloodPressure();
    super.initState();
  }

  onAddingAndEditingRecord() {
    if (widget.bloodPressure == null) {
      bloodPressure.id = DateTime.now().millisecondsSinceEpoch;
      final box = Boxes.getBloodPressureRecords();
      box.add(bloodPressure);
      Navigator.of(context).pop();
    } else {
      bloodPressure.save();
      Navigator.of(context).pop();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Add Record"),
      ),
      body: ListView(
        children: <Widget>[
          CustomTextField(
            label: "Select Date",
            controller: dateController,
            readOnly: true,
            onTap: () async {
              DateTime? pickedDate = await selectedDate(context: context);
              if (pickedDate != null) {
                dateController.text =
                    DateFormat('dd/MM/yyyy').format(pickedDate);
                bloodPressure.recordedDate = pickedDate.millisecondsSinceEpoch;
              }
            },
          ),
          CustomTextField(
            keyboardType: TextInputType.number,
            label: "Left Hand Record",
            inputFormatters: <TextInputFormatter>[
              FilteringTextInputFormatter.digitsOnly,
              CustomBloodPressureDataFormatter()
            ],
            onChanged: (String value) {
              bloodPressure.leftHand = value;
            },
          ),
          CustomTextField(
            keyboardType: TextInputType.number,
            label: "Right Hand Record",
            inputFormatters: <TextInputFormatter>[
              FilteringTextInputFormatter.digitsOnly,
              CustomBloodPressureDataFormatter()
            ],
            onChanged: (String value) {
              bloodPressure.rightHand = value;
            },
          ),
          TextButton(
            child: Text("Save"),
            onPressed: onAddingAndEditingRecord,
          ),
        ],
      ),
    );
  }
}
