import 'package:flutter/material.dart';

// ─── Sample Data ──────────────────────────────────────────────────────────────

class _Book {
  const _Book({
    required this.title,
    required this.author,
    required this.rating,
    required this.color,
    this.progress = 0.0,
    this.pages = 0,
    this.pagesRead = 0,
  });
  final String title;
  final String author;
  final double rating;
  final Color color;
  final double progress;
  final int pages;
  final int pagesRead;
}

const _currentlyReading = [
  _Book(
    title: 'Atomic Habits',
    author: 'James Clear',
    rating: 4.8,
    color: Color(0xFF6366F1), // Indigo
    progress: 0.62,
    pages: 320,
    pagesRead: 198,
  ),
  _Book(
    title: 'Deep Work',
    author: 'Cal Newport',
    rating: 4.6,
    color: Color(0xFF0EA5E9), // Sky blue
    progress: 0.35,
    pages: 296,
    pagesRead: 104,
  ),
];

const _recentBooks = [
  _Book(
    title: 'Clear Thinking',
    author: 'Shane Parrish',
    rating: 4.7,
    color: Color(0xFF10B981),
  ),
  _Book(
    title: 'Same as Ever',
    author: 'Morgan Housel',
    rating: 4.5,
    color: Color(0xFFF59E0B),
  ),
  _Book(
    title: 'Outlive',
    author: 'Peter Attia',
    rating: 4.6,
    color: Color(0xFF8B5CF6),
  ),
  _Book(
    title: 'Slow Productivity',
    author: 'Cal Newport',
    rating: 4.4,
    color: Color(0xFF14B8A6),
  ),
];

const _popularBooks = [
  _Book(
    title: 'The Psychology of Money',
    author: 'Morgan Housel',
    rating: 4.8,
    color: Color(0xFFF59E0B),
  ),
  _Book(
    title: 'Thinking, Fast\nand Slow',
    author: 'Daniel Kahneman',
    rating: 4.7,
    color: Color(0xFF0EA5E9),
  ),
  _Book(
    title: "Man's Search for Meaning",
    author: 'Viktor Frankl',
    rating: 4.9,
    color: Color(0xFF8B5CF6),
  ),
  _Book(
    title: 'The 48 Laws of Power',
    author: 'Robert Greene',
    rating: 4.5,
    color: Color(0xFFEF4444),
  ),
];

// ─── Home Page ────────────────────────────────────────────────────────────────

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _navIndex = 0;

  final Color primaryColor = const Color(0xFF6366F1);
  final Color bgColor = const Color(0xFFF8FAFC);
  final Color textDark = const Color(0xFF0F172A);
  final Color textLight = const Color(0xFF64748B);

  String get _greeting {
    final h = DateTime.now().hour;
    if (h < 12) return 'Good Morning';
    if (h < 17) return 'Good Afternoon';
    return 'Good Evening';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: bgColor,
      body: SafeArea(
        child: CustomScrollView(
          physics: const BouncingScrollPhysics(),
          slivers: [
            // ── Greeting & Search ────────────────────────────────
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.fromLTRB(24, 24, 24, 8),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Header row
                    Row(
                      children: [
                        Container(
                          width: 48,
                          height: 48,
                          decoration: BoxDecoration(
                            color: primaryColor.withValues(alpha: 0.1),
                            shape: BoxShape.circle,
                            border: Border.all(
                              color: primaryColor.withValues(alpha: 0.2),
                            ),
                          ),
                          child: Icon(
                            Icons.person_rounded,
                            color: primaryColor,
                            size: 24,
                          ),
                        ),
                        const SizedBox(width: 16),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                _greeting,
                                style: TextStyle(
                                  color: textLight,
                                  fontSize: 14,
                                ),
                              ),
                              const SizedBox(height: 2),
                              Text(
                                'Sourav 👋',
                                style: TextStyle(
                                  color: textDark,
                                  fontSize: 22,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
                          ),
                        ),
                        Container(
                          padding: const EdgeInsets.all(12),
                          decoration: const BoxDecoration(
                            color: Colors.white,
                            shape: BoxShape.circle,
                          ),
                          child: const Icon(
                            Icons.notifications_none_rounded,
                            size: 24,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 24),

                    // Soft Search Bar
                    Container(
                      height: 56,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(16),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withValues(alpha: 0.02),
                            blurRadius: 10,
                            offset: const Offset(0, 4),
                          ),
                        ],
                      ),
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      child: Row(
                        children: [
                          Icon(
                            Icons.search_rounded,
                            color: textLight,
                            size: 22,
                          ),
                          const SizedBox(width: 12),
                          Expanded(
                            child: TextField(
                              decoration: InputDecoration(
                                hintText: 'Search books or authors...',
                                hintStyle: TextStyle(
                                  color: textLight,
                                  fontSize: 15,
                                ),
                                border: InputBorder.none,
                                isDense: true,
                              ),
                            ),
                          ),
                          Container(
                            padding: const EdgeInsets.all(8),
                            decoration: BoxDecoration(
                              color: primaryColor.withValues(alpha: 0.1),
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: Icon(
                              Icons.tune_rounded,
                              color: primaryColor,
                              size: 18,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),

            // ── Currently Reading ────────────────────────────────
            SliverToBoxAdapter(
              child: _SectionHeader(title: 'Currently Reading'),
            ),
            SliverToBoxAdapter(
              child: SizedBox(
                height: 190,
                child: ListView.separated(
                  padding: const EdgeInsets.fromLTRB(24, 8, 24, 0),
                  scrollDirection: Axis.horizontal,
                  itemCount: _currentlyReading.length,
                  separatorBuilder: (_, __) => const SizedBox(width: 16),
                  itemBuilder: (_, i) =>
                      _CurrentReadCard(book: _currentlyReading[i]),
                ),
              ),
            ),

            // ── Recent Releases ──────────────────────────────────
            SliverToBoxAdapter(child: _SectionHeader(title: 'Recent Releases')),
            SliverToBoxAdapter(
              child: SizedBox(
                height: 210,
                child: ListView.separated(
                  padding: const EdgeInsets.fromLTRB(24, 8, 24, 0),
                  scrollDirection: Axis.horizontal,
                  itemCount: _recentBooks.length,
                  separatorBuilder: (_, __) => const SizedBox(width: 16),
                  itemBuilder: (_, i) => _BookCard(book: _recentBooks[i]),
                ),
              ),
            ),

            // ── Popular Books (Grid) ─────────────────────────────
            SliverToBoxAdapter(child: _SectionHeader(title: 'Popular Books')),
            SliverPadding(
              padding: const EdgeInsets.fromLTRB(24, 8, 24, 100),
              sliver: SliverGrid(
                delegate: SliverChildBuilderDelegate(
                  (_, i) => _PopularCard(book: _popularBooks[i]),
                  childCount: _popularBooks.length,
                ),
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  mainAxisSpacing: 16,
                  crossAxisSpacing: 16,
                  childAspectRatio: 0.75,
                ),
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: _BottomNav(
        current: _navIndex,
        onTap: (i) => setState(() => _navIndex = i),
      ),
    );
  }
}

// ─── Section Header ───────────────────────────────────────────────────────────

class _SectionHeader extends StatelessWidget {
  const _SectionHeader({required this.title});
  final String title;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(24, 32, 24, 0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            title,
            style: const TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: Color(0xFF0F172A),
            ),
          ),
          const Text(
            'See all',
            style: TextStyle(
              color: Color(0xFF6366F1),
              fontWeight: FontWeight.bold,
              fontSize: 14,
            ),
          ),
        ],
      ),
    );
  }
}

// ─── Currently Reading Card ───────────────────────────────────────────────────

class _CurrentReadCard extends StatelessWidget {
  const _CurrentReadCard({required this.book});
  final _Book book;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 320,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(24),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.03),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Row(
        children: [
          // Graphic Cover
          Container(
            width: 86,
            height: 124,
            decoration: BoxDecoration(
              color: book.color,
              borderRadius: BorderRadius.circular(12),
              boxShadow: [
                BoxShadow(
                  color: book.color.withValues(alpha: 0.3),
                  blurRadius: 8,
                  offset: const Offset(2, 4),
                ),
              ],
            ),
            child: const Icon(
              Icons.auto_stories_rounded,
              color: Colors.white70,
              size: 36,
            ),
          ),
          const SizedBox(width: 16),
          // Info
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 10,
                    vertical: 4,
                  ),
                  decoration: BoxDecoration(
                    color: book.color.withValues(alpha: 0.1),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Text(
                    'Reading',
                    style: TextStyle(
                      color: book.color,
                      fontWeight: FontWeight.bold,
                      fontSize: 11,
                      letterSpacing: 0.5,
                    ),
                  ),
                ),
                const SizedBox(height: 10),
                Text(
                  book.title,
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                    color: Color(0xFF0F172A),
                  ),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
                const Spacer(),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      '${book.pagesRead}/${book.pages} p',
                      style: const TextStyle(
                        color: Color(0xFF64748B),
                        fontSize: 13,
                      ),
                    ),
                    Text(
                      '${(book.progress * 100).toInt()}%',
                      style: TextStyle(
                        color: book.color,
                        fontWeight: FontWeight.bold,
                        fontSize: 13,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 8),
                ClipRRect(
                  borderRadius: BorderRadius.circular(100),
                  child: LinearProgressIndicator(
                    value: book.progress,
                    minHeight: 6,
                    backgroundColor: const Color(0xFFF1F5F9),
                    valueColor: AlwaysStoppedAnimation<Color>(book.color),
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

// ─── Small Book Card ──────────────────────────────────────────────────────────

class _BookCard extends StatelessWidget {
  const _BookCard({required this.book});
  final _Book book;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 120,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            height: 160,
            decoration: BoxDecoration(
              color: book.color,
              borderRadius: BorderRadius.circular(16),
              boxShadow: [
                BoxShadow(
                  color: book.color.withValues(alpha: 0.3),
                  blurRadius: 8,
                  offset: const Offset(2, 4),
                ),
              ],
            ),
            child: const Center(
              child: Icon(
                Icons.menu_book_rounded,
                color: Colors.white,
                size: 36,
              ),
            ),
          ),
          const SizedBox(height: 12),
          Text(
            book.title,
            style: const TextStyle(
              color: Color(0xFF0F172A),
              fontWeight: FontWeight.bold,
              fontSize: 14,
            ),
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
          const SizedBox(height: 4),
          Text(
            book.author,
            style: const TextStyle(color: Color(0xFF64748B), fontSize: 12),
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
        ],
      ),
    );
  }
}

// ─── Popular Book (Grid Card) ─────────────────────────────────────────────────

class _PopularCard extends StatelessWidget {
  const _PopularCard({required this.book});
  final _Book book;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.03),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: Container(
              decoration: BoxDecoration(
                color: book.color,
                borderRadius: const BorderRadius.vertical(
                  top: Radius.circular(20),
                ),
              ),
              child: const Center(
                child: Icon(
                  Icons.auto_stories_rounded,
                  color: Colors.white,
                  size: 36,
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(12),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  book.title,
                  style: const TextStyle(
                    color: Color(0xFF0F172A),
                    fontWeight: FontWeight.bold,
                    fontSize: 14,
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
                const SizedBox(height: 4),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const Icon(
                      Icons.star_rounded,
                      color: Color(0xFFF59E0B),
                      size: 14,
                    ),
                    const SizedBox(width: 4),
                    Text(
                      '${book.rating}',
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 12,
                        color: Color(0xFF64748B),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

// ─── Bottom Navigation Bar ────────────────────────────────────────────────────

class _BottomNav extends StatelessWidget {
  const _BottomNav({required this.current, required this.onTap});
  final int current;
  final ValueChanged<int> onTap;

  @override
  Widget build(BuildContext context) {
    final primaryColor = const Color(0xFF6366F1);
    final unselectedColor = const Color(0xFF94A3B8);

    const items = [
      (Icons.home_rounded, Icons.home_outlined, 'Home'),
      (Icons.menu_book_rounded, Icons.menu_book_outlined, 'Library'),
      (Icons.bar_chart_rounded, Icons.bar_chart_outlined, 'Stats'),
      (Icons.person_rounded, Icons.person_outline_rounded, 'Profile'),
    ];

    return Container(
      padding: const EdgeInsets.symmetric(vertical: 12),
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
        boxShadow: [
          BoxShadow(
            color: Colors.black12,
            blurRadius: 20,
            offset: Offset(0, -5),
          ),
        ],
      ),
      child: SafeArea(
        top: false,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: List.generate(items.length, (i) {
            final isSelected = current == i;
            return GestureDetector(
              onTap: () => onTap(i),
              behavior: HitTestBehavior.opaque,
              child: AnimatedContainer(
                duration: const Duration(milliseconds: 200),
                padding: const EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: 8,
                ),
                decoration: BoxDecoration(
                  color: isSelected
                      ? primaryColor.withValues(alpha: 0.1)
                      : Colors.transparent,
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(
                      isSelected ? items[i].$1 : items[i].$2,
                      color: isSelected ? primaryColor : unselectedColor,
                      size: 26,
                    ),
                    if (isSelected) ...[
                      const SizedBox(width: 8),
                      Text(
                        items[i].$3,
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                          color: primaryColor,
                        ),
                      ),
                    ],
                  ],
                ),
              ),
            );
          }),
        ),
      ),
    );
  }
}
