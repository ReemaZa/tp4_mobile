class Book {
  final int? id; //  clé primaire SQLite
  final String name;
  final int price;
  final String image;
  final String? userEmail;

  Book({
    this.id,
    required this.name,
    required this.price,
    required this.image,
    this.userEmail,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'price': price,
      'image': image,
      'user_email': userEmail,
    };
  }

  factory Book.fromMap(Map<String, dynamic> map) {
    return Book(
      id: map['id'],
      name: map['name'],
      price: map['price'],
      image: map['image'],
      userEmail: map['user_email'],
    );
  }
}
