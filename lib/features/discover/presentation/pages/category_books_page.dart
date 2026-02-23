import 'package:flutter/material.dart';

// ─── Dummy Model for Category Display ──────────────────────────────────────────
class _CatBook {
  const _CatBook({
    required this.title,
    required this.author,
    required this.color,
  });
  final String title;
  final String author;
  final Color color;
}

class CategoryBooksPage extends StatelessWidget {
  const CategoryBooksPage({
    super.key,
    required this.categoryName,
    required this.categoryColor,
  });

  final String categoryName;
  final Color categoryColor;

  @override
  Widget build(BuildContext context) {
    final textDark = const Color(0xFF1A1A2C);
    final textLight = const Color(0xFF9CA3AF);

    // Generate some dummy books specific to this category
    final _books = List.generate(
      8,
      (index) => _CatBook(
        title: '$categoryName Book ${index + 1}',
        author: 'Author ${index + 1}',
        color: index.isEven
            ? categoryColor
            : categoryColor.withValues(alpha: 0.7),
      ),
    );

    return Scaffold(
      backgroundColor: const Color(0xFFF6F8FA),
      body: SafeArea(
        child: CustomScrollView(
          slivers: [
            // ── App Bar ──
            SliverAppBar(
              backgroundColor: const Color(0xFFF6F8FA),
              elevation: 0,
              pinned: true,
              leading: IconButton(
                icon: const Icon(Icons.arrow_back_ios_new_rounded),
                color: textDark,
                onPressed: () => Navigator.of(context).pop(),
              ),
              centerTitle: true,
              title: Text(
                categoryName,
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w800,
                  color: textDark,
                ),
              ),
              actions: [
                IconButton(
                  icon: const Icon(Icons.filter_list_rounded),
                  color: textDark,
                  onPressed: () {},
                ),
              ],
            ),

            SliverToBoxAdapter(child: const SizedBox(height: 16)),

            // ── Grid of Books ──
            SliverPadding(
              padding: const EdgeInsets.fromLTRB(24, 0, 24, 32),
              sliver: SliverGrid(
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  mainAxisSpacing: 20,
                  crossAxisSpacing: 16,
                  childAspectRatio: 0.62,
                ),
                delegate: SliverChildBuilderDelegate((context, index) {
                  final book = _books[index];
                  return GestureDetector(
                    onTap: () {
                      // Normally context.push('/discover/book_details', extra: ...)
                    },
                    child: Container(
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
                        ],
                      ),
                    ),
                  );
                }, childCount: _books.length),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
