//import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:wishwell/shared_preferences.dart';
import 'form_validator.dart';

class ClientAdd extends StatefulWidget {
  const ClientAdd({super.key});

  @override
  State<ClientAdd> createState() => _ClientAddState();
}

class _ClientAddState extends State<ClientAdd> {
  final Map _clientObject = <String, String>{};

  final String firstName = 'firstName';
  final String lastName = 'lastName';
  final String gender = 'Gender';
  final String address = 'Address1';
  final String address1 = 'Address2';
  final String city = 'City';
  final String country = 'Country';
  final String dob = 'Date of Birth';
  Widget saveNameBtn() => OutlinedButton(
        onPressed: () {
          _clientObject['firstName'] =
              _firstNameController.text.toString().trim();
          _clientObject['lastName'] =
              _lastNameController.text.toString().trim();
          _clientObject['clientId'] = "1";
          _clientObject['address1'] = _address1.text.toString().trim();
          _clientObject['address2'] = _address2.text.toString().trim();
          _clientObject['city'] = _city.text.toString().trim();
          _clientObject['postcode'] = "";
          _clientObject['country'] = _country.text.toString().trim();
          storedata();

          _createClient();
        },
        child: const Text('Create client'),
      );

  void _createClient() {
    //debugPrint("client===> $_clientObject");

    if (validateForm()) {
      final dataStore = ({"clients": _clientObject});
      debugPrint(dataStore.toString());
      AllData.saveClientData(dataStore);
      //debugPrint(dataStore.toString());

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Processing Data')),
      );
    }

    // if (_formKey.currentState == null) {
    //   debugPrint('_formKey.currentState == null');
    // } else if (_formKey.currentState!.validate()) {
    //   _formKey.currentState!.save();

    //   final dataStore = ({"clients": _clientObject});
    //   AllData.saveJsonData(dataStore);
    //   debugPrint(dataStore.toString());

    //   ScaffoldMessenger.of(context).showSnackBar(
    //     const SnackBar(content: Text('Processing Data')),
    //   );
    // } else {
    //   ScaffoldMessenger.of(context).showSnackBar(
    //     const SnackBar(
    //         content: Text('There are some fields that did not validate')),
    //   );
    // }
  }

  late SharedPreferences sharedPreferences;

  @override
  initState() {
    // initialGetSavedData();
    _firstNameController = TextEditingController();
    _lastNameController = TextEditingController();
    _gender = TextEditingController();
    _address1 = TextEditingController();
    _address2 = TextEditingController();
    _city = TextEditingController();
    _country = TextEditingController();
    _dob = TextEditingController();
    super.initState();
    //clientsFuture = getClients();
  }

  // void storedata() {
  //   Client client = Client(
  //       firstName: _firstNameController.text.toString(),
  //       lastName: _lastNameController.text.toString(),
  //       clientId: "",
  //       postcode: "",
  //       // gender: _gender.text.toString(),
  //       // dob: _dob.text.toString(),
  //       address1: _address1.text.toString(),
  //       address2: _address2.text.toString(),
  //       city: _city.text.toString(),
  //       country: _country.text.toString());

  //   String userdata = jsonEncode(client);
  //   debugPrint("client data====> $userdata");

  //   sharedPreferences.setString(('Userdata'), userdata);
  // }

  final FormValidator formValidator = FormValidator();

  // ignore: unused_field
  final _formKey = GlobalKey<FormBuilderState>();
  late TextEditingController _firstNameController;
  late TextEditingController _lastNameController;

  // ignore: unused_field
  late TextEditingController _gender;
  late TextEditingController _address1;
  late TextEditingController _address2;
  late TextEditingController _city;
  late TextEditingController _country;
  late TextEditingController _dob;
  String? _dropDownValue;
  // late Future<List<Client>> clientsFuture; //NEW

  final Future<SharedPreferences> _prefs = SharedPreferences.getInstance();

  Future<void> storedata() async {
    final SharedPreferences prefs = await _prefs;
    prefs.setString('firstname', _firstNameController.text.toString().trim());
    prefs.setString('lastname', _lastNameController.text.toString().trim());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      //appBar: AppBar(title: const Text("Add Client")),
      body: SizedBox(
        height: MediaQuery.of(context).size.height,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: SingleChildScrollView(
            child: Column(
              children: [
                const SizedBox(
                  height: 80,
                ),
                const Text("Why not,",
                    style: TextStyle(
                      fontSize: 40,
                      fontWeight: FontWeight.w300,
                    )),
                const Text(
                  "add a client.",
                  style: TextStyle(
                    fontSize: 40,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(
                  height: 50,
                ),
                //=========frist name textFeild========//
                TextFormField(
                  controller: _firstNameController,
                  decoration: const InputDecoration(labelText: 'First Name'),
                  validator: (value) {
                    if (value == null && value!.isEmpty) {
                      ///--- toast
                    }
                    return null;
                  },
                  onSaved: (val) => _clientObject['firstName'] = val ?? '',
                ),
                //=========last name textFeild========//
                const SizedBox(height: 10),
                TextFormField(
                  controller: _lastNameController,
                  decoration: const InputDecoration(labelText: 'Last Name'),
                  validator: (value) {
                    if (value == null && value!.isEmpty) {
                      ///--- toast
                    }
                    return null;
                  },
                  onSaved: (val) => _clientObject['lastName'] = val ?? '',
                ),
                //===============Gender =========//
                const SizedBox(height: 10),
                DropdownButton(
                    hint: _dropDownValue == null
                        ? const Text('Gender')
                        : Text(
                            _dropDownValue!,
                            style: const TextStyle(color: Colors.black38),
                          ),
                    isExpanded: true,
                    iconSize: 30.0,
                    style: const TextStyle(color: Colors.black38),
                    items: [
                      'Male',
                      'Female',
                    ].map(
                      (val) {
                        return DropdownMenuItem<String>(
                          value: val,
                          child: Text(val),
                        );
                      },
                    ).toList(),
                    onChanged: (val) {
                      setState(
                        () {
                          _dropDownValue = val;
                        },
                      );
                    }),

                Divider(
                  height: 1,
                  color: Colors.grey.shade700,

                  //  thickness: 10,
                ),
                //=========Address  textFeild========//
                const SizedBox(height: 10),
                FormBuilderTextField(
                  controller: _address1,
                  name: address,
                  decoration: const InputDecoration(labelText: 'Address1'),
                  validator: FormBuilderValidators.required(),
                  onSaved: (val) => _clientObject['lastName'] = val ?? '',
                ),
                //=========Address1  textFeild========//
                const SizedBox(height: 10),
                FormBuilderTextField(
                  controller: _address2,
                  name: address1,
                  decoration: const InputDecoration(labelText: 'Address2'),
                  validator: FormBuilderValidators.required(),
                  onSaved: (val) => _clientObject['lastName'] = val ?? '',
                ),
                //=========Address2  textFeild========//
                const SizedBox(height: 10),
                FormBuilderTextField(
                  controller: _city,
                  name: city,
                  decoration: const InputDecoration(labelText: 'City'),
                  validator: FormBuilderValidators.required(),
                  onSaved: (val) => _clientObject['lastName'] = val ?? '',
                ),
                //============city==========//
                const SizedBox(height: 10),
                FormBuilderTextField(
                  controller: _country,
                  name: country,
                  decoration: const InputDecoration(labelText: 'Country'),
                  validator: FormBuilderValidators.required(),
                  onSaved: (val) => _clientObject['lastName'] = val ?? '',
                ),
                //============country=============//
                // FormBuilderTextField(
                //   controller: _dob,
                //   name: dob,
                //   decoration: const InputDecoration(labelText: 'Date of Birth'),
                //   validator: FormBuilderValidators.required(),
                //   onSaved: (val) => _clientObject['lastName'] = val ?? '',
                // ),

                //============Date of birth=============//
                const SizedBox(height: 10),
                FormBuilderTextField(
                  controller: _dob,
                  name: lastName,
                  decoration: const InputDecoration(labelText: 'Date of Birth'),
                  validator: FormBuilderValidators.required(),
                  onSaved: (val) => _clientObject['lastName'] = val ?? '',
                  onTap: () async {
                    DateTime? pickedDate = await showDatePicker(
                        context: context,
                        initialDate: DateTime.now(),
                        firstDate: DateTime(1950),
                        lastDate: DateTime(2100));

                    if (pickedDate != null) {
                      debugPrint(pickedDate as String?);
                      String formattedDate =
                          DateFormat('yyyy-MM-dd').format(pickedDate);
                      debugPrint(
                          formattedDate); //formatted date output using intl package =>  2021-03-16
                      setState(() {
                        _dob.text =
                            formattedDate; //set output date to TextField value.
                      });
                    } else {}
                  },
                ),
                const SizedBox(
                  height: 50,
                ),
                saveNameBtn(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  bool validateForm() {
    if (_firstNameController.text.toString().isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Enter Name')),
      );
      return false;
    }

    // if (_lastNameController.text.toString().isEmpty) {
    //   ScaffoldMessenger.of(context).showSnackBar(
    //     const SnackBar(content: Text('Enter last name')),
    //   );
    //   return false;
    // }

    // if (gender == "Gender") {
    //   ScaffoldMessenger.of(context).showSnackBar(
    //     SnackBar(content: Text('Select $gender')),
    //   );
    //   return false;
    // }
    ///
//////
    ///
    ///
    // if (_address1.text.toString().isEmpty) {
    //   ScaffoldMessenger.of(context).showSnackBar(
    //     const SnackBar(content: Text('Enter address1')),
    //   );
    //   return false;
    // }

    // if (_address2.text.toString().isEmpty) {
    //   ScaffoldMessenger.of(context).showSnackBar(
    //     const SnackBar(content: Text('Enter address2')),
    //   );
    //   return false;
    // }

    // if (_city.text.toString().isEmpty) {
    //   ScaffoldMessenger.of(context).showSnackBar(
    //     const SnackBar(content: Text('Enter City')),
    //   );
    //   return false;
    // }

    // if (_country.text.toString().isEmpty) {
    //   ScaffoldMessenger.of(context).showSnackBar(
    //     const SnackBar(content: Text('Enter Country')),
    //   );
    //   return false;
    // }

    // if (_dob.text.toString().isEmpty) {
    //   ScaffoldMessenger.of(context).showSnackBar(
    //     const SnackBar(content: Text('Enter DOB')),
    //   );
    //   return false;
    // }

    return true;
  }
}

// initialGetSavedData() async {
//   var sharedPreferences = await SharedPreferences.getInstance();
//   Map<String, dynamic> Jsondetails =
//       jsonDecode(sharedPreferences.getString('Userdata')!);

//   Client client = Client.fromJson(Jsondetails);
// }
