class Customer {
  final int id;
  final String name;
  final String profilePic;
  final String mobileNumber;
  final String email;
  final String street;
  final String streetTwo;
  final String city;
  final int pincode;
  final String country;
  final String state;

  Customer({
    required this.id,
    required this.name,
    this.profilePic = "null",
    required this.mobileNumber,
    required this.email,
    required this.street,
    required this.streetTwo,
    required this.city,
    required this.pincode,
    required this.country,
    required this.state,
  });

  factory Customer.fromJson(Map<String, dynamic> json) {
    return Customer(
      id: json['id'],
      name: json['name'],
      mobileNumber: json['mobile_number'],
      email: json['email'],
      street: json['street'],
      streetTwo: json['street_two'],
      city: json['city'],
      pincode: json['pincode'],
      country: json['country'],
      state: json['state'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'profile_pic': "null",
      'mobile_number': mobileNumber,
      'email': email,
      'street': street,
      "street_two": streetTwo,
      'city': city,
      'pincode': pincode,
      'country': country,
      'state': state,
    };
  }
}
