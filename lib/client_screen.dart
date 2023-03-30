import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:wishwell/shared_preferences.dart';
import 'package:wishwell/client_detail.dart';
import 'package:wishwell/client_model.dart';

class ClientScreen extends StatefulWidget {
  const ClientScreen({Key? key}) : super(key: key);

  @override
  State<ClientScreen> createState() => ClientScreenState();
}

class ClientScreenState extends State<ClientScreen> {
  List<Client> clientList = [];
  // final FormValidator formValidator = FormValidator();
  // final _formKey = GlobalKey<FormBuilderState>();
  // late TextEditingController _firstNameController;
  // late TextEditingController _lastNameController;
  // late TextEditingController _gender;
  // late TextEditingController _address1;
  // late TextEditingController _address2;
  // late TextEditingController _city;
  // late TextEditingController _country;
  // late TextEditingController _dob;
  // String? _dropDownValue;
  // late Future<List<Client>> clientsFuture; //NEW

  @override
  void initState() {
    AllData.getStartingData().then((value) async {
      final body = await json.decode(value);
      List<dynamic> clientData = body["clients"];
      debugPrint("clientData==> ${clientData[0]['firstName']}");
      clientList.clear();
      setState(() {
        for (int i = 0; i < clientData.length; i++) {
          clientList.add(Client(
              firstName: clientData[i]['firstName'],
              lastName: clientData[i]['lastName'],
              clientId: clientData[i]['clientId'],
              address1: clientData[i]['address1'],
              address2: clientData[i]['address2'],
              city: clientData[i]['city'],
              postcode: clientData[i]['postcode'],
              country: clientData[i]['country']));
        }
        // clientList = clientData;
      });

      debugPrint("value===> ${clientList.length}");
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) => Scaffold(
        //appBar: AppBar(title: const Text("Client List")),
        body: SizedBox(
          height: MediaQuery.of(context).size.height,
          child: SingleChildScrollView(
            child: Column(
              // ignore: prefer_const_literals_to_create_immutables
              children: [
                buildClients(clientList),
                //  buildForm(context),
                //   FutureBuilder<List<Client>>(
                //     // future: ClientAdd.storedata(),
                //     builder: (context, snapshot) {
                //       final clients = snapshot.data;
                //       //buildForm(context);
                //       switch (snapshot.connectionState) {
                //         case ConnectionState.waiting:
                //           return const Center(child: CircularProgressIndicator());
                //         default:
                //           if (snapshot.hasError) {
                //             return const Center(
                //                 child: Text('Some error occurred'));
                //           } else {
                //             return buildClients(clients!);
                //           }
                //       }
                //     },
                //   ),
              ],
            ),
          ),
        ),
      );

  Widget buildClients(List<Client> clients) => ListView.builder(
        itemCount: clients.length,
        itemBuilder: (context, index) {
          final client = clients[index];
          return Card(
            child: ListTile(
              leading: Text(client.firstName),
              subtitle: Text(client.firstName),
              trailing: const Icon(Icons.arrow_forward_ios),
              isThreeLine: true,
              title: Text(client.lastName),
              onTap: () {
                Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) => ClientPage(client: client),
                ));
              },
            ),
          );
        },
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
      );

  // @override
  // initState() {
  //   _firstNameController = TextEditingController();
  //   _lastNameController = TextEditingController();
  //   _gender = TextEditingController();
  //   _address1 = TextEditingController();
  //   _address2 = TextEditingController();
  //   _city = TextEditingController();
  //   _country = TextEditingController();
  //   _dob = TextEditingController();
  //   super.initState();
  //   //clientsFuture = getClients();
  // }

  // Widget saveNameBtn() => ElevatedButton(
  //       onPressed: () {
  //         _createClient();
  //       },
  //       child: const Text('Create client'),
  //     );

  // @override
  // void dispose() {
  //   _firstNameController.dispose();
  //   _lastNameController.dispose();
  //   _gender.dispose();
  //   _address1.dispose();
  //   _address2.dispose();
  //   _city.dispose();
  //   _country.dispose();
  //   _dob.dispose();
  //   super.dispose();
  // }

  // ignore: unused_field
  final _clientObject = <String, String>{};

  final String firstName = 'firstName';
  final String lastName = 'lastName';
  final String gender = 'Gender';
  final String address = 'Address1';
  final String address1 = 'Address2';
  final String city = 'City';
  final String country = 'Country';
  final String dob = 'Date of Birth';

  // Widget buildForm(BuildContext context) {
  //   return

  // FormBuilder(
  //     autovalidateMode: AutovalidateMode.onUserInteraction,
  //     key: _formKey,
  //     onChanged: () {
  //       _formKey.currentState!.save();
  //     },
  //     child: Padding(
  //       padding: const EdgeInsets.all(8.0),
  //       child: Column(
  //         children: [
  //           const Text('Add Client'),

  //           //=========frist name textFeild========//
  //           FormBuilderTextField(
  //             controller: _firstNameController,
  //             name: firstName,
  //             decoration: const InputDecoration(labelText: 'First Name'),
  //             validator: FormBuilderValidators.required(),
  //             onSaved: (val) => _clientObject['firstName'] = val ?? '',
  //           ),
  //           //=========last name textFeild========//
  //           const SizedBox(height: 10),
  //           FormBuilderTextField(
  //             controller: _lastNameController,
  //             name: lastName,
  //             decoration: const InputDecoration(labelText: 'Last Name'),
  //             validator: FormBuilderValidators.required(),
  //             onSaved: (val) => _clientObject['lastName'] = val ?? '',
  //           ),
  //           //===============Gender =========//
  //           const SizedBox(height: 10),
  //           DropdownButton(
  //               hint: _dropDownValue == null
  //                   ? const Text('Gender')
  //                   : Text(
  //                       _dropDownValue!,
  //                       style: const TextStyle(color: Colors.black38),
  //                     ),
  //               isExpanded: true,
  //               iconSize: 30.0,
  //               style: const TextStyle(color: Colors.black38),
  //               items: [
  //                 'Male',
  //                 'Female',
  //               ].map(
  //                 (val) {
  //                   return DropdownMenuItem<String>(
  //                     value: val,
  //                     child: Text(val),
  //                   );
  //                 },
  //               ).toList(),
  //               onChanged: (val) {
  //                 setState(
  //                   () {
  //                     _dropDownValue = val as String?;
  //                   },
  //                 );
  //               }),
  //           //=========Address  textFeild========//
  //           const SizedBox(height: 10),
  //           FormBuilderTextField(
  //             controller: _address1,
  //             name: address,
  //             decoration: const InputDecoration(labelText: 'Address1'),
  //             validator: FormBuilderValidators.required(),
  //             onSaved: (val) => _clientObject['lastName'] = val ?? '',
  //           ),
  //           //=========Address1  textFeild========//
  //           const SizedBox(height: 10),
  //           FormBuilderTextField(
  //             controller: _address2,
  //             name: address1,
  //             decoration: const InputDecoration(labelText: 'Address2'),
  //             validator: FormBuilderValidators.required(),
  //             onSaved: (val) => _clientObject['lastName'] = val ?? '',
  //           ),
  //           //=========Address2  textFeild========//
  //           const SizedBox(height: 10),
  //           FormBuilderTextField(
  //             controller: _city,
  //             name: city,
  //             decoration: const InputDecoration(labelText: 'City'),
  //             validator: FormBuilderValidators.required(),
  //             onSaved: (val) => _clientObject['lastName'] = val ?? '',
  //           ),
  //           //============city==========//
  //           const SizedBox(height: 10),
  //           FormBuilderTextField(
  //             controller: _country,
  //             name: country,
  //             decoration: const InputDecoration(labelText: 'Country'),
  //             validator: FormBuilderValidators.required(),
  //             onSaved: (val) => _clientObject['lastName'] = val ?? '',
  //           ),
  //============country=============//
  // FormBuilderTextField(
  //   controller: _dob,
  //   name: dob,
  //   decoration: const InputDecoration(labelText: 'Date of Birth'),
  //   validator: FormBuilderValidators.required(),
  //   onSaved: (val) => _clientObject['lastName'] = val ?? '',
  // ),

  //============Date of birth=============//
  //  const SizedBox(height: 10)
  // FormBuilderTextField(
  //   controller: _dob,
  //   name: lastName,
  //   decoration: const InputDecoration(labelText: 'Date of Birth'),
  //   validator: FormBuilderValidators.required(),
  //   onSaved: (val) => _clientObject['lastName'] = val ?? '',
  //   onTap: () async {
  //     DateTime? pickedDate = await showDatePicker(
  //         context: context,
  //         initialDate: DateTime.now(),
  //         firstDate: DateTime(1950),
  //         lastDate: DateTime(2100));

  //     if (pickedDate != null) {
  //       print(pickedDate);
  //       String formattedDate =
  //           DateFormat('yyyy-MM-dd').format(pickedDate);
  //       print(
  //           formattedDate); //formatted date output using intl package =>  2021-03-16
  //       setState(() {
  //         _dob.text =
  //             formattedDate; //set output date to TextField value.
  //       });
  //     } else {}
  //   },
  // ),

  //       saveNameBtn(),
  //     ],
  //   ),
  // ));
}



// void _createClient() {
//   if (_formKey.currentState == null) {
//     debugPrint('_formKey.currentState == null');
//   } else if (_formKey.currentState!.validate()) {
//     _formKey.currentState!.save();

//     final dataStore = ({"clients": _clientObject});
//     AllData.saveJsonData(dataStore);
//     debugPrint(dataStore.toString());

//     ScaffoldMessenger.of(context).showSnackBar(
//       const SnackBar(content: Text('Processing Data')),
//     );
//   } else {
//     ScaffoldMessenger.of(context).showSnackBar(
//       const SnackBar(
//           content: Text('There are some fields that did not validate')),
//     );
//   }
// }
//}
