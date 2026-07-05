import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../cubit/profile/profile_cubit.dart';
import '../../../cubit/profile/profile_state.dart';


import '../../../data/services/profile/profile_services.dart';
import '../../widget/Home/custom_app_bar.dart';
import '../../widget/Home/profile_completion_card.dart';
import '../../widget/Home/stories_section.dart';

import '../../widget/Home/feed_post_card.dart';
import '../../widget/Home/custom_bottom_nav_bar.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(

        create: (context) => ProfileCubit(ProfileServices())..fetchProfile(),
        child: Scaffold(
      backgroundColor: const Color(0xFFF8F9FA),
      appBar: const CustomAppBar(),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 16),
              BlocBuilder<ProfileCubit, ProfileState>(
                builder: (context, state) {
                  String currentPercentage = "0%";
                  if (state is ProfileLoaded) {
                    currentPercentage = state.profileModel.profileCompletion ?? "0%";
                  }
                  return ProfileCompletionCard(completionText: currentPercentage);
                },
              ),
              const SizedBox(height: 24),
              const StoriesSection(),
              const SizedBox(height: 24),

              const SizedBox(height: 24),
              const FeedPostCard(
                name: 'Ahmed Saadi',
                handle: '@ahmad_dev',
                time: '2h ago',
                content: 'Finished building my new Laravel API architecture 🚀\nPerformance is 3x better than before.',
                isCodePost: true,
                likes: '54',
                comments: '12',
                reposts: '5',
              ),
              const FeedPostCard(
                name: 'Ahmed Saadi',
                handle: '@ahmad_dev',
                time: 'Yesterday',
                content: 'Working on a new SaaS idea.\nExcited to build something impactful! 💡',
                isCodePost: false,
                likes: '78',
                comments: '21',
                reposts: '7',
              ),
              const SizedBox(height: 120),
            ],
          ),
        ),
      ),
      bottomNavigationBar: const CustomBottomNavBar(),));
  }
}