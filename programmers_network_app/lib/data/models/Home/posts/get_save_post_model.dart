import 'package:programmers_network_app/data/models/Home/search_post_model.dart'
    show Post;
export 'package:programmers_network_app/data/models/Home/search_post_model.dart'
    show Post;

class GetSavedPostsResponse {
  final bool success;
  final String message;
  final GetSavedPostsData data;

  GetSavedPostsResponse({
    required this.success,
    required this.message,
    required this.data,
  });

  factory GetSavedPostsResponse.fromJson(Map<String, dynamic> json) {
    return GetSavedPostsResponse(
      success: json['success'] ?? false,
      message: json['message'] ?? '',
      data: GetSavedPostsData.fromJson(json['data'] ?? {}),
    );
  }
}

class GetSavedPostsData {
  final int currentPage;
  final List<Post> posts;
  final String? firstPageUrl;
  final int from;
  final int lastPage;
  final String? lastPageUrl;
  final List<GetPageLink> links;
  final String? nextPageUrl;
  final String? path;
  final int perPage;
  final String? prevPageUrl;
  final int to;
  final int total;

  GetSavedPostsData({
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

  factory GetSavedPostsData.fromJson(Map<String, dynamic> json) {
    return GetSavedPostsData(
      currentPage: json['current_page'] ?? 1,
      posts: (json['data'] as List? ?? []).map((e) {
        final post = Post.fromJson(e as Map<String, dynamic>);

        return post.copyWith(isSaved: true);
      }).toList(),

      firstPageUrl: json['first_page_url'],
      from: json['from'] ?? 0,
      lastPage: json['last_page'] ?? 1,
      lastPageUrl: json['last_page_url'],
      links: (json['links'] as List? ?? [])
          .map((e) => GetPageLink.fromJson(e as Map<String, dynamic>))
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

class GetPageLink {
  final String? url;
  final String label;
  final int? page;
  final bool active;

  GetPageLink({this.url, required this.label, this.page, required this.active});

  factory GetPageLink.fromJson(Map<String, dynamic> json) {
    return GetPageLink(
      url: json['url'],
      label: json['label'] ?? '',
      page: json['page'],
      active: json['active'] ?? false,
    );
  }
}
