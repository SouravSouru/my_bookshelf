import 'package:flutter/material.dart';

class BookDetailsPage extends StatelessWidget {
  const BookDetailsPage({
    super.key,
    required this.title,
    required this.author,
    required this.bookColor,
  });

  final String title;
  final String author;
  final Color bookColor;

  @override
  Widget build(BuildContext context) {
    final textDark = const Color(0xFF1A1A2C);
    final textLight = const Color(0xFF9CA3AF);

    return Scaffold(
      backgroundColor: Colors.white,
      body: Stack(
        children: [
          // ── Background Header Color ──
          Positioned(
            top: 0,
            left: 0,
            right: 0,
            height: MediaQuery.of(context).size.height * 0.45,
            child: Container(color: bookColor.withValues(alpha: 0.15)),
          ),

          CustomScrollView(
            slivers: [
              SliverAppBar(
                backgroundColor: Colors.transparent,
                elevation: 0,
                pinned: true,
                leading: IconButton(
                  icon: const Icon(Icons.arrow_back_ios_new_rounded),
                  color: textDark,
                  onPressed: () => Navigator.of(context).pop(),
                ),
                actions: [
                  IconButton(
                    icon: const Icon(Icons.bookmark_border_rounded),
                    color: textDark,
                    onPressed: () {},
                  ),
                  IconButton(
                    icon: const Icon(Icons.more_vert_rounded),
                    color: textDark,
                    onPressed: () {},
                  ),
                ],
              ),

              // ── Book Cover Info ──
              SliverToBoxAdapter(
                child: Column(
                  children: [
                    const SizedBox(height: 20),
                    Container(
                      height: 240,
                      width: 160,
                      decoration: BoxDecoration(
                        color: bookColor,
                        borderRadius: BorderRadius.circular(16),
                        boxShadow: [
                          BoxShadow(
                            color: bookColor.withValues(alpha: 0.4),
                            blurRadius: 24,
                            offset: const Offset(0, 12),
                          ),
                        ],
                      ),
                      child: const Center(
                        child: Icon(
                          Icons.auto_stories_rounded,
                          color: Colors.white54,
                          size: 64,
                        ),
                      ),
                    ),
                    const SizedBox(height: 32),
                    Text(
                      title,
                      style: TextStyle(
                        fontSize: 28,
                        fontWeight: FontWeight.w900,
                        color: textDark,
                        letterSpacing: -0.5,
                      ),
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 8),
                    Text(
                      author,
                      style: TextStyle(
                        fontSize: 16,
                        color: textLight,
                        fontWeight: FontWeight.w600,
                      ),
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 24),

                    // ── Quick Stats Layer ──
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        _QuickStat(
                          icon: Icons.star_rounded,
                          label: '4.8',
                          subLabel: 'Rating',
                          iconColor: const Color(0xFFF59E0B),
                        ),
                        Container(
                          width: 1,
                          height: 40,
                          color: const Color(0xFFE2E8F0),
                          margin: const EdgeInsets.symmetric(horizontal: 24),
                        ),
                        const _QuickStat(
                          icon: Icons.menu_book_rounded,
                          label: '342',
                          subLabel: 'Pages',
                          iconColor: Color(0xFF64748B),
                        ),
                        Container(
                          width: 1,
                          height: 40,
                          color: const Color(0xFFE2E8F0),
                          margin: const EdgeInsets.symmetric(horizontal: 24),
                        ),
                        const _QuickStat(
                          icon: Icons.language_rounded,
                          label: 'Eng',
                          subLabel: 'Language',
                          iconColor: Color(0xFF64748B),
                        ),
                      ],
                    ),
                  ],
                ),
              ),

              const SliverToBoxAdapter(child: SizedBox(height: 32)),

              // ── Synopsis / Description ──
              SliverToBoxAdapter(
                child: Container(
                  padding: const EdgeInsets.fromLTRB(24, 32, 24, 100),
                  decoration: const BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.vertical(
                      top: Radius.circular(40),
                    ),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Synopsis',
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.w800,
                          color: textDark,
                        ),
                      ),
                      const SizedBox(height: 16),
                      Text(
                        'A masterpiece of imagination and world-building, this book takes you on an unforgettable journey. Experience the struggles of the characters as they navigate through a complex universe full of secrets, betrayal, and hope.\n\nFilled with intricate details and a breathtaking narrative, it sets a new standard for storytelling that leaves you turning pages long into the night.',
                        style: TextStyle(
                          fontSize: 15,
                          height: 1.6,
                          color: textDark.withValues(alpha: 0.7),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),

          // ── Bottom Fixed Action Button ──
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: Container(
              padding: const EdgeInsets.fromLTRB(24, 16, 24, 32),
              decoration: BoxDecoration(
                color: Colors.white,
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withValues(alpha: 0.05),
                    offset: const Offset(0, -4),
                    blurRadius: 16,
                  ),
                ],
              ),
              child: ElevatedButton(
                onPressed: () {},
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF5E48E8),
                  padding: const EdgeInsets.symmetric(vertical: 20),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                  elevation: 0,
                ),
                child: const Text(
                  'Start Reading',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _QuickStat extends StatelessWidget {
  const _QuickStat({
    required this.icon,
    required this.label,
    required this.subLabel,
    required this.iconColor,
  });

  final IconData icon;
  final String label;
  final String subLabel;
  final Color iconColor;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            Icon(icon, color: iconColor, size: 18),
            const SizedBox(width: 4),
            Text(
              label,
              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: Color(0xFF1A1A2C),
              ),
            ),
          ],
        ),
        const SizedBox(height: 4),
        Text(
          subLabel,
          style: const TextStyle(fontSize: 12, color: Color(0xFF9CA3AF)),
        ),
      ],
    );
  }
}
