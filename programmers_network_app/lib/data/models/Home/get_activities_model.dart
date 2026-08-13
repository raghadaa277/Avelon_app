import 'package:programmers_network_app/data/models/Home/home_page_model.dart';

class GetActivitesResponse {
  final bool success;
  final String message;
  final GetActivitesData data;

  GetActivitesResponse({
    required this.success,
    required this.message,
    required this.data,
  });

  factory GetActivitesResponse.fromJson(Map<String, dynamic> json) {
    return GetActivitesResponse(
      success: json['success'] ?? false,
      message: json['message'] ?? '',
      data: GetActivitesData.fromJson(json['data'] ?? {}),
    );
  }
}

class GetActivitesData {
  final int currentPage;
  final List<Post> posts;
  final String? firstPageUrl;
  final int from;
  final int lastPage;
  final String? lastPageUrl;
  final List<GetActivitesPageLink> links;
  final String? nextPageUrl;
  final String? path;
  final int perPage;
  final String? prevPageUrl;
  final int to;
  final int total;

  GetActivitesData({
    required this.currentPage,
    required this.posts,
    this.firstPageUrl,
    required this.from,
    required this.lastPage,
    this.lastPageUrl,
    required this.links,
    this.nextPageUrl,
    this.path,
    required this.perPage,
    this.prevPageUrl,
    required this.to,
    required this.total,
  });

  factory GetActivitesData.fromJson(Map<String, dynamic> json) {
    return GetActivitesData(
      currentPage: json['current_page'] ?? 1,

      posts: (json['data'] as List? ?? [])
          .map((e) => Post.fromJson(e as Map<String, dynamic>))
          .toList(),

      firstPageUrl: json['first_page_url'],
      from: json['from'] ?? 0,
      lastPage: json['last_page'] ?? 1,
      lastPageUrl: json['last_page_url'],

      links: (json['links'] as List? ?? [])
          .map((e) => GetActivitesPageLink.fromJson(e as Map<String, dynamic>))
          .toList(),

      nextPageUrl: json['next_page_url'],
      path: json['path'],
      perPage: json['per_page'] ?? 5,
      prevPageUrl: json['prev_page_url'],
      to: json['to'] ?? 0,
      total: json['total'] ?? 0,
    );
  }
}

class GetActivitesPageLink {
  final String? url;
  final String label;
  final int? page;
  final bool active;

  GetActivitesPageLink({
    this.url,
    required this.label,
    this.page,
    required this.active,
  });

  factory GetActivitesPageLink.fromJson(Map<String, dynamic> json) {
    return GetActivitesPageLink(
      url: json['url'],
      label: json['label'] ?? '',
      page: json['page'],
      active: json['active'] ?? false,
    );
  }
}
