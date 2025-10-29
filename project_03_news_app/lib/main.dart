import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:url_launcher/url_launcher.dart';

void main() {
  runApp(const NewsApp());
}

class NewsApp extends StatelessWidget {
  const NewsApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'News Reader',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.red,
        useMaterial3: true,
      ),
      home: const NewsListScreen(),
    );
  }
}

class Article {
  final String title;
  final String description;
  final String url;
  final String? imageUrl;
  final String? author;
  final DateTime? publishedAt;
  final String? source;

  Article({
    required this.title,
    required this.description,
    required this.url,
    this.imageUrl,
    this.author,
    this.publishedAt,
    this.source,
  });

  factory Article.fromJson(Map<String, dynamic> json) {
    return Article(
      title: json['title'] ?? 'Không có tiêu đề',
      description: json['description'] ?? 'Không có mô tả',
      url: json['url'] ?? '',
      imageUrl: json['urlToImage'],
      author: json['author'],
      publishedAt: json['publishedAt'] != null
          ? DateTime.parse(json['publishedAt'])
          : null,
      source: json['source']?['name'],
    );
  }
}

class NewsService {
  // Thay YOUR_API_KEY bằng API key của bạn từ newsapi.org
  static const String apiKey = '6b7a7c2fb73842929110bdd62527ee78';
  static const String baseUrl = 'https://newsapi.org/v2';

  Future<List<Article>> fetchTopHeadlines({String country = 'us'}) async {
    try {
      final response = await http.get(
        Uri.parse('$baseUrl/top-headlines?country=$country&apiKey=$apiKey'),
      );

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        final articles = (data['articles'] as List)
            .map((article) => Article.fromJson(article))
            .toList();
        return articles;
      } else {
        throw Exception('Không thể tải tin tức');
      }
    } catch (e) {
      throw Exception('Lỗi: $e');
    }
  }

  Future<List<Article>> searchNews(String query) async {
    try {
      final response = await http.get(
        Uri.parse('$baseUrl/everything?q=$query&apiKey=$apiKey'),
      );

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        final articles = (data['articles'] as List)
            .map((article) => Article.fromJson(article))
            .toList();
        return articles;
      } else {
        throw Exception('Không thể tìm kiếm tin tức');
      }
    } catch (e) {
      throw Exception('Lỗi: $e');
    }
  }

  // Demo data khi không có API key
  Future<List<Article>> fetchDemoNews() async {
    await Future.delayed(const Duration(seconds: 1));
    return [
      Article(
        title: 'Flutter 3.0 ra mắt với nhiều tính năng mới',
        description:
            'Google công bố Flutter 3.0 với hỗ trợ toàn diện cho macOS, Linux và cải thiện hiệu suất.',
        url: 'https://flutter.dev',
        imageUrl: 'https://picsum.photos/400/200?random=1',
        author: 'Flutter Team',
        publishedAt: DateTime.now().subtract(const Duration(hours: 2)),
        source: 'Flutter Blog',
      ),
      Article(
        title: 'Dart 3.0 giới thiệu Sound Null Safety',
        description:
            'Phiên bản mới nhất của Dart mang đến tính năng null safety hoàn chỉnh.',
        url: 'https://dart.dev',
        imageUrl: 'https://picsum.photos/400/200?random=2',
        author: 'Dart Team',
        publishedAt: DateTime.now().subtract(const Duration(hours: 5)),
        source: 'Dart News',
      ),
      Article(
        title: 'Xu hướng phát triển Mobile App 2024',
        description:
            'Khám phá những xu hướng mới nhất trong phát triển ứng dụng di động.',
        url: 'https://example.com',
        imageUrl: 'https://picsum.photos/400/200?random=3',
        author: 'Tech Writer',
        publishedAt: DateTime.now().subtract(const Duration(days: 1)),
        source: 'Tech News',
      ),
      Article(
        title: 'State Management trong Flutter',
        description:
            'So sánh các giải pháp state management phổ biến: Provider, Bloc, Riverpod.',
        url: 'https://example.com',
        imageUrl: 'https://picsum.photos/400/200?random=4',
        author: 'Flutter Dev',
        publishedAt: DateTime.now().subtract(const Duration(days: 2)),
        source: 'Dev Community',
      ),
      Article(
        title: 'Firebase và Flutter: Tích hợp hoàn hảo',
        description:
            'Hướng dẫn tích hợp Firebase với Flutter cho các ứng dụng thời gian thực.',
        url: 'https://example.com',
        imageUrl: 'https://picsum.photos/400/200?random=5',
        author: 'Backend Expert',
        publishedAt: DateTime.now().subtract(const Duration(days: 3)),
        source: 'Firebase Blog',
      ),
    ];
  }
}

class NewsListScreen extends StatefulWidget {
  const NewsListScreen({super.key});

  @override
  State<NewsListScreen> createState() => _NewsListScreenState();
}

class _NewsListScreenState extends State<NewsListScreen> {
  final NewsService _newsService = NewsService();
  final TextEditingController _searchController = TextEditingController();
  late Future<List<Article>> _newsFuture;
  bool _isSearching = false;

  @override
  void initState() {
    super.initState();
    _newsFuture = _newsService.fetchTopHeadlines(country: 'us');
  }

  void _refreshNews() {
    setState(() {
      if (_isSearching && _searchController.text.trim().isNotEmpty) {
        _newsFuture = _newsService.searchNews(_searchController.text.trim());
      } else {
        _newsFuture = _newsService.fetchTopHeadlines(country: 'us');
      }
    });
  }

  void _searchNews() {
    if (_searchController.text.trim().isEmpty) return;
    setState(() {
      _isSearching = true;
      _newsFuture = _newsService.searchNews(_searchController.text.trim());
    });
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: _isSearching
            ? TextField(
                controller: _searchController,
                decoration: const InputDecoration(
                  hintText: 'Tìm kiếm tin tức...',
                  border: InputBorder.none,
                  hintStyle: TextStyle(color: Colors.white70),
                ),
                style: const TextStyle(color: Colors.white),
                autofocus: true,
                onSubmitted: (_) => _searchNews(),
              )
            : const Text('Tin tức'),
        actions: [
          IconButton(
            icon: Icon(_isSearching ? Icons.close : Icons.search),
            onPressed: () {
              setState(() {
                if (_isSearching) {
                  _isSearching = false;
                  _searchController.clear();
                  _newsFuture = _newsService.fetchTopHeadlines(country: 'us');
                } else {
                  _isSearching = true;
                }
              });
            },
          ),
        ],
      ),
      body: FutureBuilder<List<Article>>(
        future: _newsFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }

          if (snapshot.hasError) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Icon(
                    Icons.error_outline,
                    size: 60,
                    color: Colors.red,
                  ),
                  const SizedBox(height: 16),
                  Text(
                    'Lỗi: ${snapshot.error}',
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 16),
                  ElevatedButton(
                    onPressed: _refreshNews,
                    child: const Text('Thử lại'),
                  ),
                ],
              ),
            );
          }

          if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return const Center(
              child: Text('Không có tin tức nào'),
            );
          }

          final articles = snapshot.data!;

          return RefreshIndicator(
            onRefresh: () async {
              _refreshNews();
            },
            child: ListView.builder(
              itemCount: articles.length,
              padding: const EdgeInsets.all(8),
              itemBuilder: (context, index) {
                final article = articles[index];
                return ArticleCard(
                  article: article,
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) =>
                            ArticleDetailScreen(article: article),
                      ),
                    );
                  },
                );
              },
            ),
          );
        },
      ),
    );
  }
}

class ArticleCard extends StatelessWidget {
  final Article article;
  final VoidCallback onTap;

  const ArticleCard({
    super.key,
    required this.article,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.only(bottom: 12),
      clipBehavior: Clip.antiAlias,
      child: InkWell(
        onTap: onTap,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (article.imageUrl != null)
              Image.network(
                article.imageUrl!,
                height: 200,
                width: double.infinity,
                fit: BoxFit.cover,
                errorBuilder: (context, error, stackTrace) {
                  return Container(
                    height: 200,
                    color: Colors.grey[300],
                    child: const Icon(Icons.image_not_supported, size: 50),
                  );
                },
              ),
            Padding(
              padding: const EdgeInsets.all(12),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  if (article.source != null)
                    Text(
                      article.source!,
                      style: TextStyle(
                        color: Colors.red[700],
                        fontWeight: FontWeight.bold,
                        fontSize: 12,
                      ),
                    ),
                  const SizedBox(height: 4),
                  Text(
                    article.title,
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 8),
                  Text(
                    article.description,
                    style: TextStyle(
                      color: Colors.grey[600],
                      fontSize: 14,
                    ),
                    maxLines: 3,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 8),
                  Row(
                    children: [
                      if (article.author != null) ...[
                        const Icon(Icons.person, size: 14),
                        const SizedBox(width: 4),
                        Expanded(
                          child: Text(
                            article.author!,
                            style: const TextStyle(fontSize: 12),
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                      ],
                      if (article.publishedAt != null) ...[
                        const SizedBox(width: 8),
                        const Icon(Icons.access_time, size: 14),
                        const SizedBox(width: 4),
                        Text(
                          _formatTime(article.publishedAt!),
                          style: const TextStyle(fontSize: 12),
                        ),
                      ],
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  String _formatTime(DateTime dateTime) {
    final now = DateTime.now();
    final difference = now.difference(dateTime);

    if (difference.inDays > 0) {
      return '${difference.inDays} ngày trước';
    } else if (difference.inHours > 0) {
      return '${difference.inHours} giờ trước';
    } else {
      return '${difference.inMinutes} phút trước';
    }
  }
}

class ArticleDetailScreen extends StatelessWidget {
  final Article article;

  const ArticleDetailScreen({super.key, required this.article});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Chi tiết'),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (article.imageUrl != null)
              Image.network(
                article.imageUrl!,
                height: 250,
                width: double.infinity,
                fit: BoxFit.cover,
                errorBuilder: (context, error, stackTrace) {
                  return Container(
                    height: 250,
                    color: Colors.grey[300],
                    child: const Icon(Icons.image_not_supported, size: 50),
                  );
                },
              ),
            Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  if (article.source != null)
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 12,
                        vertical: 6,
                      ),
                      decoration: BoxDecoration(
                        color: Colors.red[700],
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Text(
                        article.source!,
                        style: const TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 12,
                        ),
                      ),
                    ),
                  const SizedBox(height: 12),
                  Text(
                    article.title,
                    style: const TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 12),
                  Row(
                    children: [
                      if (article.author != null) ...[
                        const Icon(Icons.person, size: 16),
                        const SizedBox(width: 4),
                        Text(article.author!),
                      ],
                      if (article.publishedAt != null) ...[
                        const SizedBox(width: 16),
                        const Icon(Icons.access_time, size: 16),
                        const SizedBox(width: 4),
                        Text(_formatDate(article.publishedAt!)),
                      ],
                    ],
                  ),
                  const Divider(height: 32),
                  Text(
                    article.description,
                    style: const TextStyle(
                      fontSize: 16,
                      height: 1.6,
                    ),
                  ),
                  const SizedBox(height: 24),
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton.icon(
                      onPressed: () async {
                        final Uri url = Uri.parse(article.url);
                        if (await canLaunchUrl(url)) {
                          await launchUrl(url, mode: LaunchMode.externalApplication);
                        }
                      },
                      icon: const Icon(Icons.open_in_browser),
                      label: const Text('Đọc bài viết đầy đủ'),
                      style: ElevatedButton.styleFrom(
                        padding: const EdgeInsets.all(16),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  String _formatDate(DateTime dateTime) {
    return '${dateTime.day}/${dateTime.month}/${dateTime.year}';
  }
}
