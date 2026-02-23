import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

// ─── Sample Data ──────────────────────────────────────────────────────────────

class _Book {
  const _Book({
    required this.title,
    required this.author,
    required this.color,
    this.rating = 0.0,
    this.progress = 0.0,
    this.isFullCoverCard = false,
  });
  final String title;
  final String author;
  final Color color;
  final double rating;
  final double progress;
  final bool isFullCoverCard;
}

const _currentlyReading = [
  _Book(
    title: 'Frankenstein',
    author: 'Mary Shelley',
    color: Color(0xFF1E293B), // Dark Slate
    isFullCoverCard: true,
  ),
  _Book(
    title: 'Ficciones',
    author: 'Anaich',
    color: Color(0xFF0F766E), // Teal
    progress: 0.65,
  ),
];

const _recentReleases = [
  _Book(
    title: 'The Book Thief',
    author: 'Riemeery',
    rating: 4.0,
    color: Color(0xFFD97706),
  ), // Amber
  _Book(
    title: 'Circe',
    author: 'Rieemspt',
    rating: 4.0,
    color: Color(0xFF4338CA),
  ), // Indigo
  _Book(
    title: 'The Midnight Library',
    author: 'Riersent',
    rating: 4.0,
    color: Color(0xFF0369A1),
  ), // Sky
  _Book(
    title: 'Wuthering Heights',
    author: 'Nersoart',
    rating: 4.0,
    color: Color(0xFFB91C1C),
  ), // Red
];

const _popularBooks = [
  _Book(
    title: 'Project Hail Mary',
    author: 'Aontar/',
    color: Color(0xFF4338CA),
  ), // Indigo
  _Book(
    title: 'The Book Thief',
    author: 'Aosrat/)',
    color: Color(0xFFD97706),
  ), // Amber
  _Book(
    title: 'Educated',
    author: 'AwsTser}',
    color: Color(0xFF15803D),
  ), // Green
];

// ─── Home Page ────────────────────────────────────────────────────────────────

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  // Exact UI Colors from the provided image
  final Color bgColor = const Color(0xFFF6F8FA);
  final Color textDark = const Color(0xFF1A1A2C);
  final Color textLight = const Color(0xFF9CA3AF);
  final Color primaryColor = const Color(0xFF5E48E8); // Deep purple/indigo

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
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Hello, Sourav',
                      style: TextStyle(
                        fontSize: 30,
                        fontWeight: FontWeight.w900,
                        color: textDark,
                        letterSpacing: -0.5,
                      ),
                    ),
                    const CircleAvatar(
                      radius: 20,
                      backgroundColor: Color(0xFFE2E8F0),
                      child: Icon(Icons.person, color: Color(0xFF94A3B8)),
                    ),
                  ],
                ),
              ),
            ),
            SliverToBoxAdapter(child: const SizedBox(height: 20)),

            // ── Search Bar ──
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24),
                child: Container(
                  height: 48,
                  decoration: BoxDecoration(
                    color: const Color(0xFFEBEFF4), // Light blue-grey search bg
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
                            hintText: 'Search your next adventure...',
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
                    ],
                  ),
                ),
              ),
            ),
            SliverToBoxAdapter(child: const SizedBox(height: 28)),

            // ── Currently Reading ──
            SliverToBoxAdapter(
              child: _SectionTitle(
                title: 'Currently Reading',
                textDark: textDark,
              ),
            ),
            SliverToBoxAdapter(
              child: SizedBox(
                height: 260, // Increased height to avoid overflow
                child: ListView.separated(
                  padding: const EdgeInsets.symmetric(horizontal: 24),
                  scrollDirection: Axis.horizontal,
                  itemCount: _currentlyReading.length,
                  separatorBuilder: (_, __) => const SizedBox(width: 16),
                  itemBuilder: (context, index) {
                    final book = _currentlyReading[index];

                    // Card 1: Full Image Cover Layout
                    if (book.isFullCoverCard) {
                      return GestureDetector(
                        onTap: () {
                          context.push(
                            '/home/book_details',
                            extra: {
                              'title': book.title,
                              'author': book.author,
                              'color': book.color,
                            },
                          );
                        },
                        child: Container(
                          width: 170,
                          decoration: BoxDecoration(
                            color: book.color,
                            borderRadius: BorderRadius.circular(20),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black.withValues(alpha: 0.1),
                                blurRadius: 15,
                                offset: const Offset(0, 8),
                              ),
                            ],
                          ),
                          padding: const EdgeInsets.all(16),
                          child: const Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              Center(
                                child: Icon(
                                  Icons.menu_book_rounded,
                                  size: 48,
                                  color: Colors.white24,
                                ),
                              ),
                              Spacer(),
                              Text(
                                'FRANKENSTEIN',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 18,
                                ),
                              ),
                            ],
                          ),
                        ),
                      );
                    }

                    // Card 2: White Detailed Layout
                    return GestureDetector(
                      onTap: () {
                        context.push(
                          '/home/book_details',
                          extra: {
                            'title': book.title,
                            'author': book.author,
                            'color': book.color,
                          },
                        );
                      },
                      child: Container(
                        width: 170,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(20),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withValues(alpha: 0.04),
                              blurRadius: 15,
                              offset: const Offset(0, 8),
                            ),
                          ],
                        ),
                        padding: const EdgeInsets.all(16),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              height: 90,
                              width: double.infinity,
                              decoration: BoxDecoration(
                                color: book.color,
                                borderRadius: BorderRadius.circular(12),
                              ),
                              child: const Center(
                                child: Icon(
                                  Icons.auto_stories_rounded,
                                  color: Colors.white54,
                                  size: 32,
                                ),
                              ),
                            ),
                            const SizedBox(height: 16),
                            Text(
                              book.title,
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 18,
                                color: textDark,
                              ),
                            ),
                            const SizedBox(height: 4),
                            Text(
                              book.author,
                              style: TextStyle(color: textLight, fontSize: 13),
                            ),
                            const Spacer(),
                            Text(
                              '${(book.progress * 100).toInt()}% Read',
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 12,
                                color: textDark,
                              ),
                            ),
                            const SizedBox(height: 8),
                            ClipRRect(
                              borderRadius: BorderRadius.circular(4),
                              child: LinearProgressIndicator(
                                value: book.progress,
                                minHeight: 6,
                                backgroundColor: const Color(0xFFEAEAEA),
                                valueColor: AlwaysStoppedAnimation<Color>(
                                  primaryColor,
                                ),
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

            // ── Most Recent Releases ──
            SliverToBoxAdapter(child: const SizedBox(height: 12)),
            SliverToBoxAdapter(
              child: _SectionTitle(
                title: 'Most Recent Releases',
                textDark: textDark,
              ),
            ),
            SliverToBoxAdapter(
              child: SizedBox(
                height: 230, // Increased height to prevent overflow
                child: ListView.separated(
                  padding: const EdgeInsets.symmetric(horizontal: 24),
                  scrollDirection: Axis.horizontal,

                  itemCount: _recentReleases.length,
                  separatorBuilder: (_, __) => const SizedBox(width: 16),
                  itemBuilder: (context, index) {
                    final book = _recentReleases[index];
                    return GestureDetector(
                      onTap: () {
                        context.push(
                          '/home/book_details',
                          extra: {
                            'title': book.title,
                            'author': book.author,
                            'color': book.color,
                          },
                        );
                      },
                      child: Container(
                        width: 125,
                        padding: const EdgeInsets.all(12),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(16),
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
                            Center(
                              child: Container(
                                height: 80,
                                width: 56,
                                decoration: BoxDecoration(
                                  color: book.color,
                                  borderRadius: BorderRadius.circular(8),
                                ),
                                child: const Icon(
                                  Icons.book,
                                  color: Colors.white54,
                                  size: 24,
                                ),
                              ),
                            ),
                            const SizedBox(height: 12),
                            Text(
                              book.title,
                              style: TextStyle(
                                fontWeight: FontWeight.w700,
                                fontSize: 13,
                                color: textDark,
                                height: 1.2,
                              ),
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                            ),
                            const SizedBox(height: 4),
                            Text(
                              book.author,
                              style: TextStyle(color: textLight, fontSize: 11),
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            ),
                            const Spacer(),
                            Row(
                              children: List.generate(5, (starIndex) {
                                return Icon(
                                  Icons.star,
                                  size: 10,
                                  color: starIndex < book.rating
                                      ? const Color(
                                          0xFFD1D5DB,
                                        ) // Light grey stars in reference
                                      : Colors.transparent,
                                );
                              }),
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                ),
              ),
            ),

            // ── Popular Books ──
            SliverToBoxAdapter(child: const SizedBox(height: 12)),
            SliverToBoxAdapter(
              child: _SectionTitle(title: 'Popular Books', textDark: textDark),
            ),
            SliverToBoxAdapter(
              child: SizedBox(
                height: 250, // Increased height to prevent overflow
                child: ListView.separated(
                  padding: const EdgeInsets.fromLTRB(24, 0, 24, 32),
                  scrollDirection: Axis.horizontal,

                  itemCount: _popularBooks.length,
                  separatorBuilder: (_, __) => const SizedBox(width: 16),
                  itemBuilder: (context, index) {
                    final book = _popularBooks[index];
                    return GestureDetector(
                      onTap: () {
                        context.push(
                          '/home/book_details',
                          extra: {
                            'title': book.title,
                            'author': book.author,
                            'color': book.color,
                          },
                        );
                      },
                      child: Container(
                        width: 135,
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
                            Center(
                              child: Container(
                                height: 100,
                                width: 70,
                                decoration: BoxDecoration(
                                  color: book.color,
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                child: const Icon(
                                  Icons.auto_stories_rounded,
                                  color: Colors.white54,
                                  size: 32,
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
                          ],
                        ),
                      ),
                    );
                  },
                ),
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
      child: Text(
        title,
        style: TextStyle(
          fontSize: 18,
          fontWeight: FontWeight.w800,
          color: textDark,
        ),
      ),
    );
  }
}
