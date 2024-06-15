


class GlucEntity {
 final String id;
   final String measured_at;
    final num gluc;
    final meatDataEntity metaData;
  const GlucEntity({
    required this.id,
    required this.gluc,
    required this.measured_at,
    required this.metaData,
  });
}



class meatDataEntity {
  final String userId;
   final String note;
    final String type;
     final String unit;
  const meatDataEntity({
    required this.userId,
     required this.note,
      required this.type,
       required this.unit,
  });
}
