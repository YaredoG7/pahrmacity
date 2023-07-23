class Pharmacy {
  String name;
  String registrationNo;
  String city;
  String street;
  String areaCode;
  String line;
  bool isActive;
  String? line2;
  String billingEmail;
  String description;
  String? businessPhone;
  String? group;
  String? fullName;
  String? holderPhone;
  String? imageUrl;
  String? holderEmail;
  String? holderType;
  String? website;
  String? state;
  String? id;
  Object? location;
  bool? locationVerified;
  List<String>? documents;
  final DateTime? created;

  Pharmacy(
      {required this.name,
      required this.registrationNo,
      required this.city,
      required this.street,
      required this.areaCode,
      required this.line,
      required this.isActive,
      required this.billingEmail,
      required this.description,
      this.businessPhone,
      this.website,
      this.state,
      this.imageUrl,
      this.line2,
      this.fullName,
      this.holderEmail,
      this.holderPhone,
      this.id,
      this.group,
      this.location,
      this.holderType,
      this.locationVerified,
      this.documents,
      this.created});

  factory Pharmacy.fromJson(Map<String, dynamic> json) {
    return Pharmacy(
      name: json['name'],
      registrationNo: json['registrationNo'],
      city: json['city'],
      street: json['street'],
      areaCode: json['areaCode'],
      line: json['line'],
      isActive: json['isActive'],
      billingEmail: json['billingEmail'],
      description: json['description'],
      businessPhone: json['businessPhone'],
      group: json['group'],
      state: json['state'],
      fullName: json['fullName'],
      holderPhone: json['holderPhone'],
      imageUrl: json['imageUrl'],
      holderEmail: json['holderEmail'],
      website: json['website'],
      location: json['location'],
      holderType: json['holderType'],
      locationVerified: json['locationVerified'],
      id: json['id'],
      // documents: json['documents'],
      created: json['created'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'registrationNo': registrationNo,
      'city': city,
      'street': street,
      'areaCode': areaCode,
      'line': line,
      'state': state,
      'isActive': isActive,
      'line2': line2,
      'billingEmail': billingEmail,
      'description': description,
      'businessPhone': businessPhone,
      'website': website,
      'imageUrl': imageUrl,
      'holderPhone': holderPhone,
      'fullName': fullName,
      'id': id,
      'group': group,
      'holderEmail': holderEmail,
      'holderType': holderType,
      'location': location,
      'locationVerified': locationVerified,
      'created': created,
      //'documents': documents,
    };
  }
}
