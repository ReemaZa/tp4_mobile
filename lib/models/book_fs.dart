import 'book.dart';

class BookFs {
  final String id;        // Firestore doc id
  final String name;
  final int price;
  final String image;
  final String userEmail;

  BookFs({
    required this.id,
    required this.name,
    required this.price,
    required this.image,
    required this.userEmail,
  });

  factory BookFs.fromFirestore(Map<String, dynamic> data, String id) {
    return BookFs(
      id: id,
      name: data['name'],
      price: data['price'],
      image: data['image'],
      userEmail: data['userEmail'],
    );
  }

  Map<String, dynamic> toFirestore() {
    return {
      'name': name,
      'price': price,
      'image': image,
      'userEmail': userEmail,
    };


  }

  Book toLocal() {
    return Book(
      id: null, // Firestore has String id
      name: name,
      price: price,
      image: image,
      userEmail: userEmail,
    );
  }

}
