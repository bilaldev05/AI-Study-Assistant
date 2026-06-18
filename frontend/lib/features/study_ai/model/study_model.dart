class StudyModel {
  final bool success;
  final String response;

  StudyModel({
    required this.success,
    required this.response,
  });

  factory StudyModel.fromJson(Map<String, dynamic> json) {
    return StudyModel(
      success: json['success'] ?? false,
      response: json['response'] ?? '',
    );
  }
}