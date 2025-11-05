# ---- Without R Objects ----
cat("---- Without R Objects ----\n")

# Take user input
num1 <- as.numeric(readline(prompt = "Enter first number: "))
num2 <- as.numeric(readline(prompt = "Enter second number: "))

# Perform basic arithmetic operations
cat("Addition:", num1 + num2, "\n")
cat("Subtraction:", num1 - num2, "\n")
cat("Multiplication:", num1 * num2, "\n")
cat("Division:", num1 / num2, "\n\n")

# ---- With R Objects ----
cat("---- With R Objects ----\n")

a <- num1
b <- num2

cat("a =", a, "\n")
cat("b =", b, "\n")

cat("Addition (a + b):", a + b, "\n")
cat("Subtraction (a - b):", a - b, "\n")
cat("Multiplication (a * b):", a * b, "\n")
cat("Division (a / b):", a / b, "\n\n")

# ---- Mathematical Functions ----
cat("---- Mathematical Functions ----\n")

cat("Square root of 25:", sqrt(25), "\n")
cat("Natural log of 10:", log(10), "\n")
cat("Exponential of 2:", exp(2), "\n")
cat("Sine of pi/2:", sin(pi / 2), "\n")
cat("Cosine of 0:", cos(0), "\n")
