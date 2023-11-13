 class Book{
 final String id;
 final String name;
 final String desc;
 final String imageUrl;
 final int count;
 final num price;

 const Book({
   required this.id,
   required this.name,
   required this.desc,
   required this.imageUrl,
   required this.count,
   required this.price
});

 factory Book.fromJson(Map<String, Object?>json){
   String id = json["id"] as String;
   String name = json["name"] as String;
   String desc = json["desc"] as String;
   int count = json["count"] as int;
   num price = json["price"] as num;
   String imageUrl = json["imageUrl"] as String;
    return Book(id: id, name: name, desc: desc, count: count, price: price, imageUrl: imageUrl);
 }

 Map<String, Object?> toJson() {
   return {
     "id":id,
     "name":name,
     "desc":desc,
     "count":count,
     "price":price,
     "imageUrl":imageUrl,
   };
 }

 @override
  String toString() {
    return 'Book{'
        'id: $id, '
        'name: $name, '
        'desc: $desc, '
        'imageUrl: $imageUrl, '
        'count: $count, '
        'price: $price}';
 }

 @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is Book &&
          runtimeType == other.runtimeType &&
          id == other.id &&
          name == other.name &&
          desc == other.desc &&
          imageUrl == other.imageUrl &&
          count == other.count &&
          price == other.price;

  @override
  int get hashCode =>Object.hash(id, name, price);
}