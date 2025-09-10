import 'package:flutter/material.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  final TextEditingController _searchController = TextEditingController();
  String _searchQuery = '';
  bool isSearching = false;

  final List<CategoryItem> categories = [
    CategoryItem(
      title: 'Education',
      icon: Icons.school,
      color: Colors.green,
    ),
    CategoryItem(
      title: 'Santé',
      icon: Icons.health_and_safety,
      color: Colors.green,
    ),
    CategoryItem(
      title: 'Charité',
      icon: Icons.volunteer_activism,
      color: Colors.green,
    ),
    CategoryItem(
      title: 'Communauté',
      icon: Icons.school,
      color: Colors.green,
    ),
    CategoryItem(
      title: 'Sport',
      icon: Icons.sports_basketball,
      color: Colors.green,
    ),
    CategoryItem(
      title: 'Désastre',
      icon: Icons.warning,
      color: Colors.green,
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _buildAppBar(),
      body: _buildBody(),
    );
  }

  PreferredSizeWidget _buildAppBar() {
    return AppBar(
      elevation: 0,
      backgroundColor: Colors.white,
      automaticallyImplyLeading: false,
      toolbarHeight: 80,
      flexibleSpace: SafeArea(
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
          child: Row(
            children: [
              // Barre de recherche intégrée
              Expanded(
                child: Container(
                  height: 48,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(24),
                    color: Colors.grey[100],
                    border: Border.all(
                      color: isSearching ? Colors.green : Colors.grey[300]!,
                      width: isSearching ? 2 : 1,
                    ),
                  ),
                  child: TextField(
                    controller: _searchController,
                    onTap: () {
                      setState(() {
                        isSearching = true;
                      });
                    },
                    onChanged: (value) {
                      setState(() {
                        _searchQuery = value;
                      });
                    },
                    onSubmitted: (value) {
                      setState(() {
                        isSearching = false;
                      });
                      // Logique de recherche ici
                      _performSearch(value);
                    },
                    decoration: InputDecoration(
                      hintText: 'Rechercher des projets...',
                      hintStyle: TextStyle(
                        color: Colors.grey[500],
                        fontSize: 15,
                      ),
                      border: InputBorder.none,
                      contentPadding: EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                      prefixIcon: Icon(
                        Icons.search,
                        color: isSearching ? Colors.green : Colors.grey[400],
                        size: 22,
                      ),
                      suffixIcon: _searchQuery.isNotEmpty
                          ? IconButton(
                              onPressed: () {
                                setState(() {
                                  _searchController.clear();
                                  _searchQuery = '';
                                  isSearching = false;
                                });
                              },
                              icon: Icon(
                                Icons.clear,
                                color: Colors.grey[400],
                                size: 20,
                              ),
                            )
                          : null,
                    ),
                    style: TextStyle(
                      fontSize: 15,
                      color: Colors.black87,
                    ),
                  ),
                ),
              ),
              // Bouton filtre optionnel
              Container(
                margin: EdgeInsets.only(left: 12),
                decoration: BoxDecoration(
                  color: Colors.green,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Material(
                  color: Colors.transparent,
                  child: InkWell(
                    onTap: () {
                      // Ouvrir les filtres
                      _showFilterDialog();
                    },
                    borderRadius: BorderRadius.circular(12),
                    child: Container(
                      padding: EdgeInsets.all(12),
                      child: Icon(
                        Icons.tune,
                        color: Colors.white,
                        size: 20,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildBody() {
    return Column(
      children: [
        // Section titre et statistiques
        Container(
          padding: EdgeInsets.all(20),
          decoration: BoxDecoration(
            color: Colors.white,
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.05),
                blurRadius: 10,
                offset: Offset(0, 2),
              ),
            ],
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Catégories de projets',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Colors.grey[800],
                ),
              ),
              SizedBox(height: 8),
              Row(
                children: [
                  Icon(
                    Icons.category,
                    size: 16,
                    color: Colors.grey[500],
                  ),
                  SizedBox(width: 4,),
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 12, vertical: 4),
                    decoration: BoxDecoration(
                      color: Colors.green[50],
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Text(
                      '1,234 projets actifs',
                      style: TextStyle(
                        fontSize: 12,
                        color: Colors.green[700],
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
        // Grille des catégories
        Expanded(
          child: _buildCategoriesGrid(),
        ),
      ],
    );
  }

  Widget _buildCategoriesGrid() {
    return Container(
      padding: EdgeInsets.all(20),
      child: GridView.builder(
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          crossAxisSpacing: 16,
          mainAxisSpacing: 16,
          childAspectRatio: 1,
        ),
        itemCount: categories.length,
        itemBuilder: (context, index) {
          return _buildCategoryCard(categories[index], index);
        },
      ),
    );
  }

  Widget _buildCategoryCard(CategoryItem category, int index) {
    return GestureDetector(
      onTap: () {
        print('Tapped on ${category.title}');
        _navigateToCategory(category);
      },
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(20),
          border: Border.all(
            color: Colors.green.withOpacity(0.3),
            width: 1.5,
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.08),
              offset: Offset(0, 4),
              blurRadius: 15,
              spreadRadius: 0,
            ),
          ],
        ),
        child: Stack(
          children: [
            // Gradient de fond subtil
            Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: [
                    Colors.green.withOpacity(0.02),
                    Colors.white,
                  ],
                ),
              ),
            ),
            // Accent coloré en haut
            Positioned(
              top: 0,
              left: 0,
              right: 0,
              child: Container(
                height: 4,
                decoration: BoxDecoration(
                  color: Colors.green,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(20),
                    topRight: Radius.circular(20),
                  ),
                ),
              ),
            ),
            // Contenu principal
            Padding(
              padding: EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              category.title,
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                                color: Colors.grey[800],
                              ),
                            ),
                            SizedBox(height: 4),
                            Text(
                              _getCategoryDescription(category.title),
                              style: TextStyle(
                                fontSize: 11,
                                color: Colors.grey[500],
                                height: 1.3
                              ),
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ],
                        ),
                      ),
                      SizedBox(width: 8,),
                      Container(
                        padding: EdgeInsets.all(8),
                        decoration: BoxDecoration(
                          color: Colors.green.withOpacity(0.1),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: _buildCategoryIcon(category),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            // Badge de nombre de projets
            Positioned(
              bottom: 12,
              right: 12,
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                decoration: BoxDecoration(
                  color: Colors.grey[100],
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Text(
                  '${_getProjectCount(index)} projets',
                  style: TextStyle(
                    fontSize: 10,
                    color: Colors.grey[600],
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

Widget _buildCategoryIcon(CategoryItem category) {
    Widget iconWidget;
    
    switch (category.title.toLowerCase()) {
      case 'education':
        iconWidget = _buildEducationIcon();
        break;
      case 'santé':
        iconWidget = _buildHealthIcon();
        break;
      case 'charité':
        iconWidget = _buildCharityIcon();
        break;
      case 'communauté':
        iconWidget = _buildCommunityIcon();
        break;
      case 'sport':
        iconWidget = _buildSportIcon();
        break;
      case 'désastre':
        iconWidget = _buildDisasterIcon();
        break;
      default:
        iconWidget = Icon(category.icon, color: Colors.green, size: 24);
    }
    
    return SizedBox(
      width: 40,
      height: 40,
      child: iconWidget,
    );
  }

  Widget _buildEducationIcon() {
    return Icon(Icons.school, color: Colors.green, size: 24);
  }

  Widget _buildHealthIcon() {
    return Icon(Icons.health_and_safety, color: Colors.green, size: 24);
  }

  Widget _buildCharityIcon() {
    return Icon(Icons.volunteer_activism, color: Colors.green, size: 24);
  }

  Widget _buildCommunityIcon() {
    return Icon(Icons.groups, color: Colors.green, size: 24);
  }

  Widget _buildSportIcon() {
    return Icon(Icons.sports_basketball, color: Colors.green, size: 24);
  }

  Widget _buildDisasterIcon() {
    return Icon(Icons.warning, color: Colors.green, size: 24);
  }

  String _getCategoryDescription(String title) {
    switch (title.toLowerCase()) {
      case 'education':
        return 'Écoles, formations, bourses d\'études';
      case 'santé':
        return 'Hôpitaux, soins, équipements médicaux';
      case 'charité':
        return 'Aide alimentaire, vêtements, urgence';
      case 'communauté':
        return 'Centres communautaires, infrastructures';
      case 'sport':
        return 'Terrains, équipements, clubs sportifs';
      case 'désastre':
        return 'Aide d\'urgence, reconstruction';
      default:
        return 'Projets de développement';
    }
  }

  int _getProjectCount(int index) {
    // Simulation de données
    List<int> counts = [87, 64, 152, 43, 29, 18];
    return counts[index % counts.length];
  }

  void _performSearch(String query) {
    print('Recherche: $query');
    // Implémenter la logique de recherche
  }

  void _navigateToCategory(CategoryItem category) {
    // Navigation vers la page de catégorie
    print('Navigation vers ${category.title}');
  }

  void _showFilterDialog() {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      builder: (context) => Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
        ),
        padding: EdgeInsets.all(20),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Filtres',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 20),
            ListTile(
              leading: Icon(Icons.sort),
              title: Text('Trier par popularité'),
              onTap: () => Navigator.pop(context),
            ),
            ListTile(
              leading: Icon(Icons.location_on),
              title: Text('Projets locaux'),
              onTap: () => Navigator.pop(context),
            ),
            ListTile(
              leading: Icon(Icons.trending_up),
              title: Text('Projets tendances'),
              onTap: () => Navigator.pop(context),
            ),
            SizedBox(height: 20),
          ],
        ),
      ),
    );
  }
}

class CategoryItem {
  final String title;
  final IconData icon;
  final Color color;

  CategoryItem({
    required this.title,
    required this.icon,
    required this.color,
  });
}

// Widget séparé pour les résultats de recherche
class SearchResultCard extends StatelessWidget {
  final String title;
  final String amount;
  final String imagePath;
  final double progress;

  const SearchResultCard({
    super.key,
    required this.title,
    required this.amount,
    required this.imagePath,
    required this.progress,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 20, vertical: 8),
      padding: EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.1),
            spreadRadius: 1,
            blurRadius: 8,
            offset: Offset(0, 2),
          ),
        ],
      ),
      child: Row(
        children: [
          // Image
          Container(
            width: 60,
            height: 60,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12),
              image: DecorationImage(
                image: AssetImage(imagePath),
                fit: BoxFit.cover,
              ),
            ),
          ),
          SizedBox(width: 16),
          // Contenu
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                    color: Colors.black87,
                  ),
                ),
                SizedBox(height: 4),
                Text(
                  amount,
                  style: TextStyle(
                    fontSize: 14,
                    color: Colors.grey[600],
                  ),
                ),
                SizedBox(height: 8),
                // Barre de progression
                Container(
                  height: 6,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(3),
                    color: Colors.grey[200],
                  ),
                  child: Row(
                    children: [
                      Expanded(
                        flex: (progress * 100).toInt(),
                        child: Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(3),
                            color: Colors.orange,
                          ),
                        ),
                      ),
                      Expanded(
                        flex: ((1 - progress) * 100).toInt(),
                        child: Container(),
                      ),
                    ],
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