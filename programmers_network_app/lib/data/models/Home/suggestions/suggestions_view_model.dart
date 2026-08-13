class SuggestionsViewModel {
  final bool success;
  final String message;
  final List<dynamic> data;

  SuggestionsViewModel({
    required this.success,
    required this.message,
    required this.data,
  });

  factory SuggestionsViewModel.fromJson(Map<String, dynamic> json) {
    return SuggestionsViewModel(
      success: json['success'] ?? false,
      message: json['message'] ?? '',
      data: json['data'] ?? [],
    );
  }
}
