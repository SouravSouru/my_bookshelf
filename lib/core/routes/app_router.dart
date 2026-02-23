import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../features/auth/presentation/pages/login_page.dart';
import '../../features/discover/presentation/pages/book_details_page.dart';
import '../../features/discover/presentation/pages/category_books_page.dart';
import '../../features/discover/presentation/pages/discover_page.dart';
import '../../features/home/presentation/pages/home_page.dart';
import '../../features/library/presentation/pages/library_page.dart';
import '../../features/profile/presentation/pages/profile_page.dart';
import '../../features/shell/main_shell.dart';
import '../../features/splash/presentation/pages/splash_page.dart';

final appRouter = GoRouter(
  initialLocation: '/',
  routes: [
    // ── Standalone routes (no nav bar) ──────────────────────────────────────
    GoRoute(path: '/', builder: (context, state) => const SplashPage()),
    GoRoute(path: '/login', builder: (context, state) => const LoginPage()),

    // ── Stateful Shell: properly manages bottom nav tab state ────────────────
    StatefulShellRoute.indexedStack(
      builder: (context, state, navigationShell) {
        return MainShell(navigationShell: navigationShell);
      },
      branches: [
        StatefulShellBranch(
          routes: [
            GoRoute(
              path: '/home',
              builder: (context, state) => const HomePage(),
              routes: [
                GoRoute(
                  path: 'book_details',
                  builder: (context, state) {
                    final extra = state.extra as Map<String, dynamic>? ?? {};
                    return BookDetailsPage(
                      title: extra['title'] as String? ?? 'Unknown Book',
                      author: extra['author'] as String? ?? 'Unknown Author',
                      bookColor: extra['color'] as Color? ?? Colors.grey,
                    );
                  },
                ),
              ],
            ),
          ],
        ),
        StatefulShellBranch(
          routes: [
            GoRoute(
              path: '/library',
              builder: (context, state) => const LibraryPage(),
            ),
          ],
        ),
        StatefulShellBranch(
          routes: [
            GoRoute(
              path: '/discover',
              builder: (context, state) => const DiscoverPage(),
              routes: [
                GoRoute(
                  path: 'book_details',
                  builder: (context, state) {
                    final extra = state.extra as Map<String, dynamic>? ?? {};
                    return BookDetailsPage(
                      title: extra['title'] as String? ?? 'Unknown Book',
                      author: extra['author'] as String? ?? 'Unknown Author',
                      bookColor: extra['color'] as Color? ?? Colors.grey,
                    );
                  },
                ),
                GoRoute(
                  path: 'category',
                  builder: (context, state) {
                    final extra = state.extra as Map<String, dynamic>? ?? {};
                    return CategoryBooksPage(
                      categoryName: extra['name'] as String? ?? 'Category',
                      categoryColor: extra['color'] as Color? ?? Colors.grey,
                    );
                  },
                ),
              ],
            ),
          ],
        ),
        StatefulShellBranch(
          routes: [
            GoRoute(
              path: '/profile',
              builder: (context, state) => const ProfilePage(),
            ),
          ],
        ),
      ],
    ),
  ],
);
