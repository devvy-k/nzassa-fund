import 'package:flutter/material.dart';

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({super.key});

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
      'Tableau de bord',
      style: TextStyle(
        fontSize: 24,
        fontWeight: FontWeight.w600,
      ),
    ),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Navigation Tabs
                _buildNavigationTabs(),
                SizedBox(height: 30),
                
                // Statistics Cards
                _buildStatisticsGrid(),
                SizedBox(height: 30),
                
                // Live Quiz Section
                _buildLiveQuizSection(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildNavigationTabs() {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        children: [
          _buildTabItem(Icons.people_outline, 'Communauté', false),
          SizedBox(width: 20),
          _buildTabItem(Icons.military_tech_outlined, 'Accomplissements', true),
        ],
      ),
    );
  }

  Widget _buildTabItem(IconData icon, String label, bool isActive) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      decoration: BoxDecoration(
        color: isActive ? Color(0xFF6B4C93).withOpacity(0.1) : Colors.transparent,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            icon,
            size: 20,
            color: isActive ? Color(0xFF6B4C93) : Colors.grey[600],
          ),
          SizedBox(width: 8),
          Text(
            label,
            style: TextStyle(
              color: isActive ? Color(0xFF6B4C93) : Colors.grey[600],
              fontWeight: isActive ? FontWeight.w500 : FontWeight.w400,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildStatisticsGrid() {
    return GridView.count(
      shrinkWrap: true,
      physics: NeverScrollableScrollPhysics(),
      crossAxisCount: 2,
      crossAxisSpacing: 15,
      mainAxisSpacing: 15,
      childAspectRatio: 1.2,
      children: [
        _buildStatCard('12', 'Collectes lancées'),
        _buildStatCard('24', 'Collectes réussies'),
        _buildStatCard('120', 'Projets réalisés'),
        _buildStatCard('12', 'Projets en cours'),
      ],
    );
  }

Widget _buildStatCard(String number, String label, {VoidCallback? onTap}) {
  return Material(
    color: Theme.of(context).colorScheme.surface,
    elevation: 4,
    shadowColor: Colors.black.withOpacity(0.1),
    borderRadius: BorderRadius.circular(16),
    child: InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(16),
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 24, horizontal: 10),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              number,
              style: Theme.of(context).textTheme.headlineLarge?.copyWith(
                    fontSize: 28,
                    fontWeight: FontWeight.w700,
                    color: Theme.of(context).colorScheme.primary,
                  ),
            ),
            const SizedBox(height: 8),
            Text(
              label,
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    fontSize: 13,
                    color: Theme.of(context).colorScheme.onSurface.withOpacity(0.7),
                  ),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    ),
  );
}


  Widget _buildLiveQuizSection() {
    return Container(
      padding: EdgeInsets.all(20),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.02),
            blurRadius: 10,
            offset: Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                width: 8,
                height: 8,
                decoration: BoxDecoration(
                  color: Colors.green,
                  shape: BoxShape.circle,
                ),
              ),
              SizedBox(width: 8),
              Text(
                'Dernière collecte lancée',
                style: TextStyle(
                  color: Colors.green,
                  fontSize: 12,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
          SizedBox(height: 12),
          
          Text(
            'Construction d\'une école à Taabo',
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w600,
            ),
          ),
          SizedBox(height: 8),
          
          Text(
            'Objectifs: 70.000.000 FCFA',
            style: TextStyle(
              fontSize: 14,
              color: Colors.grey[600],
              fontWeight: FontWeight.w500
            ),
          ),
          SizedBox(height: 4),
          
          Text(
            'Collecté: 45.000.000 FCFA',
            style: TextStyle(
              fontSize: 14,
              color: Colors.grey[600],
              fontWeight: FontWeight.w500
            ),
          ),
          SizedBox(height: 20),
          
          Row(
            children: [
              Expanded(
                child: ElevatedButton(
                  onPressed: () {},
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Color(0xFF6B4C93),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                    elevation: 0,
                    padding: EdgeInsets.symmetric(vertical: 12),
                  ),
                  child: Text(
                    'Statistiques',
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
              ),
              SizedBox(width: 10),
              
            ],
          ),
        ],
      ),
    );
  }
}