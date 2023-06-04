import 'package:graphql_flutter/graphql_flutter.dart';

class Gql {
  static final HttpLink link = HttpLink("https://rickandmortyapi.com/graphql");
  static final GraphQLClient qlClient = GraphQLClient(
    link: Gql.link,
    cache: GraphQLCache(
      store: HiveStore(),
    ),
  );
}
