import 'package:flutter/material.dart';
import '../pages/inicio_page.dart';
import '../pages/productos_page.dart';
import '../pages/solicitudes_page.dart';
import '../pages/perfil_page.dart';

class MenuDestination {
  const MenuDestination(this.label, this.icon, this.selectedIcon);
  final String label;
  final Widget icon;
  final Widget selectedIcon;
}

const List<MenuDestination> destinations = <MenuDestination>[
  MenuDestination('Inicio', Icon(Icons.home_outlined), Icon(Icons.home)),
  MenuDestination('Mis productos', Icon(Icons.account_balance_wallet_outlined),
      Icon(Icons.account_balance_wallet)),
  MenuDestination('Solicitudes', Icon(Icons.account_balance_outlined),
      Icon(Icons.account_balance)),
  MenuDestination('Perfil', Icon(Icons.person_outline), Icon(Icons.person)),
];

class MainLayout extends StatefulWidget {
  const MainLayout({super.key});

  @override
  State<MainLayout> createState() => _MainLayoutState();
}

class _MainLayoutState extends State<MainLayout> {
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();
  int screenIndex = 0;
  late bool showNavigationDrawer;

  final List<Widget> _pages = [
    const InicioPage(),
    const ProductosPage(),
    const SolicitudesPage(),
    const PerfilPage(),
  ];

  void handleScreenChanged(int selectedScreen) {
    setState(() {
      screenIndex = selectedScreen;
    });
  }

  void openDrawer() {
    scaffoldKey.currentState!.openEndDrawer();
  }

  PreferredSizeWidget _buildAppBar() {
    return AppBar(
      backgroundColor: Colors.white,
      bottom: PreferredSize(
        preferredSize: const Size.fromHeight(12),
        child: Container(
          color: Colors.grey.shade200,
          height: 2,
        ),
      ),
      leading: Icon(
        Icons.account_balance,
        color: Colors.yellow.shade600,
        size: 40,
      ),
      title: Text(
        'Banco\nPichincha',
        style: TextStyle(
          color: Colors.indigo.shade600,
          fontWeight: FontWeight.bold,
        ),
      ),
      actions: [
        IconButton(
          onPressed: () {},
          icon: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(Icons.help_outline, color: Colors.indigo.shade600, size: 20),
              const SizedBox(width: 5),
              Text('Ayuda',
                  style:
                      TextStyle(color: Colors.indigo.shade600, fontSize: 12)),
            ],
          ),
        ),
        if (showNavigationDrawer)
          IconButton(
            onPressed: openDrawer,
            icon: const Icon(Icons.menu, color: Colors.indigo),
          ),
      ],
    );
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    showNavigationDrawer = MediaQuery.of(context).size.width >= 450;
  }

  @override
  Widget build(BuildContext context) {
    return _buildBottomBarScaffold();
  }

  Widget _buildBottomBarScaffold() {
    return Scaffold(
      appBar: _buildAppBar(),
      body: _pages[screenIndex],
      bottomNavigationBar: Container(
        decoration: BoxDecoration(
          border: Border(
            top: BorderSide(
              color: Colors.grey.shade300,
              width: 2,
            ),
          ),
        ),
        child: NavigationBar(
          backgroundColor: Colors.white,
          selectedIndex: screenIndex,
          onDestinationSelected: handleScreenChanged,
          destinations: destinations.map(
            (MenuDestination destination) {
              return NavigationDestination(
                label: destination.label,
                icon: destination.icon,
                selectedIcon: destination.selectedIcon,
              );
            },
          ).toList(),
        ),
      ),
    );
  }
}
