class RecordProfileViewModel {
  final bool success;
  final String message;
  final List<dynamic> data;

  RecordProfileViewModel({
    required this.success,
    required this.message,
    required this.data,
  });
  factory RecordProfileViewModel.fromJson(Map<String, dynamic> json) {
    return RecordProfileViewModel(
      success: json['success'] ?? false,
      message: json['message'] ?? '',
      data: json['data'] ?? [],
    );
  }
}
