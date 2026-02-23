import 'package:flutter/material.dart';

// ─── Sample Data ──────────────────────────────────────────────────────────────

class _LibraryBook {
  const _LibraryBook({
    required this.title,
    required this.author,
    required this.color,
    required this.progress,
  });
  final String title;
  final String author;
  final Color color;
  final double progress; // 0.0 to 1.0
}

const _allBooks = [
  _LibraryBook(
    title: 'Frankenstein',
    author: 'Mary Shelley',
    color: Color(0xFF1E293B), // Dark Slate
    progress: 0.45,
  ),
  _LibraryBook(
    title: 'Ficciones',
    author: 'Anaich',
    color: Color(0xFF0F766E), // Teal
    progress: 0.65,
  ),
  _LibraryBook(
    title: 'The Book Thief',
    author: 'Riemeery',
    color: Color(0xFFD97706), // Amber
    progress: 0.1,
  ),
  _LibraryBook(
    title: 'Circe',
    author: 'Rieemspt',
    color: Color(0xFF4338CA), // Indigo
    progress: 1.0,
  ),
  _LibraryBook(
    title: 'The Midnight Library',
    author: 'Riersent',
    color: Color(0xFF0369A1), // Sky
    progress: 1.0,
  ),
  _LibraryBook(
    title: 'Wuthering Heights',
    author: 'Nersoart',
    color: Color(0xFFB91C1C), // Red
    progress: 0.0,
  ),
];

// ─── Library Page ─────────────────────────────────────────────────────────────

class LibraryPage extends StatefulWidget {
  const LibraryPage({super.key});

  @override
  State<LibraryPage> createState() => _LibraryPageState();
}

class _LibraryPageState extends State<LibraryPage> {
  final Color bgColor = const Color(0xFFF6F8FA);
  final Color textDark = const Color(0xFF1A1A2C);
  final Color textLight = const Color(0xFF9CA3AF);
  final Color primaryColor = const Color(0xFF5E48E8);

  int _selectedTabIndex = 0;
  final List<String> _tabs = ['All Books', 'Reading', 'Completed'];

  List<_LibraryBook> get _filteredBooks {
    if (_selectedTabIndex == 1) {
      return _allBooks.where((b) => b.progress > 0 && b.progress < 1).toList();
    } else if (_selectedTabIndex == 2) {
      return _allBooks.where((b) => b.progress == 1.0).toList();
    }
    return _allBooks;
  }

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
                      'My Books',
                      style: TextStyle(
                        fontSize: 30,
                        fontWeight: FontWeight.w900,
                        color: textDark,
                        letterSpacing: -0.5,
                      ),
                    ),
                    IconButton(
                      onPressed: () {},
                      style: IconButton.styleFrom(
                        backgroundColor: Colors.white,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                      icon: const Icon(Icons.add, color: Color(0xFF1A1A2C)),
                    ),
                  ],
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
                            hintText: 'Search in library...',
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
                      Icon(Icons.tune_rounded, color: textLight, size: 20),
                    ],
                  ),
                ),
              ),
            ),
            SliverToBoxAdapter(child: const SizedBox(height: 24)),

            // ── Tabs ──
            SliverToBoxAdapter(
              child: SizedBox(
                height: 40,
                child: ListView.separated(
                  padding: const EdgeInsets.symmetric(horizontal: 24),
                  scrollDirection: Axis.horizontal,
                  itemCount: _tabs.length,
                  separatorBuilder: (_, __) => const SizedBox(width: 12),
                  itemBuilder: (context, index) {
                    final isSelected = _selectedTabIndex == index;
                    return GestureDetector(
                      onTap: () {
                        setState(() {
                          _selectedTabIndex = index;
                        });
                      },
                      child: AnimatedContainer(
                        duration: const Duration(milliseconds: 250),
                        padding: const EdgeInsets.symmetric(horizontal: 20),
                        decoration: BoxDecoration(
                          color: isSelected ? textDark : Colors.transparent,
                          borderRadius: BorderRadius.circular(20),
                          border: isSelected
                              ? null
                              : Border.all(color: const Color(0xFFE2E8F0)),
                        ),
                        alignment: Alignment.center,
                        child: Text(
                          _tabs[index],
                          style: TextStyle(
                            color: isSelected ? Colors.white : textLight,
                            fontWeight: isSelected
                                ? FontWeight.bold
                                : FontWeight.w600,
                            fontSize: 14,
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ),
            ),
            SliverToBoxAdapter(child: const SizedBox(height: 24)),

            // ── Grid of Books ──
            SliverPadding(
              padding: const EdgeInsets.fromLTRB(24, 0, 24, 32),
              sliver: SliverGrid(
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  mainAxisSpacing: 20,
                  crossAxisSpacing: 16,
                  childAspectRatio: 0.58, // Adjust based on card height
                ),
                delegate: SliverChildBuilderDelegate((context, index) {
                  final book = _filteredBooks[index];
                  return _LibraryBookCard(
                    book: book,
                    textDark: textDark,
                    textLight: textLight,
                    primaryColor: primaryColor,
                  );
                }, childCount: _filteredBooks.length),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// ─── Book Card Widget ─────────────────────────────────────────────────────────

class _LibraryBookCard extends StatelessWidget {
  const _LibraryBookCard({
    required this.book,
    required this.textDark,
    required this.textLight,
    required this.primaryColor,
  });

  final _LibraryBook book;
  final Color textDark;
  final Color textLight;
  final Color primaryColor;

  @override
  Widget build(BuildContext context) {
    return Container(
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
      padding: const EdgeInsets.all(12),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: Container(
              width: double.infinity,
              decoration: BoxDecoration(
                color: book.color,
                borderRadius: BorderRadius.circular(12),
              ),
              child: const Center(
                child: Icon(
                  Icons.auto_stories_rounded,
                  color: Colors.white54,
                  size: 40,
                ),
              ),
            ),
          ),
          const SizedBox(height: 16),
          Text(
            book.title,
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 16,
              color: textDark,
              height: 1.2,
            ),
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
          ),
          const SizedBox(height: 4),
          Text(
            book.author,
            style: TextStyle(color: textLight, fontSize: 13),
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
          const SizedBox(height: 12),
          if (book.progress == 1.0)
            Row(
              children: [
                Icon(Icons.check_circle_rounded, color: primaryColor, size: 16),
                const SizedBox(width: 4),
                Text(
                  'Completed',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 12,
                    color: primaryColor,
                  ),
                ),
              ],
            )
          else ...[
            Text(
              '${(book.progress * 100).toInt()}% Read',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 12,
                color: textDark,
              ),
            ),
            const SizedBox(height: 6),
            ClipRRect(
              borderRadius: BorderRadius.circular(4),
              child: LinearProgressIndicator(
                value: book.progress,
                minHeight: 6,
                backgroundColor: const Color(0xFFEAEAEA),
                valueColor: AlwaysStoppedAnimation<Color>(primaryColor),
              ),
            ),
          ],
        ],
      ),
    );
  }
}
