
# Unification and Resolution Example
# Prove: Ram is Mortal

# Step 1: Knowledge Base
C1 = ["NOT Human(x)", "Mortal(x)"]
C2 = ["Human(Ram)"]

# Step 2: Goal
Goal = "Mortal(Ram)"

print("Knowledge Base:")
print("C1:", C1)
print("C2:", C2)
print("Goal:", Goal)

# Step 3: Unification
print("\n--- Unification ---")

substitution = {"x": "Ram"}
print("Substitution:", substitution)

# Apply substitution in C1
C1_new = ["NOT Human(Ram)", "Mortal(Ram)"]
print("After Unification:", C1_new)

# Step 4: Resolution
print("\n--- Resolution ---")

# Resolve NOT Human(Ram) with Human(Ram)
print("C1:", C1_new)
print("C2:", C2)

result = ["Mortal(Ram)"]
print("After First Resolution:", result)

# Resolve Mortal(Ram) with NOT Mortal(Ram)
negated_goal = "NOT Mortal(Ram)"

print("\nNegated Goal:", negated_goal)

# Final Resolution
if result[0] == "Mortal(Ram)" and negated_goal == "NOT Mortal(Ram)":
    print("After Second Resolution: Empty Clause (□)")
    print("\nRam is Mortal is PROVED!")
