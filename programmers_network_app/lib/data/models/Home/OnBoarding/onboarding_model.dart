class SourcesModel {
  final int id;
  final String name;
  final String label;
  final DateTime? createdAt;
  final DateTime? updatedAt;
  SourcesModel({
    required this.id,
    required this.name,
    required this.label,
    required this.createdAt,
    required this.updatedAt,
  });

  factory SourcesModel.fromJson(Map<String, dynamic> json) {
    return SourcesModel(
      id: json['id'] ?? 0,
      name: json['name'] ?? '',
      label: json['label'] ?? '',
      createdAt: json['created_at'] != null
          ? DateTime.parse(json['created_at'])
          : null,

      updatedAt: json['updated_at'] != null
          ? DateTime.parse(json['updated_at'])
          : null,
    );
  }
}

class GoalsModel {
  final int id;
  final String name;
  final String label;
  final DateTime? createdAt;
  final DateTime? updatedAt;

  GoalsModel({
    required this.id,
    required this.name,
    required this.label,
    required this.createdAt,
    required this.updatedAt,
  });

  factory GoalsModel.fromJson(Map<String, dynamic> json) {
    return GoalsModel(
      id: json['id'] ?? 0,
      name: json['name'] ?? '',
      label: json['label'] ?? '',
      createdAt: json['created_at'] != null
          ? DateTime.parse(json['created_at'])
          : null,

      updatedAt: json['updated_at'] != null
          ? DateTime.parse(json['updated_at'])
          : null,
    );
  }
}

class InspirationSourcesModel {
  final int id;
  final String name;
  final String label;
  final DateTime? createdAt;
  final DateTime? updatedAt;

  InspirationSourcesModel({
    required this.id,
    required this.name,
    required this.label,
    required this.createdAt,
    required this.updatedAt,
  });

  factory InspirationSourcesModel.fromJson(Map<String, dynamic> json) {
    return InspirationSourcesModel(
      id: json['id'] ?? 0,
      name: json['name'] ?? '',
      label: json['label'] ?? '',
      createdAt: json['created_at'] != null
          ? DateTime.parse(json['created_at'])
          : null,

      updatedAt: json['updated_at'] != null
          ? DateTime.parse(json['updated_at'])
          : null,
    );
  }
}

class TagsModel {
  final int id;
  final String name;
  final String label;
  final DateTime? createdAt;
  final DateTime? updatedAt;

  TagsModel({
    required this.id,
    required this.name,
    required this.label,
    required this.createdAt,
    required this.updatedAt,
  });

  factory TagsModel.fromJson(Map<String, dynamic> json) {
    return TagsModel(
      id: json['id'] ?? 0,
      name: json['name'] ?? '',
      label: json['label'] ?? '',
      createdAt: json['created_at'] != null
          ? DateTime.parse(json['created_at'])
          : null,

      updatedAt: json['updated_at'] != null
          ? DateTime.parse(json['updated_at'])
          : null,
    );
  }
}

class DataOnBoardingModel {
  final List<SourcesModel> sources;
  final List<GoalsModel> goals;
  final List<InspirationSourcesModel> inspir;
  final List<TagsModel> tags;

  DataOnBoardingModel({
    required this.sources,
    required this.goals,
    required this.inspir,
    required this.tags,
  });
  factory DataOnBoardingModel.fromJson(Map<String, dynamic> json) {
    return DataOnBoardingModel(
      sources: (json['sources'] as List? ?? [])
          .map((e) => SourcesModel.fromJson(e))
          .toList(),

      goals: (json['goals'] as List? ?? [])
          .map((e) => GoalsModel.fromJson(e))
          .toList(),

      inspir: (json['inspiration_sources'] as List? ?? [])
          .map((e) => InspirationSourcesModel.fromJson(e))
          .toList(),

      tags: (json['tags'] as List? ?? [])
          .map((e) => TagsModel.fromJson(e))
          .toList(),
    );
  }
}

class OnboardingModel {
  final bool success;
  final String message;
  final DataOnBoardingModel data;

  OnboardingModel({
    required this.success,
    required this.message,
    required this.data,
  });

  factory OnboardingModel.fromJson(Map<String, dynamic> json) {
    return OnboardingModel(
      success: json['success'] ?? false,
      message: json['message'] ?? '',
      data: DataOnBoardingModel.fromJson(json['data'] ?? {}),
    );
  }
}
