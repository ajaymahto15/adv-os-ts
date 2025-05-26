# adv-os-ts
NPCI Bootcamp - Advanced OpenSource

This repository contains resources, scripts, and a sample web application for the Advanced OpenSource Bootcamp, focused on PostgreSQL performance analysis and hands-on system operations.

## Repository Structure

### clusterstorm/
- **buffer.sh**: SQL queries for analyzing PostgreSQL buffer/cache hit rates, with detailed comments for learning and troubleshooting.
- **commands.sh**: Useful shell commands and scripts for PostgreSQL and system-level analysis.
- **shared_buffers.sh**: Scripts for configuring and monitoring PostgreSQL shared buffers.

### mywebapp/
- **main.py**: Example Python web application (details in code comments).
- **Dockerfile**: Configuration for containerizing and running the web application with Docker.

## Getting Started

1. **PostgreSQL Analysis**
   - Navigate to the `clusterstorm/` directory.
   - Review and run the scripts in your PostgreSQL environment to analyze buffer usage and performance.
   - Each script contains comments explaining its purpose and usage.

2. **Sample Web Application**
   - Go to the `mywebapp/` directory.
   - Build and run the app using Docker:
     ```bash
     docker build -t mywebapp .
     docker run -p 8000:8000 mywebapp
     ```
   - Access the app at [http://localhost:8000](http://localhost:8000) (if applicable).

## Contributing
Feel free to fork this repository and submit pull requests for improvements, bug fixes, or additional scripts.

---

For more details on each script or application, refer to the comments within each file. If you have questions, please open an issue or contact the maintainers.
