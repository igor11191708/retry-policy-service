
# Use the official Swift image
FROM swift:latest

# Create a directory for the package
WORKDIR /package

# Copy the package files into the Docker image
COPY . .

# Build the package
RUN swift build

# Run the tests
CMD swift test
