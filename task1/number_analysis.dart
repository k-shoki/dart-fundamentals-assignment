// Task 1: Number Analysis App
// Name: Addis Ababa University Student  Place holder)
// Name : Kidist Beyene

// Finds the largest number in the list using a loop
int findMax(List<int> numbers) {
  int max = numbers[0];
  for (int n in numbers) {
    if (n > max) {
      max = n;
    }
  }
  return max;
}

// Finds the smallest number in the list using a loop
int findMin(List<int> numbers) {
  int min = numbers[0];
  for (int n in numbers) {
    if (n < min) {
      min = n;
    }
  }
  return min;
}

// Adds up all numbers using an accumulator
int calculateSum(List<int> numbers) {
  int sum = 0;
  for (int n in numbers) {
    sum = sum + n;
  }
  return sum;
}

// Calculates average by reusing calculateSum()
double calculateAverage(List<int> numbers) {
  int sum = calculateSum(numbers);
  return sum / numbers.length;
}

void main() {
  final numbers = <int>[34, -7, 89, 12, -45, 67, 3, 100, -2, 55];

  int max    = findMax(numbers);
  int min    = findMin(numbers);
  int sum    = calculateSum(numbers);
  double avg = calculateAverage(numbers);

  print('Number Analysis Results');
  print('========================');
  print('Numbers       : $numbers');
  print('Maximum value : $max');
  print('Minimum value : $min');
  print('Sum           : $sum');
  print('Average       : $avg');
}
