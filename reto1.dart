void main() {
  var ages = [33, 15, 27, 40, 22];
  ages.sort();
  print('La edad mayor es: ${ages.last}');
  print('La edad menor es: ${ages.first}');
  var avg = ages.reduce((value, element) => value + element) / ages.length;
  print('La edad promedio es: ${avg}');
}
