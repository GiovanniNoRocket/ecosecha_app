import 'package:ecosecha_app/components/drawer/bottom_user_info.dart';
import 'package:ecosecha_app/components/drawer/header.dart';
import 'package:ecosecha_app/components/items/custom_list_tile.dart';
import 'package:ecosecha_app/views/historial.dart';
import 'package:ecosecha_app/views/home_owner.dart';
import 'package:ecosecha_app/views/notification.dart';
import 'package:ecosecha_app/views/order_view.dart';
import 'package:flutter/material.dart';

class CustomDrawerOwner extends StatefulWidget {
  const CustomDrawerOwner({super.key});

  @override
  State<CustomDrawerOwner> createState() => _CustomDrawerOwnerState();
}

class _CustomDrawerOwnerState extends State<CustomDrawerOwner> {
  bool _isCollapsed = false;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: AnimatedContainer(
        curve: Curves.easeInOutCubic,
        duration: const Duration(milliseconds: 500),
        width: _isCollapsed ? 300 : 70,
        margin: const EdgeInsets.only(bottom: 10, top: 10),
        decoration: const BoxDecoration(
          borderRadius: BorderRadius.only(
            bottomRight: Radius.circular(10),
            topRight: Radius.circular(10),
          ),
          color: Color.fromRGBO(20, 20, 20, 1),
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              CustomDrawerHeader(isColapsed: _isCollapsed),
              const Divider(
                color: Colors.grey,
              ),
              CustomListTile(
                isCollapsed: _isCollapsed,
                icon: Icons.home_outlined,
                title: 'Inicio',
                infoCount: 0,
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const HomeScreenOwner()));
                },
              ),
              CustomListTile(
                isCollapsed: _isCollapsed,
                icon: Icons.shopping_cart_rounded,
                title: 'Órdenes',
                infoCount: 0,
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const OrderView()));
                },
              ),
              CustomListTile(
                isCollapsed: _isCollapsed,
                icon: Icons.pin_drop,
                title: 'Destinos',
                infoCount: 0,
                doHaveMoreOptions: Icons.arrow_forward_ios,
                onTap: () {},
              ),
              CustomListTile(
                isCollapsed: _isCollapsed,
                icon: Icons.message_rounded,
                title: 'Mensajes',
                infoCount: 8,
                onTap: () {},
              ),
              CustomListTile(
                isCollapsed: _isCollapsed,
                icon: Icons.history_sharp,
                title: 'Historial',
                infoCount: 0,
                //doHaveMoreOptions: Icons.arrow_forward_ios,
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => HistorialView()));
                },
              ),
              const Divider(color: Colors.grey),
              const Spacer(),
              CustomListTile(
                isCollapsed: _isCollapsed,
                icon: Icons.notifications,
                title: 'Notificaciones',
                infoCount: 0,
                onTap: () {Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const NotificationPage()));},
              ),
              CustomListTile(
                isCollapsed: _isCollapsed,
                icon: Icons.settings,
                title: 'Configuración',
                infoCount: 0,
                onTap: () {},
              ),
              const SizedBox(height: 10),
              BottomUserInfo(
                isCollapsed: _isCollapsed,
              ),
              Align(
                alignment: _isCollapsed
                    ? Alignment.bottomRight
                    : Alignment.bottomCenter,
                child: IconButton(
                  splashColor: Colors.transparent,
                  icon: Icon(
                    _isCollapsed
                        ? Icons.arrow_back_ios
                        : Icons.arrow_forward_ios,
                    color: Colors.white,
                    size: 16,
                  ),
                  onPressed: () {
                    setState(() {
                      _isCollapsed = !_isCollapsed;
                    });
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
