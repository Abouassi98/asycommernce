// To parse this JSON data, do
//
//     final product = productFromJson(jsonString);

import 'dart:convert';

List<Product> productFromJson(String str) => List<Product>.from(json.decode(str).map((x) => Product.fromJson(x)));

String productToJson(List<Product> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Product {
    Product({
        this.id,
        this.picture,
        this.name,
        this.price,
        this.description,
        this.createdAt,
        this.updatedAt,
        this.v,
        this.createdBy,
        this.updatedBy,
        this.user,
        this.users,
        this.carts,
        this.productId,
    });

    String id;
    Picture picture;
    String name;
    int price;
    String description;
    DateTime createdAt;
    DateTime updatedAt;
    int v;
    AtedBy createdBy;
    AtedBy updatedBy;
    User user;
    List<String> users;
    List<dynamic> carts;
    String productId;

    factory Product.fromJson(Map<String, dynamic> json) => Product(
        id: json["_id"],
        picture: Picture.fromJson(json["picture"]),
        name: json["name"],
        price: json["price"],
        description: json["description"],
        createdAt: DateTime.parse(json["createdAt"]),
        updatedAt: DateTime.parse(json["updatedAt"]),
        v: json["__v"],
        createdBy: AtedBy.fromJson(json["created_by"]),
        updatedBy: AtedBy.fromJson(json["updated_by"]),
        user: json["user"] == null ? null : User.fromJson(json["user"]),
        users: List<String>.from(json["users"].map((x) => x)),
        carts: List<dynamic>.from(json["carts"].map((x) => x)),
        productId: json["id"],
    );

    Map<String, dynamic> toJson() => {
        "_id": id,
        "picture": picture.toJson(),
        "name": name,
        "price": price,
        "description": description,
        "createdAt": createdAt.toIso8601String(),
        "updatedAt": updatedAt.toIso8601String(),
        "__v": v,
        "created_by": createdBy.toJson(),
        "updated_by": updatedBy.toJson(),
        "user": user == null ? null : user.toJson(),
        "users": List<dynamic>.from(users.map((x) => x)),
        "carts": List<dynamic>.from(carts.map((x) => x)),
        "id": productId,
    };
}

class AtedBy {
    AtedBy({
        this.id,
        this.username,
        this.firstname,
        this.lastname,
        this.createdAt,
        this.updatedAt,
        this.v,
        this.atedById,
    });

    Id id;
    dynamic username;
    Firstname firstname;
    Lastname lastname;
    DateTime createdAt;
    DateTime updatedAt;
    int v;
    Id atedById;

    factory AtedBy.fromJson(Map<String, dynamic> json) => AtedBy(
        id: idValues.map[json["_id"]],
        username: json["username"],
        firstname: firstnameValues.map[json["firstname"]],
        lastname: lastnameValues.map[json["lastname"]],
        createdAt: DateTime.parse(json["createdAt"]),
        updatedAt: DateTime.parse(json["updatedAt"]),
        v: json["__v"],
        atedById: idValues.map[json["id"]],
    );

    Map<String, dynamic> toJson() => {
        "_id": idValues.reverse[id],
        "username": username,
        "firstname": firstnameValues.reverse[firstname],
        "lastname": lastnameValues.reverse[lastname],
        "createdAt": createdAt.toIso8601String(),
        "updatedAt": updatedAt.toIso8601String(),
        "__v": v,
        "id": idValues.reverse[atedById],
    };
}

enum Id { THE_5_F7894_E42_E91_DD1774_DE3956 }

final idValues = EnumValues({
    "5f7894e42e91dd1774de3956": Id.THE_5_F7894_E42_E91_DD1774_DE3956
});

enum Firstname { MOHAMED }

final firstnameValues = EnumValues({
    "mohamed": Firstname.MOHAMED
});

enum Lastname { ABOUASSI }

final lastnameValues = EnumValues({
    "abouassi": Lastname.ABOUASSI
});

class Picture {
    Picture({
        this.id,
        this.name,
        this.alternativeText,
        this.caption,
        this.hash,
        this.ext,
        this.mime,
        this.size,
        this.width,
        this.height,
        this.url,
        this.formats,
        this.provider,
        this.related,
        this.createdAt,
        this.updatedAt,
        this.v,
        this.createdBy,
        this.updatedBy,
        this.pictureId,
    });

    String id;
    String name;
    String alternativeText;
    String caption;
    String hash;
    Ext ext;
    Mime mime;
    double size;
    int width;
    int height;
    String url;
    Formats formats;
    String provider;
    List<String> related;
    DateTime createdAt;
    DateTime updatedAt;
    int v;
    Id createdBy;
    Id updatedBy;
    String pictureId;

    factory Picture.fromJson(Map<String, dynamic> json) => Picture(
        id: json["_id"],
        name: json["name"],
        alternativeText: json["alternativeText"],
        caption: json["caption"],
        hash: json["hash"],
        ext: extValues.map[json["ext"]],
        mime: mimeValues.map[json["mime"]],
        size: json["size"].toDouble(),
        width: json["width"],
        height: json["height"],
        url: json["url"],
        formats: Formats.fromJson(json["formats"]),
        provider: json["provider"],
        related: List<String>.from(json["related"].map((x) => x)),
        createdAt: DateTime.parse(json["createdAt"]),
        updatedAt: DateTime.parse(json["updatedAt"]),
        v: json["__v"],
        createdBy: idValues.map[json["created_by"]],
        updatedBy: idValues.map[json["updated_by"]],
        pictureId: json["id"],
    );

    Map<String, dynamic> toJson() => {
        "_id": id,
        "name": name,
        "alternativeText": alternativeText,
        "caption": caption,
        "hash": hash,
        "ext": extValues.reverse[ext],
        "mime": mimeValues.reverse[mime],
        "size": size,
        "width": width,
        "height": height,
        "url": url,
        "formats": formats.toJson(),
        "provider": provider,
        "related": List<dynamic>.from(related.map((x) => x)),
        "createdAt": createdAt.toIso8601String(),
        "updatedAt": updatedAt.toIso8601String(),
        "__v": v,
        "created_by": idValues.reverse[createdBy],
        "updated_by": idValues.reverse[updatedBy],
        "id": pictureId,
    };
}

enum Ext { JPG, PNG, WEBP }

final extValues = EnumValues({
    ".jpg": Ext.JPG,
    ".png": Ext.PNG,
    ".webp": Ext.WEBP
});

class Formats {
    Formats({
        this.thumbnail,
        this.large,
        this.medium,
        this.small,
    });

    Small thumbnail;
    Small large;
    Small medium;
    Small small;

    factory Formats.fromJson(Map<String, dynamic> json) => Formats(
        thumbnail: Small.fromJson(json["thumbnail"]),
        large: json["large"] == null ? null : Small.fromJson(json["large"]),
        medium: json["medium"] == null ? null : Small.fromJson(json["medium"]),
        small: Small.fromJson(json["small"]),
    );

    Map<String, dynamic> toJson() => {
        "thumbnail": thumbnail.toJson(),
        "large": large == null ? null : large.toJson(),
        "medium": medium == null ? null : medium.toJson(),
        "small": small.toJson(),
    };
}

class Small {
    Small({
        this.name,
        this.hash,
        this.ext,
        this.mime,
        this.width,
        this.height,
        this.size,
        this.path,
        this.url,
    });

    String name;
    String hash;
    Ext ext;
    Mime mime;
    int width;
    int height;
    double size;
    dynamic path;
    String url;

    factory Small.fromJson(Map<String, dynamic> json) => Small(
        name: json["name"],
        hash: json["hash"],
        ext: extValues.map[json["ext"]],
        mime: mimeValues.map[json["mime"]],
        width: json["width"],
        height: json["height"],
        size: json["size"].toDouble(),
        path: json["path"],
        url: json["url"],
    );

    Map<String, dynamic> toJson() => {
        "name": name,
        "hash": hash,
        "ext": extValues.reverse[ext],
        "mime": mimeValues.reverse[mime],
        "width": width,
        "height": height,
        "size": size,
        "path": path,
        "url": url,
    };
}

enum Mime { IMAGE_JPEG, IMAGE_PNG, IMAGE_WEBP }

final mimeValues = EnumValues({
    "image/jpeg": Mime.IMAGE_JPEG,
    "image/png": Mime.IMAGE_PNG,
    "image/webp": Mime.IMAGE_WEBP
});

class User {
    User({
        this.confirmed,
        this.blocked,
        this.id,
        this.username,
        this.email,
        this.provider,
        this.createdAt,
        this.updatedAt,
        this.v,
        this.role,
        this.userId,
    });

    bool confirmed;
    bool blocked;
    String id;
    String username;
    String email;
    String provider;
    DateTime createdAt;
    DateTime updatedAt;
    int v;
    String role;
    String userId;

    factory User.fromJson(Map<String, dynamic> json) => User(
        confirmed: json["confirmed"],
        blocked: json["blocked"],
        id: json["_id"],
        username: json["username"],
        email: json["email"],
        provider: json["provider"],
        createdAt: DateTime.parse(json["createdAt"]),
        updatedAt: DateTime.parse(json["updatedAt"]),
        v: json["__v"],
        role: json["role"],
        userId: json["id"],
    );

    Map<String, dynamic> toJson() => {
        "confirmed": confirmed,
        "blocked": blocked,
        "_id": id,
        "username": username,
        "email": email,
        "provider": provider,
        "createdAt": createdAt.toIso8601String(),
        "updatedAt": updatedAt.toIso8601String(),
        "__v": v,
        "role": role,
        "id": userId,
    };
}

class EnumValues<T> {
    Map<String, T> map;
    Map<T, String> reverseMap;

    EnumValues(this.map);

    Map<T, String> get reverse {
        if (reverseMap == null) {
            reverseMap = map.map((k, v) => new MapEntry(v, k));
        }
        return reverseMap;
    }
}
