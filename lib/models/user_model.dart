class PharmaUser {
  String fullName;
  String phoneNum;
  String city;
  String street;
  String areaCode;
  String line;
  DateTime birthdate;
  bool isActive;
  String? line2;
  String role;
  String? secondgEmail;
  String description;
  String? businessPhone;
  String? imageUrl;
  String? email;
  String? state;
  String? id;
  Object? location;
  bool? locationVerified;
  bool? phoneVerified;
  List<String>? documents;
  DateTime? created;

  PharmaUser({
    required this.fullName,
    required this.phoneNum,
    required this.city,
    required this.street,
    required this.areaCode,
    required this.line,
    required this.isActive,
    required this.role,
    required this.email,
    required this.description,
    required this.birthdate,
    this.businessPhone,
    this.secondgEmail,
    this.state,
    this.imageUrl,
    this.line2,
    this.id,
    this.location,
    this.locationVerified,
    this.phoneVerified,
    this.documents,
    this.created,
  });

  factory PharmaUser.fromJson(Map<String, dynamic> json) {
    return PharmaUser(
      fullName: json['fullName'],
      phoneNum: json['phoneNum'],
      city: json['city'],
      role: json['role'],
      street: json['street'],
      areaCode: json['areaCode'],
      birthdate: DateTime.parse(json['birthdate']),
      line: json['line'],
      isActive: json['isActive'],
      secondgEmail: json['secondgEmail'],
      description: json['description'],
      businessPhone: json['businessPhone'],
      state: json['state'],
      imageUrl: json['imageUrl'],
      email: json['email'],
      location: json['location'],
      locationVerified: json['locationVerified'],
      phoneVerified: json['phoneVerified'],
      id: json['id'],
      created: DateTime.parse(json['created']),
      // documents: json['documents'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'fullName': fullName,
      'phoneNum': phoneNum,
      'city': city,
      'street': street,
      'areaCode': areaCode,
      'birthdate': birthdate.toIso8601String(),
      'line': line,
      'state': state,
      'isActive': isActive,
      'line2': line2,
      'role': role,
      'secondgEmail': secondgEmail,
      'description': description,
      'businessPhone': businessPhone,
      'imageUrl': imageUrl,
      'id': id,
      'email': email,
      'location': location,
      'locationVerified': locationVerified,
      'phoneVerified': phoneVerified,
      'created': created?.toIso8601String(),
      //'documents': documents,
    };
  }
}
