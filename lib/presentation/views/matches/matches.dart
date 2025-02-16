import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class PeopleMatch extends ConsumerWidget {
  const PeopleMatch({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      body: SafeArea(
        child: ListView(
          padding: const EdgeInsets.all(16),
          children: [
            _buildHeader(),
            const SizedBox(height: 24),
            _buildStatsSection(),
            const SizedBox(height: 32),
            _buildMatchesSection(),
          ],
        ),
      ),
      bottomNavigationBar: _buildBottomNav(),
    );
  }

  Widget _buildHeader() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Container(
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: Colors.grey[100],
            shape: BoxShape.circle,
          ),
          child: const Icon(Icons.arrow_back, size: 24),
        ),
        const Text(
          'Matches',
          style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
          ),
        ),
        Container(
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: Colors.grey[100],
            shape: BoxShape.circle,
          ),
          child: const Icon(Icons.tune, size: 24),
        ),
      ],
    );
  }

  Widget _buildStatsSection() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        _buildStatItem(icon: Icons.favorite, label: 'Likes', count: '32'),
        const SizedBox(width: 24),
        _buildStatItem(icon: Icons.chat_bubble, label: 'Connect', count: '15'),
      ],
    );
  }

  Widget _buildStatItem({
    required IconData icon,
    required String label,
    required String count,
  }) {
    return Column(
      children: [
        Container(
          width: 70,
          height: 70,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            border: Border.all(
              color: Colors.purple[100]!,
              width: 2,
            ),
          ),
          child: Icon(
            icon,
            color: Colors.purple[300],
            size: 30,
          ),
        ),
        const SizedBox(height: 8),
        RichText(
          text: TextSpan(
            style: const TextStyle(fontSize: 16),
            children: [
              TextSpan(
                text: '$label ',
                style: TextStyle(color: Colors.grey[800]),
              ),
              TextSpan(
                text: count,
                style: TextStyle(
                  color: Colors.purple[300],
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildMatchesSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        RichText(
          text: TextSpan(
            style: const TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: Colors.black,
            ),
            children: [
              const TextSpan(text: 'Your Matches '),
              TextSpan(
                text: '47',
                style: TextStyle(color: Colors.purple[300]),
              ),
            ],
          ),
        ),
        const SizedBox(height: 16),
        GridView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            childAspectRatio: 0.8,
            crossAxisSpacing: 16,
            mainAxisSpacing: 16,
          ),
          itemCount: 6,
          itemBuilder: (context, index) {
            final matches = [
              ('James', '20', 'HANOVER', '1.3', '100'),
              ('Eddie', '23', 'DORTMUND', '2', '94'),
              ('Brandon', '20', 'BERLIN', '2.5', '89'),
              ('Alfredo', '20', 'MUNICH', '2.5', '80'),
            ];
            if (index < matches.length) {
              return _buildMatchCard(
                name: matches[index].$1,
                age: matches[index].$2,
                location: matches[index].$3,
                distance: matches[index].$4,
                matchPercentage: matches[index].$5,
              );
            }
            return _buildMatchCard(
              name: 'User ${index + 1}',
              age: '20',
              location: 'GERMANY',
              distance: '3.0',
              matchPercentage: '75',
            );
          },
        ),
      ],
    );
  }

  Widget _buildMatchCard({
    required String name,
    required String age,
    required String location,
    required String distance,
    required String matchPercentage,
  }) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [
            Colors.purple[100]!.withOpacity(0.5),
            Colors.purple[900]!.withOpacity(0.8),
          ],
        ),
      ),
      child: Stack(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(20),
            child: Image.network(
              'https://picsum.photos/300/400',
              fit: BoxFit.cover,
              height: double.infinity,
              width: double.infinity,
            ),
          ),
          Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  Colors.transparent,
                  Colors.purple[900]!.withOpacity(0.8),
                ],
              ),
            ),
          ),
          Positioned(
            top: 12,
            left: 0,
            right: 0,
            child: Container(
              margin: const EdgeInsets.symmetric(horizontal: 12),
              padding: const EdgeInsets.symmetric(vertical: 6),
              decoration: BoxDecoration(
                color: Colors.purple[300],
                borderRadius: BorderRadius.circular(20),
              ),
              child: Text(
                '$matchPercentage% Match',
                textAlign: TextAlign.center,
                style: const TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
          Positioned(
            bottom: 12,
            left: 12,
            right: 12,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  '$distance km away',
                  style: const TextStyle(
                    color: Colors.white70,
                    fontSize: 12,
                  ),
                ),
                const SizedBox(height: 4),
                Row(
                  children: [
                    Text(
                      '$name, $age',
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(width: 4),
                    Container(
                      width: 8,
                      height: 8,
                      decoration: const BoxDecoration(
                        color: Colors.green,
                        shape: BoxShape.circle,
                      ),
                    ),
                  ],
                ),
                Text(
                  location,
                  style: const TextStyle(
                    color: Colors.white70,
                    fontSize: 12,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
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
          Icon(Icons.group, color: Colors.purple[300]),
          const Icon(Icons.chat_bubble_outline),
        ],
      ),
    );
  }
}
