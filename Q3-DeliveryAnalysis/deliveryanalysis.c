#include <stdio.h>
#define MAX_ROUTES 100

int total_distance(const int distances[], int n) {
  int total = 0;
  int i;

  for (i = 0; i < n; i++) {
    total += distances[i];
  }
  return total;
}

int recursive_sum(const int distances[], int n) {
  if (n == 0) {
    return 0;
  }
  return distances[n - 1] + recursive_sum(distances, n - 1);
}

double average_distance(const int distances[], int n) {
  return (double)total_distance(distances, n) / n;
}

int longest_route(const int distances[], int n) {
  int longest = distances[0];
  int i;

  for (i = 1; i < n; i++) {
    if (distances[i] > longest) {
      longest = distances[i];
    }
  }
  return longest;
}

int count_above_limit(const int distances[], int n, int limit) {
  int count = 0;
  int i;

  for (i = 0; i < n; i++) {
    if (distances[i] > limit) {
      count++;
    }
  }
  return count;
}

int main() {
  int distances[MAX_ROUTES];
  int n;
  int limit;
  int i;
  int average_as_int;

  printf("|-|-|-|DELIVERY DISTANCE ANALYSIS|-|-|-|\n\n");

  printf("Number of routes: ");
  if (scanf("%d", &n) != 1 || n <= 0 || n > MAX_ROUTES) {
    printf("Error: number of routes must be between 1 and %d.\n", MAX_ROUTES);
    return 1;
  }

  printf("Enter the %d distances (whole km, separated by spaces): ", n);
  for (i = 0; i < n; i++) {
    if (scanf("%d", &distances[i]) != 1) {
      printf("Error: distance %d is not a whole number.\n", i + 1);
      return 1;
    }
  }

  printf("Distance limit: ");
  if (scanf("%d", &limit) != 1) {
    printf("Error: the limit must be a whole number.\n");
    return 1;
  }

  printf("\n");
  printf("Total distance: %d km\n", total_distance(distances, n));
  printf("Average distance: %.2f km\n", average_distance(distances, n));
  printf("Longest route: %d km\n", longest_route(distances, n));
  printf("Routes above %d km: %d\n", limit,
         count_above_limit(distances, n, limit));

  printf("\nRecursive sum: %d km\n", recursive_sum(distances, n));

  average_as_int = (int)average_distance(distances, n);
  printf("\n--- function reuse demonstration ---\n");
  printf(
      "count_above_limit() is called a second time, with a different limit\n");
  printf("(the average distance, %d km instead of %d km):\n", average_as_int,
         limit);
  printf("Routes above %d km: %d\n", average_as_int,
         count_above_limit(distances, n, average_as_int));

  return 0;
}