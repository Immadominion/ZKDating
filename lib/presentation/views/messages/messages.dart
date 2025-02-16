import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class Messages extends ConsumerWidget {
  const Messages({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.center,
            colors: [
              Colors.purple[900]!,
              Colors.purple[800]!,
              Colors.white,
              Colors.white,
            ],
            stops: const [0.0, 0.3, 0.3, 1.0],
          ),
        ),
        child: SafeArea(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildHeader(),
              const SizedBox(height: 24),
              _buildRecentMatches(),
              Expanded(
                child: Container(
                  decoration: const BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.vertical(
                      top: Radius.circular(30),
                    ),
                  ),
                  child: _buildMessagesList(),
                ),
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: _buildBottomNav(),
    );
  }

  Widget _buildHeader() {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.2),
              shape: BoxShape.circle,
            ),
            child: const Icon(
              Icons.arrow_back,
              color: Colors.white,
            ),
          ),
          const SizedBox(width: 16),
          const Text(
            'Messages',
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildRecentMatches() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Padding(
          padding: EdgeInsets.symmetric(horizontal: 16),
          child: Text(
            'Recent Matches',
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w500,
              color: Colors.white,
            ),
          ),
        ),
        const SizedBox(height: 16),
        SizedBox(
          height: 100,
          child: ListView(
            scrollDirection: Axis.horizontal,
            padding: const EdgeInsets.symmetric(horizontal: 16),
            children: [
              _buildRecentMatchItem(
                imageUrl: 'https://picsum.photos/200',
                showHeart: true,
                likes: '32',
              ),
              _buildRecentMatchItem(
                imageUrl: 'https://picsum.photos/201',
              ),
              _buildRecentMatchItem(
                imageUrl: 'https://picsum.photos/202',
              ),
              _buildRecentMatchItem(
                imageUrl: 'https://picsum.photos/203',
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildRecentMatchItem({
    required String imageUrl,
    bool showHeart = false,
    String? likes,
  }) {
    return Container(
      width: 80,
      margin: const EdgeInsets.only(right: 12),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        color: Colors.white,
      ),
      clipBehavior: Clip.hardEdge,
      child: Stack(
        fit: StackFit.expand,
        children: [
          Image.network(
            imageUrl,
            fit: BoxFit.cover,
          ),
          if (showHeart)
            Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    Colors.black.withOpacity(0.3),
                    Colors.transparent,
                  ],
                ),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Icon(
                    Icons.favorite,
                    color: Colors.white,
                    size: 24,
                  ),
                  Text(
                    likes!,
                    style: const TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
        ],
      ),
    );
  }

  Widget _buildMessagesList() {
    final messages = [
      Message(
        name: 'Alfredo Calzoni',
        message: 'What about that new jacket if I ...',
        time: '09:18',
        imageUrl: 'https://picsum.photos/204',
        isOnline: true,
      ),
      Message(
        name: 'Clara Hazel',
        message: 'I know right 😆',
        time: '12:44',
        imageUrl: 'https://picsum.photos/205',
        isOnline: true,
      ),
      Message(
        name: 'Brandon Aminoff',
        message: 'I\'ve already registered, can\'t wai...',
        time: '08:06',
        imageUrl: 'https://picsum.photos/206',
        isOnline: true,
      ),
      Message(
        name: 'Amina Mina',
        message: 'It will have two lines of heading ...',
        time: '09:32',
        imageUrl: 'https://picsum.photos/207',
        isOnline: false,
      ),
    ];

    return ListView.separated(
      padding: const EdgeInsets.all(16),
      itemCount: messages.length,
      separatorBuilder: (context, index) => const Divider(height: 32),
      itemBuilder: (context, index) => _buildMessageItem(messages[index]),
    );
  }

  Widget _buildMessageItem(Message message) {
    return Row(
      children: [
        Stack(
          children: [
            Container(
              width: 60,
              height: 60,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                image: DecorationImage(
                  image: NetworkImage(message.imageUrl),
                  fit: BoxFit.cover,
                ),
              ),
            ),
            if (message.isOnline)
              Positioned(
                right: 0,
                bottom: 0,
                child: Container(
                  width: 12,
                  height: 12,
                  decoration: BoxDecoration(
                    color: Colors.purple[300],
                    shape: BoxShape.circle,
                    border: Border.all(
                      color: Colors.white,
                      width: 2,
                    ),
                  ),
                ),
              ),
          ],
        ),
        const SizedBox(width: 16),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                message.name,
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 4),
              Text(
                message.message,
                style: TextStyle(
                  color: Colors.grey[600],
                  fontSize: 14,
                ),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
            ],
          ),
        ),
        const SizedBox(width: 8),
        Text(
          message.time,
          style: TextStyle(
            color: Colors.grey[500],
            fontSize: 12,
          ),
        ),
      ],
    );
  }

  Widget _buildBottomNav() {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: const BorderRadius.vertical(
          top: Radius.circular(30),
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 10,
          ),
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          const Icon(Icons.home_outlined),
          const Icon(Icons.explore_outlined),
          Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: Colors.purple[100],
              shape: BoxShape.circle,
            ),
            child: const Icon(Icons.add),
          ),
          const Icon(Icons.group_outlined),
          Icon(
            Icons.chat_bubble,
            color: Colors.purple[300],
          ),
        ],
      ),
    );
  }
}

class Message {
  final String name;
  final String message;
  final String time;
  final String imageUrl;
  final bool isOnline;

  Message({
    required this.name,
    required this.message,
    required this.time,
    required this.imageUrl,
    required this.isOnline,
  });
}
