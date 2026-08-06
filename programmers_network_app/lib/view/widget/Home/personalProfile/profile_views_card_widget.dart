import 'package:flutter/material.dart';
import 'package:hugeicons/hugeicons.dart';
import '../../../../../../data/models/Home/personalPage/mutualFollowers/get_connection_analysis_model.dart';

class ProfileViewsCard extends StatelessWidget {
  final ProfileViewsConnectionModel data;

  const ProfileViewsCard({super.key, required this.data});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),

      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(25),

        border: Border.all(color: Colors.grey.shade200),
      ),

      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,

        children: [
          Row(
            children: [
              Container(
                padding: const EdgeInsets.all(10),

                decoration: BoxDecoration(
                  color: Colors.blue.withOpacity(.1),
                  borderRadius: BorderRadius.circular(12),
                ),

                child: const HugeIcon(
                  icon: HugeIcons.strokeRoundedView,
                  color: Colors.blue,
                  size: 22,
                ),
              ),

              const SizedBox(width: 12),

              const Text(
                "Profile Views",

                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),

              const Spacer(),

              Icon(Icons.info_outline, color: Colors.grey.shade400),
            ],
          ),

          const SizedBox(height: 25),

          Row(
            children: [
              Expanded(
                child: _ProfileViewItem(
                  title: "You visited him",
                  count: data.iVisitedHim,
                  color: Colors.blue,
                  iconBackground: Colors.blue,
                ),
              ),
              SizedBox(width: 10),
              Container(height: 80, width: 1, color: Colors.grey.shade300),
              SizedBox(width: 10),
              Expanded(
                child: _ProfileViewItem(
                  title: "He visited you",
                  count: data.heVisitedMe,
                  color: Colors.deepPurple,
                  iconBackground: Colors.deepPurple,
                ),
              ),
            ],
          ),

          const SizedBox(height: 20),

          Container(
            width: double.infinity,

            padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 12),

            decoration: BoxDecoration(
              color: Colors.blue.withOpacity(.05),

              borderRadius: BorderRadius.circular(12),
            ),

            child: Row(
              children: [
                Container(
                  width: 8,
                  height: 8,
                  decoration: const BoxDecoration(
                    color: Colors.blue,
                    shape: BoxShape.circle,
                  ),
                ),

                const SizedBox(width: 10),

                const Expanded(
                  child: Text(
                    "People who visited each other's profiles",
                    style: TextStyle(fontSize: 13),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _ProfileViewItem extends StatelessWidget {
  final String title;
  final int count;
  final Color color;
  final Color iconBackground;

  const _ProfileViewItem({
    required this.title,
    required this.count,
    required this.color,
    required this.iconBackground,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(
                  color: color,
                  fontWeight: FontWeight.w600,
                  fontSize: 13,
                ),
              ),

              const SizedBox(height: 8),

              Text(
                "$count",
                style: TextStyle(
                  fontSize: 40,
                  fontWeight: FontWeight.bold,
                  color: color,
                ),
              ),

              Text(
                count == 0 ? "0%" : "100%",
                style: TextStyle(color: color, fontWeight: FontWeight.bold),
              ),
            ],
          ),
        ),

        const SizedBox(width: 8),

        Container(
          padding: const EdgeInsets.all(2),

          decoration: BoxDecoration(
            color: iconBackground.withOpacity(.1),
            shape: BoxShape.circle,
          ),

          child: Icon(Icons.person_outline, color: color, size: 23),
        ),
      ],
    );
  }
}
