# Simple Git HTTP Server

This repository provides a Dockerized solution to host a Git HTTP server. It allows for basic Git operations over the HTTP protocol, such as push and pull. The server is lightweight and is intended for simple use cases where a full-fledged Git server is not required.

## Contents

The repository consists of two main files:

1. `Dockerfile`: Defines the Docker image that runs the Git HTTP server using Alpine Linux, Nginx, and `git-http-backend`.

2. `nginx.conf`: Configuration file for Nginx that sets up the necessary routing for Git operations.

## Getting Started

To get the Git HTTP server up and running, follow these steps:

1. **Build the Docker Image**: From the repository directory, build the Docker image using the following command:

   ```bash
   docker build -t simple-git-http-server .
   ```

2. **Run the Docker Container**: Start a container from the built image, mapping the desired host port to the container's port 80 and mounting the host directory where the Git repositories will be stored:

   ```bash
   docker run -d -p 4080:80 -v /path/to/host/gitdir:/git simple-git-http-server
   ```

   Replace `/path/to/host/gitdir` with the path to your desired directory on the host system.

3. **Initialize and Configure a Git Repository**: To create a new Git repository that can be accessed over HTTP, run:

   ```bash
   cd /path/to/host/gitdir
   git init --bare <repo>.git
   cd <repo>.git
   git config http.receivepack true
   ```

   Replace `<repo>.git` with your repository name.
   `git config http.receivepack true` is required to enable unauthenticated pushes to the repository.

4. **Access Repositories**: Your repositories will be accessible at `http://localhost:4080/git/<repo>.git`. Replace `<repo>.git` with your actual repository name.

## Notes

- This server uses `git-http-backend` to serve Git content. It supports both fetch and push operations over HTTP.
- The server does not include any form of authentication by default, meaning push operations are unrestricted.
- SSL is not configured, so all communication is unencrypted. 

## License

This project is open source and available under the [MIT License](LICENSE).
