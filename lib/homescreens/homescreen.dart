import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:untitled4/cubits/home_cubit.dart';
import 'package:untitled4/cubits/home_state.dart';
import 'package:untitled4/cubits/profile.dart';
import 'package:untitled4/homescreens/profilescreen.dart';
import 'package:untitled4/itemwid.dart';

import 'gridview.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context) {
        return HomeCubit()..getCategoriseFromDatabase();
      },
      child: Scaffold(
        backgroundColor: Colors.white,
        body: BlocBuilder<HomeCubit, HomeState>(
          builder: (context, state) {
            if (state is HomeLoading) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            } else if (state is HomeError) {
              return Center(
                child: Text(state.message),
              );
            } else if (state is HomeLoaded) {
              return Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: Column(
                  children: [
                    const Row(
                      children: [
                        Text(
                          'New Categories',
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    if (context.read<HomeCubit>().categorise.isEmpty)
                      const Center(
                        child: Text('No Data'),
                      )
                    else
                      Expanded(
                        child: ListView.builder(
                          itemCount: context.read<HomeCubit>().categorise.length,
                          itemBuilder: (context, index) {
                            return ItemWidget(
                              image: context
                                  .read<HomeCubit>()
                                  .categorise[index]
                                  .image!,
                              name: context
                                  .read<HomeCubit>()
                                  .categorise[index]
                                  .name,
                            );
                          },
                        ),
                      ),
                  ],
                ),
              );
            } else {
              return const SizedBox();
            }
          },
        ),
      ),
    );
  }
}
class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int currentIndex = 0;

  List<Widget> screens = [
    const HomeScreen(),
    const GridViewOfProductsScreen(),
    const ProfileScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(providers: [BlocProvider(create: (context) => ProfileCubit()..getUserDataFromFireStoreDataBase(),)],

      child: Scaffold(
          body: screens[currentIndex],
          bottomNavigationBar: BottomNavigationBar(
              backgroundColor: const Color(0xff2D2F41),
              selectedItemColor: Colors.white,
              unselectedItemColor: const Color(0xffa8a8a8),
              currentIndex: currentIndex,
              onTap: (i) {
                currentIndex = i;
                setState(() {});
              },
            items: const [
              BottomNavigationBarItem(
                  icon: Icon(
                    Icons.home,
                  ),
                  label: 'Home'),
              BottomNavigationBarItem(
                  icon: Icon(
                    Icons.shopping_cart,
                  ),
                  label: 'Products'),
              BottomNavigationBarItem(
                  icon: Icon(
                    Icons.person,
                  ),
                  label: 'Profile'),
            ],
          ),
      ),
    );
  }
}