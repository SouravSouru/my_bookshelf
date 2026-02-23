import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

// ─── Nav Item Model ───────────────────────────────────────────────────────────

class _NavItem {
  const _NavItem({
    required this.icon,
    required this.activeIcon,
    required this.label,
  });
  final IconData icon;
  final IconData activeIcon;
  final String label;
}

const _navItems = [
  _NavItem(
    icon: Icons.home_outlined,
    activeIcon: Icons.home_rounded,
    label: 'Home',
  ),
  _NavItem(
    icon: Icons.collections_bookmark_outlined,
    activeIcon: Icons.collections_bookmark_rounded,
    label: 'My Books',
  ),
  _NavItem(
    icon: Icons.explore_outlined,
    activeIcon: Icons.explore_rounded,
    label: 'Discover',
  ),
  _NavItem(
    icon: Icons.person_outline_rounded,
    activeIcon: Icons.person_rounded,
    label: 'Profile',
  ),
];

// ─── Bottom Nav Bar Widget ────────────────────────────────────────────────────

class AppBottomNavBar extends StatefulWidget {
  const AppBottomNavBar({
    super.key,
    required this.currentIndex,
    required this.onTap,
  });

  final int currentIndex;
  final ValueChanged<int> onTap;

  @override
  State<AppBottomNavBar> createState() => _AppBottomNavBarState();
}

class _AppBottomNavBarState extends State<AppBottomNavBar>
    with TickerProviderStateMixin {
  // One AnimationController per item for independent icon bounce
  late final List<AnimationController> _bounceControllers;
  late final List<Animation<double>> _bounceAnimations;

  static const _primaryColor = Color(0xFF6552E0);
  static const _bgColor = Colors.white;
  static const _unselectedColor = Color(0xFFB8B8C7);

  @override
  void initState() {
    super.initState();
    _bounceControllers = List.generate(
      _navItems.length,
      (_) => AnimationController(
        vsync: this,
        duration: const Duration(milliseconds: 400),
      ),
    );
    _bounceAnimations = _bounceControllers
        .map(
          (ctrl) => TweenSequence<double>([
            TweenSequenceItem(
              tween: Tween(
                begin: 1.0,
                end: 1.25,
              ).chain(CurveTween(curve: Curves.easeOut)),
              weight: 40,
            ),
            TweenSequenceItem(
              tween: Tween(
                begin: 1.25,
                end: 0.9,
              ).chain(CurveTween(curve: Curves.easeInOut)),
              weight: 30,
            ),
            TweenSequenceItem(
              tween: Tween(
                begin: 0.9,
                end: 1.0,
              ).chain(CurveTween(curve: Curves.elasticOut)),
              weight: 30,
            ),
          ]).animate(ctrl),
        )
        .toList();

    // Kick off the initial selected tab animation
    _bounceControllers[widget.currentIndex].forward();
  }

  @override
  void didUpdateWidget(AppBottomNavBar old) {
    super.didUpdateWidget(old);
    if (old.currentIndex != widget.currentIndex) {
      _bounceControllers[widget.currentIndex]
        ..reset()
        ..forward();
    }
  }

  @override
  void dispose() {
    for (final ctrl in _bounceControllers) {
      ctrl.dispose();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      // Floating card shadow
      decoration: BoxDecoration(
        color: _bgColor,
        boxShadow: [
          BoxShadow(
            color: const Color(0xFF6552E0).withValues(alpha: 0.10),
            blurRadius: 30,
            offset: const Offset(0, -6),
          ),
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.04),
            blurRadius: 10,
            offset: const Offset(0, -2),
          ),
        ],
      ),
      child: SafeArea(
        top: false,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 10),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: List.generate(_navItems.length, (index) {
              return _NavTile(
                item: _navItems[index],
                isSelected: widget.currentIndex == index,
                bounceAnimation: _bounceAnimations[index],
                primaryColor: _primaryColor,
                unselectedColor: _unselectedColor,
                onTap: () {
                  HapticFeedback.lightImpact();
                  widget.onTap(index);
                },
              );
            }),
          ),
        ),
      ),
    );
  }
}

// ─── Single Nav Tile ──────────────────────────────────────────────────────────

class _NavTile extends StatelessWidget {
  const _NavTile({
    required this.item,
    required this.isSelected,
    required this.bounceAnimation,
    required this.primaryColor,
    required this.unselectedColor,
    required this.onTap,
  });

  final _NavItem item;
  final bool isSelected;
  final Animation<double> bounceAnimation;
  final Color primaryColor;
  final Color unselectedColor;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      behavior: HitTestBehavior.opaque,
      child: SizedBox(
        width: 72,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            // ── Pill / Icon Indicator ──
            AnimatedContainer(
              duration: const Duration(milliseconds: 300),
              curve: Curves.easeInOut,
              height: 46,
              width: isSelected ? 64 : 46,
              decoration: BoxDecoration(
                color: isSelected
                    ? primaryColor.withValues(alpha: 0.12)
                    : Colors.transparent,
                borderRadius: BorderRadius.circular(24),
              ),
              child: Center(
                child: ScaleTransition(
                  scale: bounceAnimation,
                  child: AnimatedSwitcher(
                    duration: const Duration(milliseconds: 200),
                    transitionBuilder: (child, anim) => ScaleTransition(
                      scale: anim,
                      child: FadeTransition(opacity: anim, child: child),
                    ),
                    child: Icon(
                      isSelected ? item.activeIcon : item.icon,
                      key: ValueKey(isSelected),
                      size: 24,
                      color: isSelected ? primaryColor : unselectedColor,
                    ),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 4),

            // ── Label ──
            AnimatedDefaultTextStyle(
              duration: const Duration(milliseconds: 200),
              style: TextStyle(
                fontSize: 10.5,
                fontWeight: isSelected ? FontWeight.w700 : FontWeight.w500,
                color: isSelected ? primaryColor : unselectedColor,
                letterSpacing: isSelected ? 0.2 : 0.0,
              ),
              child: Text(item.label, maxLines: 1),
            ),
          ],
        ),
      ),
    );
  }
}
