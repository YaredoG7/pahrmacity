class Medicine {
  String name;
  String manufacturer;
  String dosageForm;
  String pharmacy;
  double price;
  DateTime expiryDate;
  DateTime? manufacturingDate;
  int quantity;
  String description;
  String? composition;
  bool? stockAvailability;
  String? category;
  String? barcode;
  String? imageUrl;
  String? storageConditions;
  bool? prescriptionRequired;
  DateTime? created;

  Medicine(
      {required this.name,
      required this.manufacturer,
      required this.dosageForm,
      required this.pharmacy,
      required this.price,
      required this.expiryDate,
      required this.quantity,
      required this.description,
      this.composition,
      this.prescriptionRequired,
      this.imageUrl,
      this.manufacturingDate,
      this.category,
      this.storageConditions,
      this.barcode,
      this.stockAvailability,
      this.created});

  factory Medicine.fromJson(Map<String, dynamic> json) {
    return Medicine(
      name: json['name'],
      manufacturer: json['manufacturer'],
      dosageForm: json['dosageForm'],
      pharmacy: json['pharmacy'],
      price: json['price'].toDouble(),
      expiryDate: DateTime.parse(json['expiryDate']),
      manufacturingDate: DateTime.parse(json['manufacturingDate']),
      quantity: json['quantity'],
      description: json['description'],
      composition: json['composition'],
      stockAvailability: json['stockAvailability'],
      category: json['category'],
      barcode: json['barcode'],
      imageUrl: json['imageUrl'],
      storageConditions: json['storageConditions'],
      prescriptionRequired: json['prescriptionRequired'],
      created: json['created'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'manufacturer': manufacturer,
      'dosageForm': dosageForm,
      'pharmacy': pharmacy,
      'price': price,
      'expiryDate': expiryDate.toIso8601String(),
      'manufacturingDate': manufacturingDate!.toIso8601String(),
      'quantity': quantity,
      'description': description,
      'composition': composition,
      'prescriptionRequired': prescriptionRequired,
      'imageUrl': imageUrl,
      'barcode': barcode,
      'category': category,
      'stockAvailability': stockAvailability,
      'storageConditions': storageConditions,
      'created': created,
    };
  }
}
