import 'package:hauberk/src/engine.dart';
import 'package:hauberk/src/content.dart';

/// A benchmark that just repeatedly generates dungeons for running in a
/// profiler.

main() {
  var content = createContent();
  var save = new HeroSave("blah");

  while (true) {
    var watch = new Stopwatch();
    watch.start();

    // Generate a dungeon at each level.
    var count = 0;
    for (var i = 1; i <= Option.maxDepth; i++) {
      var game = new Game(content, save, 1);
      for (var _ in game.generate());

      // Read some bit of game data so the JIT doesn't optimize the whole
      // program away as dead code.
      if (game.hero.pos.x >= -1) count++;
    }

    watch.stop();
    print("Generated $count dungeons in ${watch.elapsedMilliseconds}ms");
  }
}
