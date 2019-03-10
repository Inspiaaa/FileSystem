import Lib.FileSystem as FileSystem


x = FileSystem.FileBatch()
y = FileSystem.FileBatch()


# Collect batch
x @ "."

# Collapse
x << 0

# Move
x >> ".\\path\\"

# Find Duplicates
x * y

# Add
x + y

# Without Duplicates
x - y

# Without File Duplicates
x["-D"] - y
