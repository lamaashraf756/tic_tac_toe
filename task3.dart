void main(){
  for(int i=0 ; i<= 20 ; i++){
    print(i);
  }
  var foods = ["pizza", "burger", "rice", "apple", "banana"];

  for (var food in foods) {
    print(food);
  }

  List<int> numbers = [1, 2, 3, 4, 5, 6, 7, 8, 9, 10];
  for (int i = 1; i < numbers.length; i += 2) {
    print(numbers[i]);
  }
  int day = 3;

  switch (day) {
    case 1:
      print("Monday");
      break;
    case 2:
      print("Tuesday");
      break;
    case 3:
      print("Wednesday");
      break;
    case 4:
      print("Thursday");
      break;
    case 5:
      print("Friday");
      break;
    case 6:
      print("Saturday");
      break;
    case 7:
      print("Sunday");
      break;
 
  }
  List<int> no = [12, 45, 7, 23, 9];
  int biggest = no[0];

  for (int i = 1; i < no.length; i++) {
    if (no[i] > biggest) {
      biggest = no[i];
    }
  }

  print("Biggest no is: $biggest");


  int i = 0;

  while (i < 10) {
    print("Hello");
    i++;
  }
  List<String> students = ["Ali", "Mona", "Sara", "Omar", "Youssef"];

  for (int i = 0; i < students.length; i++) {
    switch (i) {
      case 0:
        print("First student: ${students[i]}");
        break;
      case 1:
        print("Second student: ${students[i]}");
        break;
      case 2:
        print("Third student: ${students[i]}");
        break;
      case 3:
        print("Fourth student: ${students[i]}");
        break;
      case 4:
        print("Fifth student: ${students[i]}");
        break;
    }
  }

}
