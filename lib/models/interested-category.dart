// ignore_for_file: file_names

class InterestedCategory {
  String? clickledUserIdStringValue;
  String? placeCategoryStringValue;
  int? count;

  InterestedCategory(
      {this.clickledUserIdStringValue,
      this.placeCategoryStringValue,
      this.count});

  InterestedCategory.fromJson(Map<String, dynamic> json) {
    clickledUserIdStringValue = json['user_id'];
    placeCategoryStringValue = json['category'];
    count = json['count'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['clickled_user_id_string_value'] = clickledUserIdStringValue;
    data['place_category_string_value'] = placeCategoryStringValue;
    data['count'] = count;
    return data;
  }
}
