import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hogwarts_sorting_hat/app_colors.dart';
import 'package:hogwarts_sorting_hat/feature/home/cubit/home_cubit.dart';
import 'package:hogwarts_sorting_hat/feature/home/home_tab.dart';
import 'package:hogwarts_sorting_hat/feature/home/list_tab.dart';
import 'package:pull_to_refresh_flutter3/pull_to_refresh_flutter3.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key, this.initialIndex = 0});

  final int initialIndex;

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  late RefreshController _refreshController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
    _tabController.index = widget.initialIndex;
    _tabController.addListener(() {
      setState(() {});
    });
    _refreshController = RefreshController();
    context.read<HomeCubit>().getRandomCharacter();
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HomeCubit, HomeState>(
      builder: (context, state) {
        return Scaffold(
          appBar: AppBar(
            bottom: PreferredSize(
                preferredSize: const Size.fromHeight(4.0),
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20.0),
                  child: Container(
                    color: Colors.black,
                    height: 2,
                  ),
                )),
            backgroundColor: AppColors.backgroundPrimary,
            title: Text(
              _tabController.index == 0 ? 'Home Screen' : 'List Screen',
              style: const TextStyle(fontWeight: FontWeight.w600),
            ),
            centerTitle: true,
            actions: [
              TextButton(
                onPressed: () => context.read<HomeCubit>().reset(),
                style: TextButton.styleFrom(
                  foregroundColor: Colors.grey,
                ),
                child: const Text('Reset',
                    style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.w400,
                        color: AppColors.textPrimaryColor)),
              ),
            ],
          ),
          body: state.status == HomeStatus.failure
              ? const Icon(Icons.error_outline)
              : Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: TabBarView(
                    physics: const NeverScrollableScrollPhysics(),
                    controller: _tabController,
                    children: [
                      SmartRefresher(
                        physics: const BouncingScrollPhysics(),
                        enablePullDown: true,
                        enablePullUp: false,
                        controller: _refreshController,
                        onRefresh: () async {
                          await context.read<HomeCubit>().getRandomCharacter();
                          _refreshController.refreshCompleted();
                        },
                        child: HomeTab(
                          onHouseTap: (house) {
                            context.read<HomeCubit>().attempt(house);
                          },
                          totalSuccessAttempts: state.totalSuccessAttempts,
                          totalFailedAttempts: state.totalFailedAttempts,
                          character: state.character,
                        ),
                      ),
                      ListTab(
                        onReload: () => _tabController.animateTo(0),
                        characters: state.filteredCharacters,
                        totalSuccessAttempts: state.totalSuccessAttempts,
                        totalFailedAttempts: state.totalFailedAttempts,
                      ),
                    ],
                  ),
                ),
          bottomNavigationBar: SafeArea(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20.0),
                  child: Container(
                    color: Colors.black,
                    height: 2,
                  ),
                ),
                TabBar(
                  unselectedLabelColor: Colors.grey,
                  labelColor: AppColors.textPrimaryColor,
                  overlayColor: WidgetStateProperty.all(Colors.grey.shade200),
                  controller: _tabController,
                  dividerHeight: 0,
                  indicator: const BoxDecoration(
                    color: AppColors.backgroundPrimary,
                  ),
                  tabs: const [
                    Tab(
                      icon: Icon(Icons.house, size: 38),
                      text: 'Home',
                    ),
                    Tab(
                      icon: Icon(Icons.list, size: 38),
                      text: 'List',
                    ),
                  ],
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
