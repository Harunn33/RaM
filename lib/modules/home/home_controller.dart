import 'package:get/get.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:rick_and_morty/shared/constants/api.dart';

class HomeController extends GetxController {
  RxList<dynamic> characters = [].obs;
  RxList<dynamic> charactersByIds = [].obs;
  Map<String, dynamic> info = {};
  RxBool loading = false.obs;
  RxInt counter = 1.obs;

  @override
  void onInit() async {
    super.onInit();
    await getAllResults();
    await getAllCharactersByIds();
  }

  Future<void> getAllCharactersByIds() async {
    loading.value = true;
    for (var i = 1; i <= characters.length; i++) {
      QueryResult querycharactersByIds = await Gql.qlClient.query(
        QueryOptions(
          document: gql(
            """query {
  charactersByIds(ids: $i) {
    location{
      name
      type
    }
    episode {
      id
      name
      episode
    }
  }
}""",
          ),
        ),
      );
      charactersByIds.addAll(querycharactersByIds.data!['charactersByIds']);
    }
    loading.value = false;
  }

  Future<void> getAllResults() async {
    loading.value = true;
    dynamic page = await getPages();
    for (var i = 1; i <= page; i++) {
      QueryResult queryResult = await Gql.qlClient.query(
        QueryOptions(
          document: gql(
            """query {
  characters(page:${i.toString()}) {
    results {
      id
      name
      image
      species
      status
      gender
    }
  }
}""",
          ),
        ),
      );
      characters.addAll(queryResult.data!['characters']['results']);
    }
    loading.value = false;
  }

  Future<dynamic> getPages() async {
    QueryResult queryResult = await Gql.qlClient.query(
      QueryOptions(
        document: gql(
          """query {
  characters {
    info {
      pages
    }
  }
}""",
        ),
      ),
    );
    info = queryResult.data!['characters']['info'];
    return info["pages"];
  }
}
