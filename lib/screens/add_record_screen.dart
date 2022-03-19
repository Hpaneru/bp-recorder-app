import '../boxes.dart';
import 'package:intl/intl.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:bp_record/mixins/loading_mixin.dart';
import 'package:bp_record/widgets/custom_button.dart';
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

class _AddRecordScreenState extends State<AddRecordScreen> with LoadinMixin {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  AutovalidateMode autoValidate = AutovalidateMode.disabled;

  final dateController = TextEditingController();
  late BloodPressure bloodPressure;
  String get getTitle =>
      widget.bloodPressure == null ? "Add New Record" : "Update Record";

  @override
  void initState() {
    if (widget.bloodPressure == null) {
      bloodPressure = BloodPressure()
        ..leftHand = ""
        ..rightHand = "";
    } else {
      bloodPressure = widget.bloodPressure!;
      dateController.text = DateFormat('dd/MMM/yyyy').format(
          DateTime.fromMillisecondsSinceEpoch(bloodPressure.recordedDate));
    }

    setState(() {});
    super.initState();
  }

  onAddingAndEditingRecord() {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();
      setLoading(true);
      if (widget.bloodPressure == null) {
        bloodPressure.id = DateTime.now().millisecondsSinceEpoch;
        final box = Boxes.getBloodPressureRecords();
        box.add(bloodPressure);
      } else {
        bloodPressure.save();
      }
      Navigator.of(context).pop();
    } else {
      setState(() {
        autoValidate = AutovalidateMode.always;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(getTitle),
      ),
      body: ListView(
        physics: const BouncingScrollPhysics(),
        children: <Widget>[
          Form(
            key: _formKey,
            child: Column(
              children: <Widget>[
                CustomTextField(
                  label: "Select Date",
                  controller: dateController,
                  readOnly: true,
                  autovalidateMode: autoValidate,
                  validator: (String? value) {
                    if (value!.isEmpty) return 'Mandatory Field';
                    return null;
                  },
                  onTap: () async {
                    DateTime? pickedDate = await selectedDate(context: context);
                    if (pickedDate != null) {
                      dateController.text =
                          DateFormat('dd/MMM/yyyy').format(pickedDate);
                      bloodPressure.recordedDate =
                          pickedDate.millisecondsSinceEpoch;
                    }
                  },
                ),
                CustomTextField(
                  initialValue: bloodPressure.leftHand,
                  autovalidateMode: autoValidate,
                  keyboardType: TextInputType.number,
                  label: "Left Hand Record",
                  suffixText: "mmHg",
                  inputFormatters: <TextInputFormatter>[
                    FilteringTextInputFormatter.digitsOnly,
                    CustomBloodPressureDataFormatter()
                  ],
                  validator: (String? value) {
                    if (value!.isEmpty) return 'Mandatory Field';
                    return null;
                  },
                  onChanged: (String value) {
                    bloodPressure.leftHand = value;
                  },
                ),
                CustomTextField(
                  initialValue: bloodPressure.rightHand,
                  keyboardType: TextInputType.number,
                  autovalidateMode: autoValidate,
                  label: "Right Hand Record",
                  suffixText: "mmHg",
                  inputFormatters: <TextInputFormatter>[
                    FilteringTextInputFormatter.digitsOnly,
                    CustomBloodPressureDataFormatter()
                  ],
                  validator: (String? value) {
                    if (value!.isEmpty) return 'Mandatory Field';
                    return null;
                  },
                  onChanged: (String value) {
                    bloodPressure.rightHand = value;
                  },
                ),
              ],
            ),
          ),
          CustomButton(
            label: getTitle,
            loading: loading,
            onPressed: onAddingAndEditingRecord,
          ),
        ],
      ),
    );
  }
}
