#include <stdio.h>

void discard_line(void) {
  int c;
  while ((c = getchar()) != '\n' && c != EOF) {
  }
}

int read_amount(const char *prompt, double *amount) {
  printf("%s", prompt);
  if (scanf("%lf", amount) != 1) {
    discard_line();
    printf("Transaction reject: amount must be a number\n");
    return 0;
  }
  return 1;
}

double deposit(double balance, int *deposit_count) {
  double amount;
  if (!read_amount("Enter deposit amount: ", &amount)) {
    return balance;
  }

  if (amount <= 0) {
    printf("Transaction rejected: deposit amount must be positive\n");
    return balance;
  }

  balance += amount;
  (*deposit_count)++;
  printf("Deposit successful.\n");
  printf("Current balance: %.0f RWF\n", balance);
  return balance;
}

double withdraw(double balance, int *withdrawal_count) {
  double amount;

  if (!read_amount("Enter withdrawal amount: ", &amount)) {
    return balance;
  }

  if (amount <= 0) {
    printf("Transaction rejected: withdrawal amount must be positive.\n");
    return balance;
  }

  if (amount > balance) {
    printf("Transaction rejected: Insufficient balance.\n");
    return balance;
  }

  balance -= amount;
  (*withdrawal_count)++;
  printf("Withdrawal successful.\n");
  printf("Current balance: %.0f RWF\n", balance);
  return balance;
}

int main() {
  double balance = 0.0;
  int deposit_count = 0;
  int withdrawal_count = 0;
  int choice;

  printf(" |-|-|-|MOBILE MONEY TRANSACTION SYSTEM|-|-|-|\n");
  printf("\n");
  printf("1. Deposit\n");
  printf("2. Withdraw\n");
  printf("3. Check Balance\n");
  printf("4. Transaction Summary\n");
  printf("5. Exit\n");

  while (1) {
    printf("\nEnter choice: ");

    if (scanf("%d", &choice) != 1) {
      discard_line();
      printf("Invalid choice. Please enter a number from 1 to 5.\n");
      continue;
    }

    switch (choice) {
    case 1:
      balance = deposit(balance, &deposit_count);
      break;

    case 2:
      balance = withdraw(balance, &withdrawal_count);
      break;

    case 3:
      printf("Current balance: %.0f RWF\n", balance);
      break;

    case 4:
      printf("Successful deposits:    %d\n", deposit_count);
      printf("Successful withdrawals: %d\n", withdrawal_count);
      break;

    case 5:
      printf("System terminated.\n");
      break;

    default:
      printf("Invalid choice. Please enter a number from 1 to 5.\n");
      continue;
    }

    if (choice == 5) {
      break;
    }
  }

  return 0;
}