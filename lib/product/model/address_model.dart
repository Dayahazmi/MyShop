class Address {
  final String street;
  final String city;
  final String postalCode;
  final String state;
  bool isSelected;

  Address({
    required this.street,
    required this.city,
    required this.postalCode,
    required this.state,
    this.isSelected = false,
  });

  Map<String, dynamic> toJson() => {
        'street': street,
        'city': city,
        'postalCode': postalCode,
        'state': state,
        'isSelected': isSelected,
      };

  factory Address.empty() {
    return Address(street: '', city: '', postalCode: '', state: '');
  }

  factory Address.fromJson(Map<String, dynamic> json) => Address(
        street: json['street'],
        city: json['city'],
        postalCode: json['postalCode'],
        state: json['state'],
        isSelected: json['isSelected'] ?? false,
      );

  String get fullAddress => '$street, $city, $postalCode $state';
}
