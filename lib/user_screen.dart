
import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:wishwell/components/text_field.dart';
import 'package:wishwell/form_validator.dart';
import 'package:wishwell/shared_preferences.dart';
import 'package:wishwell/user_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

class DetailsScreen extends StatefulWidget {
  const DetailsScreen({Key? key}) : super(key: key);

  @override
  State<DetailsScreen> createState() => DetailsScreenState();
}

class DetailsScreenState extends State<DetailsScreen> {
  // ignore: unused_field
  final FormValidator formValidator = FormValidator();
  final GlobalKey<FormState> key = GlobalKey<FormState>();

  //late bool _validate = false;
  clearSharedPrefs() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.clear();
  }
  // Or try await prefs.remove('object name');

  late TextEditingController _firstNameController;
  late TextEditingController _lastNameController;

  FocusNode focusNode = FocusNode();

  @override
  void initState() {
    _firstNameController = TextEditingController();
    _lastNameController = TextEditingController();

    super.initState();

    focusNode.addListener(() {
      //debugPrint('1:  ${focusNode.hasFocus}');
    });
    // LOAD DATA TO FORM ON PAGE LOAD
    AllData.getStartingData().then((val) {
      String jsonDataString = val.toString();
      final decodedJson = jsonDecode(jsonDataString);

      if (decodedJson['deets'] == null) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('There is no User Details data')),
        );
      } else {
        var userDetails = decodedJson['deets']; //get nested deets

        var list = [];
        userDetails.forEach((key, value) => list.add('"$key":"$value"'));
        var array = list.join(',');
        var d = '{$array}';
        var sData = UserModel.fromMap(jsonDecode(d.toString()));
        //debugPrint(sData.toString());
        _firstNameController.text = sData.firstName.toString();
        _lastNameController.text = sData.lastName.toString();
      }
      //debugPrint(userDetails.toString());
    });

    _firstNameController.addListener(() async {
      //debugPrint('1:  ${focusNode.hasFocus}');
    });
    _lastNameController.addListener(() async {
      //debugPrint('2s:  ${focusNode.hasFocus}');
    });
  }

  Widget saveNameBtn() => OutlinedButton(
        //onPressed: () async {
        //  final dataStore = <String, dynamic>{
        //    'firstName': _firstNameController.text,
        //    'lastName': _lastNameController.text,
        //  };
        //  await AllData.saveJsonData(dataStore);
        //  //AllData.getJsonData();
        //},
        onPressed: () {
          _createUser();
        },
        child: const Text('Save data'),
      );
  Widget clearDataBtn() => OutlinedButton(
        onPressed: clearSharedPrefs,
        child: const Text('Add some default data'),
      );

  @override
  void dispose() {
    _firstNameController.dispose();
    _lastNameController.dispose();
    super.dispose();
  }

  final _userObject = <String, String>{};
  final FocusNode _firstNameFocusNode = FocusNode();

  @override
  Widget build(BuildContext context) {
    return Form(
        //appBar: AppBar(
        //  title: const Text('My Details'),
        //),
        autovalidateMode: AutovalidateMode.onUserInteraction,
        key: key,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              const SizedBox(
                height: 80,
              ),
              const Text("To start, lets learn",
                  style: TextStyle(
                    fontSize: 40,
                    fontWeight: FontWeight.w300,
                  )),
              const Text(
                "about you.",
                style: TextStyle(
                  fontSize: 40,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(
                height: 50,
              ),
              TF(
                onSaved: (val) => _userObject['firstName'] = val ?? '',
                controller: _firstNameController,
                hintText: 'First Name',
                suffix: GestureDetector(
                    onTap: () {
                      _firstNameController.clear();
                    },
                    child: const Icon(Icons.clear)),
                autoFocus: true,
                focusNode: _firstNameFocusNode,
              ),
              const SizedBox(height: 10),
              TF(
                focusNode: focusNode,
                onSaved: (val) => _userObject['lastName'] = val ?? '',
                controller: _lastNameController,
                hintText: 'Last Name',
                suffix: GestureDetector(
                    onTap: () {
                      _lastNameController.clear();
                    },
                    child: const Icon(Icons.clear)),
              ),
              const SizedBox(
                height: 50,
              ),
              saveNameBtn(),
              clearDataBtn(),
            ],
          ),
        ));
  }

  //VALIDATION

  // ignore: unused_element

  void _createUser() {
    // After the first attempt to save, turn on autovalidate to give quicker feedback to the user
    //setState(() => _autovalidate = true); // <-- Add this line

    if (key.currentState == null) {
      debugPrint('key.currentState == null');
    } else if (key.currentState!.validate()) {
      // Commit the field values to their variables
      key.currentState!.save();

      // SAVE FORM ENTRIES TO DEVICE USER PREFERENCES
      final dataStore = ({"deets": _userObject});
      AllData.saveUserData(dataStore);
      //debugPrint('Details screen create user saved as below');
      //debugPrint(dataStore.toString());

      //debugPrint("""
      //The user has registered with an first name of '${_userObject['firstName']}'
      //and a last name of '${_userObject['lastName']}'
      // """);

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Processing Data')),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
            content: Text('There are some fields that did not validate')),
      );
    }
  }
}
