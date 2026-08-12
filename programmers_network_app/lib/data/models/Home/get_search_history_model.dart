class DataHistroySearch {
  final int id;
  final int userId;
  final String search;
  final String? createdAt;
  final String? updatedAt;

  DataHistroySearch({
    required this.id,
    required this.userId,
    required this.search,
    this.createdAt,
    this.updatedAt,
  });

  factory DataHistroySearch.fromJson(Map<String, dynamic> json) {
    return DataHistroySearch(
      id: json['id'] ?? 0,
      userId: json['user_id'] ?? 0,
      search: json['search'] ?? '',
      createdAt: json['created_at']?.toString(),
      updatedAt: json['updated_at']?.toString(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'user_id': userId,
      'search': search,
      'created_at': createdAt,
      'updated_at': updatedAt,
    };
  }
}

class HistoryData {
  final int currentPage;
  final List<DataHistroySearch> history;
  final int lastPage;
  final int perPage;
  final int total;
  final String? firstPageUrl;
  final String? lastPageUrl;
  final String? nextPageUrl;
  final String? prevPageUrl;
  final String? path;
  final int? from;
  final int? to;

  HistoryData({
    required this.currentPage,
    required this.history,
    required this.lastPage,
    required this.perPage,
    required this.total,
    this.firstPageUrl,
    this.lastPageUrl,
    this.nextPageUrl,
    this.prevPageUrl,
    this.path,
    this.from,
    this.to,
  });

  factory HistoryData.fromJson(Map<String, dynamic> json) {
    return HistoryData(
      currentPage: json['current_page'] ?? 1,

      history: (json['data'] as List<dynamic>? ?? [])
          .map((e) => DataHistroySearch.fromJson(e as Map<String, dynamic>))
          .toList(),

      lastPage: json['last_page'] ?? 1,
      perPage: json['per_page'] ?? 20,
      total: json['total'] ?? 0,

      firstPageUrl: json['first_page_url']?.toString(),
      lastPageUrl: json['last_page_url']?.toString(),

      nextPageUrl: json['next_page_url']?.toString(),
      prevPageUrl: json['prev_page_url']?.toString(),

      path: json['path']?.toString(),

      from: json['from'],
      to: json['to'],
    );
  }
}

class GetSearchHistoryModel {
  final bool success;
  final String message;
  final HistoryData data;

  GetSearchHistoryModel({
    required this.success,
    required this.message,
    required this.data,
  });

  factory GetSearchHistoryModel.fromJson(Map<String, dynamic> json) {
    return GetSearchHistoryModel(
      success: json['success'] ?? false,
      message: json['message'] ?? '',

      data: HistoryData.fromJson(json['data'] as Map<String, dynamic>? ?? {}),
    );
  }
}
