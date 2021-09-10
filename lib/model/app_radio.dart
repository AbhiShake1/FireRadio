import 'dart:convert';

import 'package:flutter/foundation.dart';

class AppRadioList {
  final List<AppRadio> radios;

  AppRadioList({
    required this.radios,
  });

  AppRadioList copyWith({
    required List<AppRadio> radios,
  }) {
    return AppRadioList(
      radios: radios,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'radios': radios.map((x) => x.toMap()).toList(),
    };
  }

  factory AppRadioList.fromMap(Map<String, dynamic> map) {
    return AppRadioList(
      radios:
          List<AppRadio>.from(map['radios']?.map((x) => AppRadio.fromMap(x))),
    );
  }

  String toJson() => json.encode(toMap());

  factory AppRadioList.fromJson(String source) =>
      AppRadioList.fromMap(json.decode(source));

  @override
  String toString() => 'MyRadioList(radios: $radios)';

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is AppRadioList && listEquals(other.radios, radios);
  }

  @override
  int get hashCode => radios.hashCode;
}

class AppRadio {
  final int id, order;
  final String name, tagline, color, desc, url, category, icon, image, lang;

  AppRadio({
    required this.id,
    required this.order,
    required this.name,
    required this.tagline,
    required this.color,
    required this.desc,
    required this.url,
    required this.category,
    required this.icon,
    required this.image,
    required this.lang,
  });

  AppRadio copyWith({
    required int id,
    required int order,
    required String name,
    required String tagline,
    required String color,
    required String desc,
    required String url,
    required String category,
    required String icon,
    required String image,
    required String lang,
  }) {
    return AppRadio(
      id: id,
      order: order,
      name: name,
      tagline: tagline,
      color: color,
      desc: desc,
      url: url,
      category: category,
      icon: icon,
      image: image,
      lang: lang,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'order': order,
      'name': name,
      'tagline': tagline,
      'color': color,
      'desc': desc,
      'url': url,
      'category': category,
      'icon': icon,
      'image': image,
      'lang': lang,
    };
  }

  factory AppRadio.fromMap(Map<String, dynamic> map) {
    return AppRadio(
      id: map['id'],
      order: map['order'],
      name: map['name'],
      tagline: map['tagline'],
      color: map['color'],
      desc: map['desc'],
      url: map['url'],
      category: map['category'],
      icon: map['icon'],
      image: map['image'],
      lang: map['lang'],
    );
  }

  String toJson() => json.encode(toMap());

  factory AppRadio.fromJson(String source) =>
      AppRadio.fromMap(json.decode(source));

  @override
  String toString() {
    return 'MyRadio(id: $id, order: $order, name: $name, tagline: $tagline, color: $color, desc: $desc, url: $url, category: $category, icon: $icon, image: $image, lang: $lang)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is AppRadio &&
        other.id == id &&
        other.order == order &&
        other.name == name &&
        other.tagline == tagline &&
        other.color == color &&
        other.desc == desc &&
        other.url == url &&
        other.category == category &&
        other.icon == icon &&
        other.image == image &&
        other.lang == lang;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        order.hashCode ^
        name.hashCode ^
        tagline.hashCode ^
        color.hashCode ^
        desc.hashCode ^
        url.hashCode ^
        category.hashCode ^
        icon.hashCode ^
        image.hashCode ^
        lang.hashCode;
  }
}
