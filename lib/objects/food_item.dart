class FoodItem {
  final int id;
  final String name;
  bool compare;
  void refreshCard;


  FoodItem({
    required this.id,
    required this.name,
    required this.compare
  });
  
  void setComapre(){
    if(compare){
      compare = false;
    }
    else{
      compare = true;
    }
  }
}
