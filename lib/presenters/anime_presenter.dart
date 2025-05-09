import 'package:aplication/models/anime_model.dart';
import 'package:aplication/network/base_network.dart';

abstract class AnimeView {
  void showloading();
  void hideloading();
  void showAnimeList(List<Anime> animeList);
  void showError(String message);
}

class AnimePresenter {
  final AnimeView view;
  AnimePresenter(this.view);

  Future<void> loadAnimeData(String endpoint) async {
    try {
      final List<dynamic> data = await BaseNetwork.getData(endpoint);
      final animeList = data.map((json) => Anime.fromJson(json)).toList();
      view.showAnimeList(animeList);
    } catch (e) {
      view.showError(e.toString());
    } finally {
      view.hideloading();
    }
  }
}
