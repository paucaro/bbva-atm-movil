import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:dashrock/api_client/atm/atm_api.dart';
import 'package:dashrock/api_client/network/entity/atm_request.dart';
import 'package:dashrock/bloc/atm/atm_bloc.dart';
import 'package:dashrock/constants/global_constants.dart';
import 'package:dashrock/repository/atm_repository.dart';
import 'package:dashrock/ui/views/chat_page.dart';
import 'package:dashrock/ui/views/info_page.dart';
import 'package:dashrock/ui/views/map_page.dart';
import 'package:dio/dio.dart' as dio;
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class BottomNavBar extends StatefulWidget {
  const BottomNavBar({super.key});

  @override
  State<BottomNavBar> createState() => _BottomNavBarState();
}

class _BottomNavBarState extends State<BottomNavBar> {
  // Pages
  final ChatPage _chatPage = const ChatPage();
  final MapPage _mapPage = const MapPage();
  final InfoPage _infoPage = const InfoPage();

  Widget _showPage = const ChatPage();

  Widget _pageChooser(int page) {
    switch (page) {
      case 0:
        return _chatPage;
      case 1:
        return _mapPage;
      case 2:
        return _infoPage;
      default:
        return _chatPage;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: Container(
        color: Colors.orangeAccent,
        height: 80,
        padding: const EdgeInsets.all(8),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(50),
          child: CurvedNavigationBar(
            height: 50,
            backgroundColor: Colors.white,
            color: Colors.white,
            buttonBackgroundColor: Colors.grey.shade300,
            animationDuration: const Duration(milliseconds: 500),
            animationCurve: Curves.easeInOut,
            onTap: (int tappedIndex) {
              setState(() {
                _showPage = _pageChooser(tappedIndex);
              });
            },
            items: const [
              Icon(Icons.chat_bubble),
              Icon(Icons.location_on),
              Icon(Icons.info_rounded),
            ],
          ),
        ),
      ),
      body: BlocProvider<AtmBloc>(
        create: (_) => AtmBloc(
          atmRepository: AtmRepository(atmApi: AtmApi(dio.Dio())),
        )..add(AtmFetched(
            request: AtmRequest(16.77, -93.15, fecha, radio),
          )),
        child: Container(
          color: Colors.black12,
          child: Center(child: _showPage),
        ),
      ),
    );
  }
}
