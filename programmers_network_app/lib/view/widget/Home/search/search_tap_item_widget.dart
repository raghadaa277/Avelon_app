import 'package:flutter/material.dart';
import 'package:programmers_network_app/core/const/color_const.dart';

class SearchTabItem {
  final String label;
  final String apiType;

  const SearchTabItem({required this.label, required this.apiType});
}

class SearchTabsWidget extends StatelessWidget {
  static const List<SearchTabItem> tabs = [
    SearchTabItem(label: "Users", apiType: "user"),
    SearchTabItem(label: "Articles", apiType: "article"),
    SearchTabItem(label: "Problem", apiType: "problem"),
    SearchTabItem(label: "Question", apiType: "question"),
    SearchTabItem(label: "Project", apiType: "project"),
    SearchTabItem(label: "Poll", apiType: "poll"),
  ];
  final int selectedIndex;
  final ValueChanged<int> onTabSelected;

  const SearchTabsWidget({
    super.key,
    required this.selectedIndex,
    required this.onTabSelected,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(20, 18, 20, 8),
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Row(
          children: List.generate(tabs.length, (index) {
            final bool isActive = selectedIndex == index;
            return Padding(
              padding: const EdgeInsets.only(right: 8),
              child: GestureDetector(
                onTap: () => onTabSelected(index),
                child: Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 18,
                    vertical: 10,
                  ),
                  decoration: BoxDecoration(
                    color: isActive ? ColorConst.colorApp : Colors.white,
                    borderRadius: BorderRadius.circular(30),
                    border: Border.all(
                      color: isActive
                          ? ColorConst.colorApp
                          : Colors.grey.shade300,
                    ),
                  ),
                  child: Text(
                    tabs[index].label,
                    style: TextStyle(
                      color: isActive ? Colors.black : Colors.grey.shade600,
                      fontWeight: isActive ? FontWeight.w700 : FontWeight.w500,
                      fontSize: 13.5,
                    ),
                  ),
                ),
              ),
            );
          }),
        ),
      ),
    );
  }
}
