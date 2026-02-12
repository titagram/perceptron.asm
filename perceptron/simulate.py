def perceptron_step(inputs, weights, bias):
    """
    Simulates the perceptron step function.
    inputs: list of (x1, x2)
    weights: (w1, w2)
    bias: scalar
    """
    results = []
    print(f"Weights: {weights}, Bias: {bias}")
    print("Simulating perceptron logic (OR gate configuration):")
    for x1, x2 in inputs:
        w1, w2 = weights
        weighted_sum = (x1 * w1) + (x2 * w2) + bias
        output = 1 if weighted_sum >= 0 else 0
        print(f"Inputs: ({x1}, {x2}) -> Sum: {weighted_sum} -> Output: {output}")
        results.append(output)
    return results

if __name__ == "__main__":
    # Matches the Assembly configuration
    inputs = [(0, 0), (0, 1), (1, 0), (1, 1)]
    weights = (1, 1)
    bias = -1

    expected_outputs = [0, 1, 1, 1] # OR gate

    outputs = perceptron_step(inputs, weights, bias)

    if outputs == expected_outputs:
        print("\nSUCCESS: Logic matches OR gate implementation.")
    else:
        print("\nFAILURE: Logic does not match OR gate implementation.")
        exit(1)
