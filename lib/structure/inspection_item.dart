class InspectionItem {
  //This is the basic structure to store score and remarks given to each coach c1 , b1 ,u1
  final String id;
  int score;
  String remarks;

  InspectionItem({required this.id, this.score = 0, this.remarks = ''});

  Map<String, dynamic> toJson() => {
        'score': score,
        'remarks': remarks,
      }; //stores in a json object that goes to the mock endpoint
}
