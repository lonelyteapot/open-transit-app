class TransitRoute {
  const TransitRoute({
    required this.id,
    required this.name,
  });

  final String id;
  final String name;
}

class TransitRoutesRepository {
  Future<List<TransitRoute>> fetchRoutes() async {
    await Future.delayed(const Duration(seconds: 2));
    return [
      const TransitRoute(
        id: 'route1',
        name: 'Route 1',
      ),
      const TransitRoute(
        id: 'route2',
        name: 'Route 2',
      ),
      const TransitRoute(
        id: 'route3',
        name: 'Route 3',
      ),
      const TransitRoute(
        id: 'route4',
        name: 'Route 4',
      ),
      const TransitRoute(
        id: 'route5',
        name: 'Route 5',
      ),
    ];
  }
}
