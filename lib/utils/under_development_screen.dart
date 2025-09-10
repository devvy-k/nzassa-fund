import 'package:flutter/material.dart';

class UnderDevelopmentScreen extends StatefulWidget {
  const UnderDevelopmentScreen({super.key});

  @override
  _UnderDevelopmentScreenState createState() => _UnderDevelopmentScreenState();
}

class _UnderDevelopmentScreenState extends State<UnderDevelopmentScreen>
    with TickerProviderStateMixin {
  late AnimationController _rotationController;
  late AnimationController _bounceController;
  late Animation<double> _rotationAnimation;
  late Animation<double> _bounceAnimation;

  @override
  void initState() {
    super.initState();
    
    _rotationController = AnimationController(
      duration: Duration(seconds: 3),
      vsync: this,
    )..repeat();
    
    _bounceController = AnimationController(
      duration: Duration(milliseconds: 2000),
      vsync: this,
    )..repeat(reverse: true);
    
    _rotationAnimation = Tween<double>(
      begin: 0,
      end: 1,
    ).animate(CurvedAnimation(
      parent: _rotationController,
      curve: Curves.linear,
    ));
    
    _bounceAnimation = Tween<double>(
      begin: 0,
      end: 20,
    ).animate(CurvedAnimation(
      parent: _bounceController,
      curve: Curves.elasticInOut,
    ));
  }

  @override
  void dispose() {
    _rotationController.dispose();
    _bounceController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFF8FAFF),
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: _buildContent(),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildContent() {
    return SingleChildScrollView(
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 24),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(height: 40),
            
            // Illustration principale avec animations
            AnimatedBuilder(
              animation: _bounceAnimation,
              builder: (context, child) {
                return Transform.translate(
                  offset: Offset(0, -_bounceAnimation.value),
                  child: _buildMainIllustration(),
                );
              },
            ),
            
            SizedBox(height: 50),
            
            // Titre principal
            Text(
              "En cours de développement",
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 28,
                fontWeight: FontWeight.bold,
                color: Color(0xFF2D3748),
                height: 1.2,
              ),
            ),
            
            SizedBox(height: 16),
            
            // Sous-titre
            Text(
              "Cette fonctionnalité incroyable arrive bientôt !",
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 16,
                color: Color(0xFF718096),
                height: 1.5,
              ),
            ),
            
            SizedBox(height: 40),
            
            // Barre de progression stylée
            _buildProgressSection(),
            
            SizedBox(height: 50),
            
            // Bouton d'action
            _buildActionButton(),
            
            SizedBox(height: 30),
            
            // Informations supplémentaires
            _buildInfoCards(),
            
            SizedBox(height: 40),
          ],
        ),
      ),
    );
  }

  Widget _buildMainIllustration() {
    return Container(
      width: 280,
      height: 200,
      child: Stack(
        alignment: Alignment.center,
        children: [
          // Cercles de fond animés
          AnimatedBuilder(
            animation: _rotationAnimation,
            builder: (context, child) {
              return Transform.rotate(
                angle: _rotationAnimation.value * 2 * 3.14159,
                child: Container(
                  width: 200,
                  height: 200,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    gradient: LinearGradient(
                      colors: [
                        Color(0xFF667EEA).withOpacity(0.1),
                        Color(0xFF764BA2).withOpacity(0.1),
                      ],
                    ),
                  ),
                ),
              );
            },
          ),
          
          // Illustration SVG simulée avec des icônes Flutter
          Container(
            width: 150,
            height: 150,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(20),
              boxShadow: [
                BoxShadow(
                  color: Color(0xFF667EEA).withOpacity(0.2),
                  blurRadius: 30,
                  offset: Offset(0, 10),
                ),
              ],
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                AnimatedBuilder(
                  animation: _rotationController,
                  builder: (context, child) {
                    return Transform.rotate(
                      angle: _rotationAnimation.value * 2 * 3.14159,
                      child: Icon(
                        Icons.settings,
                        size: 50,
                        color: Color(0xFF667EEA),
                      ),
                    );
                  },
                ),
                SizedBox(height: 10),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.code, color: Color(0xFF48BB78), size: 20),
                    SizedBox(width: 8),
                    Icon(Icons.palette, color: Color(0xFFED8936), size: 20),
                    SizedBox(width: 8),
                    Icon(Icons.rocket_launch, color: Color(0xFF9F7AEA), size: 20),
                  ],
                ),
              ],
            ),
          ),
          
          // Points flottants décoratifs
          Positioned(
            top: 20,
            right: 30,
            child: _buildFloatingDot(Color(0xFF48BB78), 8),
          ),
          Positioned(
            bottom: 30,
            left: 40,
            child: _buildFloatingDot(Color(0xFFED8936), 6),
          ),
          Positioned(
            top: 60,
            left: 20,
            child: _buildFloatingDot(Color(0xFF9F7AEA), 10),
          ),
        ],
      ),
    );
  }

  Widget _buildFloatingDot(Color color, double size) {
    return AnimatedBuilder(
      animation: _bounceAnimation,
      builder: (context, child) {
        return Transform.translate(
          offset: Offset(0, _bounceAnimation.value * 0.5),
          child: Container(
            width: size,
            height: size,
            decoration: BoxDecoration(
              color: color,
              shape: BoxShape.circle,
            ),
          ),
        );
      },
    );
  }

  Widget _buildProgressSection() {
    return Container(
      padding: EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 20,
            offset: Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "Progression",
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                  color: Color(0xFF2D3748),
                ),
              ),
              Text(
                "75%",
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF667EEA),
                ),
              ),
            ],
          ),
          SizedBox(height: 12),
          Container(
            height: 6,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(3),
              color: Color(0xFFE2E8F0),
            ),
            child: Row(
              children: [
                Expanded(
                  flex: 75,
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(3),
                      gradient: LinearGradient(
                        colors: [Color(0xFF667EEA), Color(0xFF764BA2)],
                      ),
                    ),
                  ),
                ),
                Expanded(
                  flex: 25,
                  child: Container(),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildActionButton() {
    return Container(
      width: double.infinity,
      height: 56,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [Color(0xFF667EEA), Color(0xFF764BA2)],
          begin: Alignment.centerLeft,
          end: Alignment.centerRight,
        ),
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Color(0xFF667EEA).withOpacity(0.3),
            blurRadius: 20,
            offset: Offset(0, 8),
          ),
        ],
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: () {
            _showNotificationDialog();
          },
          borderRadius: BorderRadius.circular(16),
          child: Center(
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(
                  Icons.notifications_outlined,
                  color: Colors.white,
                  size: 22,
                ),
                SizedBox(width: 8),
                Text(
                  "Me notifier quand c'est prêt",
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                    color: Colors.white,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildInfoCards() {
    return Row(
      children: [
        Expanded(
          child: _buildInfoCard(
            Icons.schedule,
            "Bientôt disponible",
            "Quelques semaines",
            Color(0xFF48BB78),
          ),
        ),
        SizedBox(width: 16),
        Expanded(
          child: _buildInfoCard(
            Icons.star,
            "Nouvelle fonctionnalité",
            "Expérience améliorée",
            Color(0xFFED8936),
          ),
        ),
      ],
    );
  }

  Widget _buildInfoCard(IconData icon, String title, String subtitle, Color color) {
    return Container(
      padding: EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: color.withOpacity(0.2),
          width: 1,
        ),
      ),
      child: Column(
        children: [
          Container(
            padding: EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: color.withOpacity(0.1),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Icon(
              icon,
              color: color,
              size: 20,
            ),
          ),
          SizedBox(height: 8),
          Text(
            title,
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.w600,
              color: Color(0xFF2D3748),
            ),
          ),
          SizedBox(height: 4),
          Text(
            subtitle,
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 10,
              color: Color(0xFF718096),
            ),
          ),
        ],
      ),
    );
  }

  void _showNotificationDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          title: Row(
            children: [
              Icon(Icons.check_circle, color: Color(0xFF48BB78)),
              SizedBox(width: 8),
              Text("Notification activée !"),
            ],
          ),
          content: Text(
            "Vous serez notifié dès que cette fonctionnalité sera disponible.",
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: Text("OK"),
            ),
          ],
        );
      },
    );
  }
}