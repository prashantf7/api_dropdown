// To parse this JSON data, do
//
//     final dropdownItemModels = dropdownItemModelsFromJson(jsonString);

import 'dart:convert';

List<DropdownItemModels> dropdownItemModelsFromJson(String str) => List<DropdownItemModels>.from(json.decode(str).map((x) => DropdownItemModels.fromJson(x)));

String dropdownItemModelsToJson(List<DropdownItemModels> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class DropdownItemModels {
    int userId;
    int id;
    String title;

    DropdownItemModels({
        required this.userId,
        required this.id,
        required this.title,
    });

    factory DropdownItemModels.fromJson(Map<String, dynamic> json) => DropdownItemModels(
        userId: json["userId"],
        id: json["id"],
        title: json["title"],
    );

    Map<String, dynamic> toJson() => {
        "userId": userId,
        "id": id,
        "title": title,
    };
}
