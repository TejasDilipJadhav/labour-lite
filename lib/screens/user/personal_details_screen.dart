import 'package:flutter/material.dart';
import 'package:labour_lite/classes/personal_details.dart';

class PersonalDetailsScreen extends StatefulWidget {
  static const String id = 'user_details';

  const PersonalDetailsScreen({super.key});

  @override
  State<PersonalDetailsScreen> createState() => _PersonalDetailsScreenState();
}

class _PersonalDetailsScreenState extends State<PersonalDetailsScreen> {
  late PersonalDetails personalDetails;
  @override
  void initState() {
    super.initState();
    personalDetails = PersonalDetails();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: Key(personalDetails.dateOfBirth.toString() +
          personalDetails.dateOfJoining.toIso8601String()),
      backgroundColor: Colors.blue,
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const Padding(
              padding: EdgeInsets.all(20.0),
              child: Icon(
                Icons.assignment_ind,
                size: 120,
                color: Colors.white,
              ),
            ),
            Expanded(
              child: Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 25, vertical: 10),
                  height: 300,
                  decoration: const BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(20),
                      topRight: Radius.circular(20),
                    ),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: SingleChildScrollView(
                      scrollDirection: Axis.vertical,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          myTextFormField(
                              labelText: "Full Name",
                              onChanged: (value) {
                                personalDetails.fullName = value;
                              },
                              initialValue: personalDetails.fullName,
                              textInputType: TextInputType.name),
                          const SizedBox(
                            height: 20,
                          ),
                          myTextFormField(
                              labelText: "Aadhar Number",
                              onChanged: (value) {
                                personalDetails.aadharCardNumber = value;
                              },
                              initialValue: personalDetails.aadharCardNumber,
                              textInputType: TextInputType.number),
                          const SizedBox(
                            height: 20,
                          ),
                          myTextFormField(
                              labelText: "Pan Number",
                              onChanged: (value) {
                                personalDetails.panCardNumber = value;
                              },
                              initialValue: personalDetails.panCardNumber,
                              textInputType: TextInputType.number),
                          const SizedBox(
                            height: 20,
                          ),
                          myTextFormField(
                              labelText: "ESIC Number",
                              onChanged: (value) {
                                personalDetails.esicNumber = value;
                              },
                              initialValue: personalDetails.panCardNumber,
                              textInputType: TextInputType.number),
                          const SizedBox(
                            height: 20,
                          ),
                          myTextFormDateField(
                              labelText: "Date of Birth",
                              onChanged: (value) {
                                personalDetails.dateOfBirth = value;
                                setState(() {});
                              },
                              initialValue: personalDetails.dateOfBirth,
                              context: context),
                          const SizedBox(
                            height: 20,
                          ),
                          myTextFormDateField(
                              labelText: "Date of Joining",
                              onChanged: (value) {
                                personalDetails.dateOfJoining = value;
                                setState(() {});
                              },
                              initialValue: personalDetails.dateOfJoining,
                              context: context),
                          const SizedBox(
                            height: 20,
                          ),
                          myTextFormField(
                              labelText: "Phone Number",
                              onChanged: (value) {
                                personalDetails.phoneNumber = value;
                              },
                              initialValue: personalDetails.phoneNumber,
                              textInputType: TextInputType.number),
                          const SizedBox(
                            height: 20,
                          ),
                          ElevatedButton(
                            child: const Padding(
                              padding: EdgeInsets.all(8.0),
                              child: Icon(
                                Icons.save,
                                size: 40,
                              ),
                            ),
                            onPressed: () {},
                          )
                        ],
                      ),
                    ),
                  )),
            ),
          ],
        ),
      ),
    );
  }
}

TextFormField myTextFormField(
    {required String labelText,
    required Function onChanged,
    required String initialValue,
    required TextInputType textInputType}) {
  return TextFormField(
    keyboardType: textInputType,
    initialValue: initialValue,
    decoration: InputDecoration(
      labelText: labelText,
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(10),
      ),
    ),
    onChanged: (value) {
      onChanged(value);
    },
  );
}

TextFormField myTextFormDateField(
    {required String labelText,
    required Function onChanged,
    required DateTime initialValue,
    required BuildContext context}) {
  return TextFormField(
    readOnly: true,
    initialValue: initialValue.toString().substring(0, 10),
    decoration: InputDecoration(
      suffixIcon: IconButton(
        icon: const Icon(Icons.date_range),
        onPressed: () async {
          final DateTime? picked = await showDatePicker(
            context: context,
            initialDate: initialValue,
            firstDate: DateTime(2000),
            lastDate: DateTime(2101),
          );

          if (picked != null && picked != initialValue) {
            onChanged(picked);
          }
        },
      ),
      labelText: labelText,
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(10),
      ),
    ),
    onChanged: (value) {
      onChanged(value);
    },
  );
}
