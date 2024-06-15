import 'package:flutter/material.dart';
import 'tile_utils.dart';
import 'tile_views.dart';
import 'tile_manager.dart';
import '../../services/medication.dart';
import 'package:provider/provider.dart';

class MedListTile extends StatelessWidget {
  final Medication medication;

  const MedListTile({Key? key, required this.medication}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => TileManager(),
      child: Consumer<TileManager>(
        builder: (context, tileManager, _) {
          final nextScheduledTime = findFirstScheduledTimeWithinNext12Hours(medication.scheduledTimes);
          final fillRatio = calculateFillRatio(nextScheduledTime);

          return GestureDetector(
            onLongPress: () {
              tileManager.toggleLongPress();
            },
            child: AnimatedSwitcher(
              duration: Duration(milliseconds: 300),
              child: tileManager.isInfoPressed
                  ? InfoView(medication: medication)
                  : tileManager.isEditPressed
                  ? ExpandedView(medication: medication)
                  : tileManager.isLongPressed
                  ? LongPressView(medication: medication)
                  : DefaultView(
                medication: medication,
                fillRatio: fillRatio,
                scheduleTime: nextScheduledTime,
              ),
            ),
          );
        },
      ),
    );
  }
}
