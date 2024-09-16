# Use Ubuntu LTS as the base image
FROM ubuntu:22.04

# Avoid prompts from apt
ENV DEBIAN_FRONTEND=noninteractive

# Update the package lists and install required packages
RUN apt-get update && apt-get install -y \
    bison \
    flex \
    gcc \
    make \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/*

# Set the working directory
WORKDIR /app

# Copy all files from the current directory to the container
COPY ./interpreter /app/
COPY ./interpreter/data.txt /app/

# Run make clean and then make
RUN make clean && make VERBOSE=1

# Run the interpreter with data.txt as input during build
RUN ./interpreter < data.txt

# Command to run when the container starts
CMD ["sh", "-c", "./interpreter < data.txt && tail -f /dev/null"]