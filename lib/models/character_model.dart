import 'dart:convert';

List<Character> characterFromJson(String str) =>
    List<Character>.from(json.decode(str).map((x) => Character.fromJson(x)));

String characterToJson(List<Character> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Character {
  Character({
    required this.charId,
    required this.name,
    required this.birthday,
    required this.occupation,
    required this.img,
    required this.status,
    required this.nickname,
    required this.appearance,
    required this.portrayed,
    required this.category,
    required this.betterCallSaulAppearance,
  });

  int charId;
  String name;
  String birthday;
  List<String> occupation;
  String img;
  String status;
  String nickname;
  List<int> appearance;
  String portrayed;
  String category;
  List<int> betterCallSaulAppearance;

  factory Character.fromJson(Map<String, dynamic> json) => Character(
        charId: json["char_id"],
        name: json["name"],
        birthday: json["birthday"],
        occupation: List<String>.from(json["occupation"].map((x) => x)).toList(),
        img: json["img"],
        status: json["status"],
        nickname: json["nickname"],
        appearance: List<int>.from(json["appearance"].map((x) => x)),
        portrayed: json["portrayed"],
        category: json["category"],
        betterCallSaulAppearance:
            List<int>.from(json["better_call_saul_appearance"].map((x) => x)),
      );

  Map<String, dynamic> toJson() => {
        "char_id": charId,
        "name": name,
        "birthday": birthday,
        "occupation": List<dynamic>.from(occupation.map((x) => x)),
        "img": img,
        "status": status,
        "nickname": nickname,
        "appearance": List<dynamic>.from(appearance.map((x) => x)),
        "portrayed": portrayed,
        "category": category,
        "better_call_saul_appearance":
            List<dynamic>.from(betterCallSaulAppearance.map((x) => x)),
      };
}
