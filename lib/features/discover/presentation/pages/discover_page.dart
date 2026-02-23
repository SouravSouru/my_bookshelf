import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

// ─── Sample Data ──────────────────────────────────────────────────────────────

class _DiscoverBook {
  const _DiscoverBook({
    required this.title,
    required this.author,
    required this.color,
    this.rating = 0.0,
    this.price = 0.0,
  });
  final String title;
  final String author;
  final Color color;
  final double rating;
  final double price;
}

const _trendingBooks = [
  _DiscoverBook(
    title: 'Dune',
    author: 'Frank Herbert',
    color: Color(0xFFD97706), // Amber
    rating: 4.8,
    price: 9.99,
  ),
  _DiscoverBook(
    title: 'Foundation',
    author: 'Isaac Asimov',
    color: Color(0xFF4338CA), // Indigo
    rating: 4.7,
    price: 12.50,
  ),
  _DiscoverBook(
    title: 'Neuromancer',
    author: 'William Gibson',
    color: Color(0xFF0F766E), // Teal
    rating: 4.5,
    price: 8.99,
  ),
];

const _categories = [
  {
    'icon': Icons.rocket_launch_rounded,
    'name': 'Sci-Fi',
    'color': Color(0xFF4338CA),
  },
  {'icon': Icons.castle_rounded, 'name': 'Fantasy', 'color': Color(0xFFD97706)},
  {
    'icon': Icons.favorite_rounded,
    'name': 'Romance',
    'color': Color(0xFFE11D48),
  },
  {
    'icon': Icons.psychology_rounded,
    'name': 'Psychology',
    'color': Color(0xFF059669),
  },
  {
    'icon': Icons.history_edu_rounded,
    'name': 'History',
    'color': Color(0xFFB45309),
  },
];

const _newArrivals = [
  _DiscoverBook(
    title: 'The Eye of the World',
    author: 'Robert Jordan',
    color: Color(0xFF1E293B), // Dark Slate
    rating: 4.6,
  ),
  _DiscoverBook(
    title: 'To Kill a Mockingbird',
    author: 'Harper Lee',
    color: Color(0xFF0369A1), // Sky
    rating: 4.9,
  ),
];

// ─── Discover Page ────────────────────────────────────────────────────────────

class DiscoverPage extends StatefulWidget {
  const DiscoverPage({super.key});

  @override
  State<DiscoverPage> createState() => _DiscoverPageState();
}

class _DiscoverPageState extends State<DiscoverPage> {
  final Color bgColor = const Color(0xFFF6F8FA);
  final Color textDark = const Color(0xFF1A1A2C);
  final Color textLight = const Color(0xFF9CA3AF);
  final Color primaryColor = const Color(0xFF5E48E8);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: bgColor,
      body: SafeArea(
        child: CustomScrollView(
          slivers: [
            SliverToBoxAdapter(child: const SizedBox(height: 20)),

            // ── Top Header ──
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24),
                child: Text(
                  'Discover',
                  style: TextStyle(
                    fontSize: 30,
                    fontWeight: FontWeight.w900,
                    color: textDark,
                    letterSpacing: -0.5,
                  ),
                ),
              ),
            ),
            SliverToBoxAdapter(child: const SizedBox(height: 24)),

            // ── Search Bar ──
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24),
                child: Container(
                  height: 48,
                  decoration: BoxDecoration(
                    color: const Color(0xFFEBEFF4),
                    borderRadius: BorderRadius.circular(24),
                  ),
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: Row(
                    children: [
                      Icon(Icons.search_rounded, color: textLight, size: 20),
                      const SizedBox(width: 12),
                      Expanded(
                        child: TextField(
                          decoration: InputDecoration(
                            hintText: 'Search books, authors, genres...',
                            hintStyle: TextStyle(
                              color: textLight,
                              fontSize: 14,
                              fontWeight: FontWeight.w500,
                            ),
                            border: InputBorder.none,
                            isDense: true,
                          ),
                        ),
                      ),
                      Icon(Icons.mic_none_rounded, color: textLight, size: 20),
                    ],
                  ),
                ),
              ),
            ),
            SliverToBoxAdapter(child: const SizedBox(height: 28)),

            // ── Featured Banner ──
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24),
                child: GestureDetector(
                  onTap: () {
                    context.push(
                      '/discover/book_details',
                      extra: {
                        'title': 'The Martian',
                        'author': 'Andy Weir',
                        'color': const Color(0xFFB91C1C),
                      },
                    );
                  },
                  child: Container(
                    height: 160,
                    decoration: BoxDecoration(
                      gradient: const LinearGradient(
                        colors: [Color(0xFF5E48E8), Color(0xFF8C7BFF)],
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                      ),
                      borderRadius: BorderRadius.circular(24),
                      boxShadow: [
                        BoxShadow(
                          color: const Color(0xFF5E48E8).withValues(alpha: 0.3),
                          blurRadius: 20,
                          offset: const Offset(0, 10),
                        ),
                      ],
                    ),
                    child: Stack(
                      children: [
                        // Decorative Element
                        Positioned(
                          right: -20,
                          top: -20,
                          child: Container(
                            width: 120,
                            height: 120,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: Colors.white.withValues(alpha: 0.1),
                            ),
                          ),
                        ),
                        Positioned(
                          right: 40,
                          bottom: -30,
                          child: Container(
                            width: 80,
                            height: 80,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: Colors.white.withValues(alpha: 0.1),
                            ),
                          ),
                        ),
                        // Content
                        Padding(
                          padding: const EdgeInsets.all(24),
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
                                  color: Colors.white.withValues(alpha: 0.2),
                                  borderRadius: BorderRadius.circular(12),
                                ),
                                child: const Text(
                                  'Featured',
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 10,
                                    fontWeight: FontWeight.bold,
                                    letterSpacing: 0.5,
                                  ),
                                ),
                              ),
                              const SizedBox(height: 12),
                              const Text(
                                'The Martian',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 22,
                                  fontWeight: FontWeight.w800,
                                ),
                              ),
                              const SizedBox(height: 4),
                              Text(
                                'Andy Weir',
                                style: TextStyle(
                                  color: Colors.white.withValues(alpha: 0.8),
                                  fontSize: 13,
                                ),
                              ),
                            ],
                          ),
                        ),
                        // Mock Image/Icon
                        Positioned(
                          right: 20,
                          bottom: 0,
                          child: Container(
                            width: 80,
                            height: 110,
                            decoration: const BoxDecoration(
                              color: Color(0xFFB91C1C),
                              borderRadius: BorderRadius.vertical(
                                top: Radius.circular(8),
                              ),
                            ),
                            child: const Icon(
                              Icons.rocket_rounded,
                              color: Colors.white54,
                              size: 40,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
            SliverToBoxAdapter(child: const SizedBox(height: 28)),

            // ── Categories ──
            SliverToBoxAdapter(
              child: _SectionTitle(title: 'Categories', textDark: textDark),
            ),
            SliverToBoxAdapter(
              child: SizedBox(
                height: 48,
                child: ListView.separated(
                  padding: const EdgeInsets.symmetric(horizontal: 24),
                  scrollDirection: Axis.horizontal,
                  itemCount: _categories.length,
                  separatorBuilder: (_, __) => const SizedBox(width: 12),
                  itemBuilder: (context, index) {
                    final category = _categories[index];
                    final catColor = category['color'] as Color;
                    return GestureDetector(
                      onTap: () {
                        context.push(
                          '/discover/category',
                          extra: {'name': category['name'], 'color': catColor},
                        );
                      },
                      child: Container(
                        padding: const EdgeInsets.symmetric(horizontal: 16),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(24),
                          border: Border.all(color: const Color(0xFFF1F5F9)),
                        ),
                        child: Row(
                          children: [
                            Icon(
                              category['icon'] as IconData,
                              color: catColor,
                              size: 18,
                            ),
                            const SizedBox(width: 8),
                            Text(
                              category['name'] as String,
                              style: TextStyle(
                                color: textDark,
                                fontWeight: FontWeight.w600,
                                fontSize: 14,
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                ),
              ),
            ),
            SliverToBoxAdapter(child: const SizedBox(height: 32)),

            // ── Trending Books ──
            SliverToBoxAdapter(
              child: _SectionTitle(title: 'Trending Books', textDark: textDark),
            ),
            SliverToBoxAdapter(
              child: SizedBox(
                height: 260,
                child: ListView.separated(
                  padding: const EdgeInsets.symmetric(horizontal: 24),
                  scrollDirection: Axis.horizontal,
                  itemCount: _trendingBooks.length,
                  separatorBuilder: (_, __) => const SizedBox(width: 16),
                  itemBuilder: (context, index) {
                    final book = _trendingBooks[index];
                    return GestureDetector(
                      onTap: () {
                        context.push(
                          '/discover/book_details',
                          extra: {
                            'title': book.title,
                            'author': book.author,
                            'color': book.color,
                          },
                        );
                      },
                      child: Container(
                        width: 140,
                        padding: const EdgeInsets.all(12),
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
                            Container(
                              height: 110,
                              width: double.infinity,
                              decoration: BoxDecoration(
                                color: book.color,
                                borderRadius: BorderRadius.circular(12),
                              ),
                              child: const Center(
                                child: Icon(
                                  Icons.auto_stories_rounded,
                                  color: Colors.white54,
                                  size: 36,
                                ),
                              ),
                            ),
                            const SizedBox(height: 12),
                            Text(
                              book.title,
                              style: TextStyle(
                                fontWeight: FontWeight.w700,
                                fontSize: 14,
                                color: textDark,
                                height: 1.2,
                              ),
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                            ),
                            const SizedBox(height: 4),
                            Text(
                              book.author,
                              style: TextStyle(color: textLight, fontSize: 12),
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            ),
                            const Spacer(),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Row(
                                  children: [
                                    const Icon(
                                      Icons.star_rounded,
                                      color: Color(0xFFF59E0B),
                                      size: 14,
                                    ),
                                    const SizedBox(width: 4),
                                    Text(
                                      book.rating.toString(),
                                      style: TextStyle(
                                        fontWeight: FontWeight.w700,
                                        fontSize: 12,
                                        color: textDark,
                                      ),
                                    ),
                                  ],
                                ),
                                Text(
                                  '\$${book.price}',
                                  style: TextStyle(
                                    fontWeight: FontWeight.w800,
                                    fontSize: 13,
                                    color: primaryColor,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                ),
              ),
            ),
            SliverToBoxAdapter(child: const SizedBox(height: 32)),

            // ── New Arrivals ──
            SliverToBoxAdapter(
              child: _SectionTitle(title: 'New Arrivals', textDark: textDark),
            ),
            SliverPadding(
              padding: const EdgeInsets.fromLTRB(24, 0, 24, 32),
              sliver: SliverList(
                delegate: SliverChildBuilderDelegate((context, index) {
                  final book = _newArrivals[index];
                  return GestureDetector(
                    onTap: () {
                      context.push(
                        '/discover/book_details',
                        extra: {
                          'title': book.title,
                          'author': book.author,
                          'color': book.color,
                        },
                      );
                    },
                    child: Container(
                      margin: const EdgeInsets.only(bottom: 16),
                      padding: const EdgeInsets.all(16),
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
                      child: Row(
                        children: [
                          Container(
                            height: 80,
                            width: 60,
                            decoration: BoxDecoration(
                              color: book.color,
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: const Center(
                              child: Icon(
                                Icons.auto_stories_rounded,
                                color: Colors.white54,
                                size: 24,
                              ),
                            ),
                          ),
                          const SizedBox(width: 16),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  book.title,
                                  style: TextStyle(
                                    fontWeight: FontWeight.w700,
                                    fontSize: 16,
                                    color: textDark,
                                  ),
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                ),
                                const SizedBox(height: 4),
                                Text(
                                  book.author,
                                  style: TextStyle(
                                    color: textLight,
                                    fontSize: 13,
                                  ),
                                ),
                                const SizedBox(height: 8),
                                Row(
                                  children: [
                                    const Icon(
                                      Icons.star_rounded,
                                      color: Color(0xFFF59E0B),
                                      size: 14,
                                    ),
                                    const SizedBox(width: 4),
                                    Text(
                                      book.rating.toString(),
                                      style: TextStyle(
                                        fontWeight: FontWeight.w700,
                                        fontSize: 12,
                                        color: textDark,
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                          IconButton(
                            onPressed: () {},
                            icon: const Icon(Icons.bookmark_border_rounded),
                            color: primaryColor,
                          ),
                        ],
                      ),
                    ),
                  );
                }, childCount: _newArrivals.length),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// ─── Section Title Widget ───

class _SectionTitle extends StatelessWidget {
  const _SectionTitle({required this.title, required this.textDark});
  final String title;
  final Color textDark;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(24, 0, 24, 16),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            title,
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w800,
              color: textDark,
            ),
          ),
          Icon(Icons.arrow_forward_rounded, color: textDark, size: 20),
        ],
      ),
    );
  }
}
