class Client {
  final String firstName;
  final String lastName;
  final String clientId;
  //final String dob;
  final String address1;
  final String address2;
  final String city;
  final String postcode;
  final String country;

  Client({
    required this.firstName,
    required this.lastName,
    required this.clientId,
    // required this.dob,
    required this.address1,
    required this.address2,
    required this.city,
    required this.postcode,
    required this.country,
  });
//constructor to convert json to object instance
  static Client fromJson(Map<Stream, dynamic> json) => Client(
        firstName: json['firstName'] ?? "",
        lastName: json['lastName'] ?? "",
        clientId: json['clientId'] ?? "",
        //  dob: json['dob'],
        address1: json['address1'] ?? "",
        address2: json['address2'] ?? "",
        city: json['city'] ?? "",
        postcode: json['postcode'] ?? "",
        country: json['country'] ?? "",
      );

  //a method that convert object to Json string

  Map<String, dynamic> toJson() => {
        'firstName': firstName,
        'lastName': lastName,
        'clientId': clientId,
        //'dob': dob,
        'address1': address1,
        'address2': address2,
        'city': city,
        'postcode': postcode,
        'country': country
      };

  @override
  String toString() {
    return '{ $firstName, $lastName, $address1, $address2, $city, $clientId }';
  }
}
