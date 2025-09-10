import 'package:crowfunding_project/core/data/models/project_model.dart';
import 'package:crowfunding_project/ui/features/projects/component/project_budget.dart';
import 'package:crowfunding_project/ui/features/projects/component/project_header.dart';
import 'package:crowfunding_project/ui/features/projects/component/project_stats.dart';
import 'package:crowfunding_project/utils/media_pager.dart';
import 'package:flutter/material.dart';

class CompletedProjectContainer extends StatefulWidget {
  final ProjectModel project;
  const CompletedProjectContainer({super.key, required this.project});

  @override
  State<CompletedProjectContainer> createState() => _CompletedProjectContainerState();
}

class _CompletedProjectContainerState extends State<CompletedProjectContainer> with SingleTickerProviderStateMixin {
  int currentStep = 1;
  final int totalSteps = 3;
  late AnimationController _animationController;
  late  Animation<double> _progressAnimation;

  @override
  void initState(){
    super.initState();
    _animationController = AnimationController(
      duration: Duration(milliseconds: 500),
      vsync: this
    );
    _progressAnimation = Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(CurvedAnimation(
      parent: _animationController,
      curve: Curves.easeInOut
    ));
  }

  @override
  void dispose(){
    _animationController.dispose();
    super.dispose();
  }

  void _onStepTapped(int step){
    setState(() {
      currentStep = step;
    });
    _animationController.reset();
    _animationController.forward();
  }


  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 5.0),
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                ProjectHeader(project: widget.project),
                const SizedBox(height: 4.0),
                Text(
                  widget.project.title != null ? widget.project.title! : 'No title available',
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16.0,
                  ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 4.0),
                StepProgressBar(
                  currentStep: currentStep,
                  totalSteps: totalSteps,
                  onStepTapped: _onStepTapped,
                  animation: _progressAnimation,
                ),
                Text(
                  widget.project.content != null
                      ? widget.project.content!
                      : 'No content available',
                ),
                SizedBox(height: 6.0),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 8.0),
            child: MediaPager(mediaUrls: ['https://images.pexels.com/photos/12199063/pexels-photo-12199063.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=1'],)
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12.0),
            child: ProjectBudget(project: widget.project),
          ),
          const SizedBox(height: 8.0),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12.0),
            child: ProjectStats(project: widget.project),
          ),
        ],
      ),
    );
  }
}

class StepProgressBar extends StatelessWidget {
  final int currentStep;
  final int totalSteps;
  final Function(int) onStepTapped;
  final Animation<double> animation;

  const StepProgressBar({
    super.key,
    required this.currentStep,
    required this.totalSteps,
    required this.onStepTapped,
    required this.animation,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 50,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: _buildSteps(),
      ),
    );
  }

  List<Widget> _buildSteps() {
    List<Widget> steps = [];
    
    for (int i = 1; i <= totalSteps; i++) {
      // Ajouter le cercle de l'étape
      steps.add(_buildStepCircle(i));
      
      // Ajouter la ligne de connexion (sauf pour le dernier élément)
      if (i < totalSteps) {
        steps.add(_buildConnectorLine(i));
      }
    }
    
    return steps;
  }

  Widget _buildStepCircle(int step) {
    bool isActive = step <= currentStep;
    bool isCurrent = step == currentStep;
    
    return AnimatedBuilder(
      animation: animation,
      builder: (context, child) {
        double scale = isCurrent ? 1.0 + (0.1 * animation.value) : 1.0;
        
        return Transform.scale(
          scale: scale,
          child: GestureDetector(
            onTap: () => onStepTapped(step),
            child: Container(
              width: 40,
              height: 40,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: isActive ? Colors.green : Colors.grey[300],
                border: Border.all(
                  color: isCurrent ? Colors.green[700]! : Colors.transparent,
                  width: 2,
                ),
                boxShadow: isCurrent
                    ? [
                        BoxShadow(
                          color: Colors.green.withOpacity(0.3),
                          spreadRadius: 2,
                          blurRadius: 8,
                          offset: Offset(0, 2),
                        ),
                      ]
                    : null,
              ),
              child: Center(
                child: isActive
                    ? Icon(
                        step < currentStep ? Icons.check : Icons.circle,
                        color: Colors.white,
                        size: step < currentStep ? 20 : 8,
                      )
                    : Text(
                        '$step',
                        style: TextStyle(
                          color: Colors.grey[600],
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                        ),
                      ),
              ),
            ),
          ),
        );
      },
    );
  }

  Widget _buildConnectorLine(int step) {
    bool isCompleted = step < currentStep;
    bool isInProgress = step == currentStep - 1;
    
    return AnimatedBuilder(
      animation: animation,
      builder: (context, child) {
        double progressValue = isInProgress ? animation.value : (isCompleted ? 1.0 : 0.0);
        
        return Container(
          width: 50,
          height: 4,
          margin: EdgeInsets.symmetric(horizontal: 8),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(2),
          ),
          child: Stack(
            children: [
              // Ligne de fond
              Container(
                width: 50,
                height: 4,
                decoration: BoxDecoration(
                  color: Colors.grey[300],
                  borderRadius: BorderRadius.circular(2),
                ),
              ),
              // Ligne de progression
              Container(
                width: 50 * progressValue,
                height: 4,
                decoration: BoxDecoration(
                  color: Colors.green,
                  borderRadius: BorderRadius.circular(2),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}