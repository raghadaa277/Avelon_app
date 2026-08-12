import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hugeicons/hugeicons.dart';
import 'package:programmers_network_app/core/const/color_const.dart';
import 'package:programmers_network_app/view/widget/Home/search/empty_history_widget.dart';
import 'package:timeago/timeago.dart' as timeago;

import 'package:programmers_network_app/controller/Home/search_controller.dart';
import 'package:programmers_network_app/data/models/Home/get_search_history_model.dart';

class HistorySearchWidget extends StatefulWidget {
  final TextEditingController searchController;
  final String searchType;

  const HistorySearchWidget({
    super.key,
    required this.searchController,
    required this.searchType,
  });

  @override
  State<HistorySearchWidget> createState() => _HistorySearchWidgetState();
}

class _HistorySearchWidgetState extends State<HistorySearchWidget> {
  late final SearchPageController controller;

  final ScrollController _scrollController = ScrollController();

  static const Color _background = Color(0xffF5F6F3);
  static const Color _text = Color(0xff171A17);

  @override
  void initState() {
    super.initState();

    controller = Get.find<SearchPageController>();

    _scrollController.addListener(_onScroll);

    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (!mounted) return;

      if (controller.searchHistory.isEmpty && !controller.isLoadingHistory) {
        controller.getSearchHistory(refresh: true);
      }
    });
  }

  void _onScroll() {
    if (!_scrollController.hasClients) return;

    if (_scrollController.position.pixels >=
        _scrollController.position.maxScrollExtent - 180) {
      controller.loadMoreSearchHistory();
    }
  }

  @override
  void dispose() {
    _scrollController.removeListener(_onScroll);
    _scrollController.dispose();
    super.dispose();
  }

  void _onHistoryTap(DataHistroySearch item) {
    final text = item.search.trim();

    if (text.isEmpty) return;

    // حطينا الكلمة المختارة داخل الـ TextField
    widget.searchController.value = TextEditingValue(
      text: text,
      selection: TextSelection.collapsed(offset: text.length),
    );

    // نفذ البحث حسب الـ Tab الحالي
    if (widget.searchType == 'post') {
      controller.searchPost(
        type: widget.searchType,
        search: text,
        refresh: true,
      );
    } else {
      controller.search(user: widget.searchType, search: text, refresh: true);
    }

    // إخفاء الكيبورد
    FocusScope.of(context).unfocus();
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<SearchPageController>(
      builder: (controller) {
        return Container(color: _background, child: _buildContent(controller));
      },
    );
  }

  Widget _buildContent(SearchPageController controller) {
    if (controller.isLoadingHistory && controller.searchHistory.isEmpty) {
      return const HistoryLoadingWidget();
    }

    if (!controller.isLoadingHistory && controller.searchHistory.isEmpty) {
      return const EmptyHistoryWidget();
    }

    return RefreshIndicator(
      color: _text,
      backgroundColor: ColorConst.colorApp,
      displacement: 24,
      onRefresh: () {
        return controller.getSearchHistory(refresh: true);
      },
      child: ListView.builder(
        controller: _scrollController,
        physics: const AlwaysScrollableScrollPhysics(),
        padding: const EdgeInsets.fromLTRB(20, 28, 20, 40),
        itemCount:
            controller.searchHistory.length +
            (controller.isLoadingMoreHistory ? 1 : 0) +
            1,
        itemBuilder: (context, index) {
          if (index == 0) {
            return HistoryHeaderWidget(count: controller.searchHistory.length);
          }

          final historyIndex = index - 1;

          if (historyIndex >= controller.searchHistory.length) {
            return const HistoryPaginationLoader();
          }

          final item = controller.searchHistory[historyIndex];

          return Padding(
            padding: const EdgeInsets.only(bottom: 12),
            child: HistoryCardWidget(
              item: item,

              // الضغط على عنصر الـ history
              onTap: () => _onHistoryTap(item),

              onDelete: () {
                controller.clearOneSearchHistory(searchHistoryId: item.id);
              },
            ),
          );
        },
      ),
    );
  }
}

class HistoryHeaderWidget extends StatelessWidget {
  const HistoryHeaderWidget({super.key, required this.count});

  final int count;

  static const Color _muted = Color(0xff858B84);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 2, right: 2, bottom: 22),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 6),

          Text(
            count == 1 ? '1 recent search' : '$count recent searches',
            style: const TextStyle(
              color: _muted,
              fontSize: 13,
              fontWeight: FontWeight.w500,
              letterSpacing: -0.1,
            ),
          ),
        ],
      ),
    );
  }
}

class HistoryCardWidget extends StatelessWidget {
  const HistoryCardWidget({
    super.key,
    required this.item,
    required this.onTap,
    required this.onDelete,
  });

  final DataHistroySearch item;
  final VoidCallback onTap;
  final VoidCallback onDelete;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(20),
        splashColor: Colors.black.withValues(alpha: 0.025),
        highlightColor: Colors.black.withValues(alpha: 0.015),
        child: Container(
          width: double.infinity,
          padding: const EdgeInsets.fromLTRB(18, 17, 12, 17),
          decoration: BoxDecoration(
            color: ColorConst.lightGreenBg,
            borderRadius: BorderRadius.circular(20),

            boxShadow: [
              BoxShadow(
                color: Colors.black.withValues(alpha: 0.75),
                blurRadius: 18,
                spreadRadius: 0,
                offset: const Offset(0, 2),
              ),
              BoxShadow(
                color: Colors.black.withValues(alpha: 0.025),
                blurRadius: 3,
                spreadRadius: 0,
                offset: const Offset(0, 1),
              ),
            ],
          ),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Expanded(
                child: HistoryCardContentWidget(
                  search: item.search,
                  createdAt: item.createdAt,
                ),
              ),

              const SizedBox(width: 12),

              HistoryCloseButtonWidget(onPressed: onDelete),
            ],
          ),
        ),
      ),
    );
  }
}

class HistoryCardContentWidget extends StatelessWidget {
  const HistoryCardContentWidget({
    super.key,
    required this.search,
    required this.createdAt,
  });

  final String search;
  final String? createdAt;

  static const Color _text = Color(0xff171A17);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          search,
          maxLines: 2,
          overflow: TextOverflow.ellipsis,
          style: TextStyle(
            color: _text,
            fontSize: 15.5,
            fontWeight: FontWeight.w600,
            height: 1.25,
            letterSpacing: -0.25,
          ),
        ),

        const SizedBox(height: 8),

        HistoryDateWidget(createdAt: createdAt),
      ],
    );
  }
}

class HistoryDateWidget extends StatelessWidget {
  const HistoryDateWidget({super.key, required this.createdAt});

  final String? createdAt;

  static const Color _muted = Color(0xff90958E);

  @override
  Widget build(BuildContext context) {
    return Text(
      _formatDate(createdAt),
      style: const TextStyle(
        color: _muted,
        fontSize: 11.5,
        fontWeight: FontWeight.w500,
        letterSpacing: -0.05,
      ),
    );
  }

  String _formatDate(String? date) {
    if (date == null || date.isEmpty) {
      return 'Recently';
    }

    final parsedDate = DateTime.tryParse(date);

    if (parsedDate == null) {
      return 'Recently';
    }

    return timeago.format(parsedDate.toLocal(), locale: 'en');
  }
}

class HistoryCloseButtonWidget extends StatelessWidget {
  const HistoryCloseButtonWidget({super.key, required this.onPressed});

  final VoidCallback onPressed;

  static const Color _background = Color(0xffF1F2EF);

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      borderRadius: BorderRadius.circular(12),
      child: Container(
        width: 36,
        height: 36,
        decoration: BoxDecoration(
          color: _background,
          borderRadius: BorderRadius.circular(12),
        ),
        child: IconButton(
          onPressed: onPressed,
          padding: EdgeInsets.zero,
          splashRadius: 18,
          tooltip: 'Remove from history',
          icon: const HugeIcon(
            icon: HugeIcons.strokeRoundedCancel01,
            size: 17,
            color: ColorConst.primaryGreen,
          ),
        ),
      ),
    );
  }
}

class HistoryLoadingWidget extends StatelessWidget {
  const HistoryLoadingWidget({super.key});

  static const Color _limeDark = Color(0xff769E00);

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: SizedBox(
        width: 25,
        height: 25,
        child: CircularProgressIndicator(strokeWidth: 2.2, color: _limeDark),
      ),
    );
  }
}

class HistoryPaginationLoader extends StatelessWidget {
  const HistoryPaginationLoader({super.key});

  static const Color _limeDark = Color(0xff769E00);

  @override
  Widget build(BuildContext context) {
    return const Padding(
      padding: EdgeInsets.symmetric(vertical: 22),
      child: Center(
        child: SizedBox(
          width: 21,
          height: 21,
          child: CircularProgressIndicator(strokeWidth: 2, color: _limeDark),
        ),
      ),
    );
  }
}
