import 'package:programmers_network_app/data/models/Home/search_post_model.dart'
    show Post;
export 'package:programmers_network_app/data/models/Home/search_post_model.dart'
    show Post;

class HomeFeedResponse {
  final bool success;
  final String message;
  final HomeFeedData data;

  HomeFeedResponse({
    required this.success,
    required this.message,
    required this.data,
  });

  factory HomeFeedResponse.fromJson(Map<String, dynamic> json) {
    return HomeFeedResponse(
      success: json['success'] ?? false,
      message: json['message'] ?? '',
      data: HomeFeedData.fromJson(json['data'] ?? {}),
    );
  }
}

class HomeFeedData {
  final int currentPage;
  final List<Post> posts;
  final String? firstPageUrl;
  final int from;
  final int lastPage;
  final String? lastPageUrl;
  final List<HomeFeedPageLink> links;
  final String? nextPageUrl;
  final String? path;
  final int perPage;
  final String? prevPageUrl;
  final int to;
  final int total;

  HomeFeedData({
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

  factory HomeFeedData.fromJson(Map<String, dynamic> json) {
    return HomeFeedData(
      currentPage: json['current_page'] ?? 1,
      posts: (json['data'] as List? ?? [])
          .map((e) => Post.fromJson(e as Map<String, dynamic>))
          .toList(),
      firstPageUrl: json['first_page_url'],
      from: json['from'] ?? 0,
      lastPage: json['last_page'] ?? 1,
      lastPageUrl: json['last_page_url'],
      links: (json['links'] as List? ?? [])
          .map((e) => HomeFeedPageLink.fromJson(e as Map<String, dynamic>))
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

class HomeFeedPageLink {
  final String? url;
  final String label;
  final int? page;
  final bool active;

  HomeFeedPageLink({
    this.url,
    required this.label,
    this.page,
    required this.active,
  });

  factory HomeFeedPageLink.fromJson(Map<String, dynamic> json) {
    return HomeFeedPageLink(
      url: json['url'],
      label: json['label'] ?? '',
      page: json['page'],
      active: json['active'] ?? false,
    );
  }
}
