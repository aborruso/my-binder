# Andy's Data Analysis Notebook

[![Binder](https://mybinder.org/badge_logo.svg)](https://mybinder.org/v2/gh/aborruso/my-binder/HEAD)
[![Docker Image Size](https://img.shields.io/docker/image-size/aborruso/data-analysis-env/latest?label=image%20size)](https://hub.docker.com/r/aborruso/data-analysis-env)
[![Data](https://img.shields.io/badge/Data-Open%20in%20Binder-blue?logo=database&logoColor=white)](https://mybinder.org/v2/gh/aborruso/my-binder/main?urlpath=git-pull%3Frepo%3Dhttps%253A%252F%252Fgithub.com%252Faborruso%252Fmy-binder-data%26urlpath%3Dlab%252Ftree%252Fmy-binder-data%252F%26branch%3Dmain)

## About this Environment

This project provides a comprehensive data analysis environment with two ways to run it:

1. **Binder** - Cloud-based, no installation required
2. **Docker** - Local container for better performance and customization

### Key Features:
- **Data Processing**: Tools for reading, extracting, and transforming structured data
- **Python Ecosystem**: Comprehensive Python data science stack (Pandas, NumPy, Matplotlib, etc.)
- **Geospatial Analysis**: GDAL, GeoPandas, and Shapely for working with geospatial data
- **Web Scraping**: BeautifulSoup, Selenium, and Requests for web data extraction
- **Data Visualization**: Multiple visualization libraries including Altair and Seaborn
- **Notebook Environment**: JupyterLab for interactive data exploration

## 1. Binder Environment

This Binder environment provides a ready-to-use workspace with a comprehensive set of tools for data analysis and manipulation. It's designed to be a versatile environment for working with structured data through both shell commands and Python scripts.

### What is Binder?
Binder is a service that allows you to create custom, shareable computing environments that can be accessed through a web browser. It uses Jupyter notebooks as the interface and can run code in multiple programming languages.

### How to Use Binder:
1. Click the "launch binder" badge above to start the environment
2. Wait for the environment to build (this may take a few minutes)
3. Use the JupyterLab interface to:
   - Create new Python notebooks
   - Open a terminal for shell commands
   - Upload and work with your data files
4. All tools are pre-installed and ready to use

## 2. Docker Environment

The Docker image is available on [Docker Hub](https://hub.docker.com/r/aborruso/data-analysis-env) and provides a local containerized environment.

### Using Pre-built Image
1. Pull the latest image:
   ```bash
   docker pull aborruso/data-analysis-env:latest
   ```
2. Run the container:
   ```bash
   docker run -p 8888:8888 -v $(pwd):/workspace aborruso/data-analysis-env
   ```
3. Access JupyterLab at http://localhost:8888

### Building Locally
1. Build the Docker image:
   ```bash
   docker build -t data-analysis-env .
   ```
2. Run the container:
   ```bash
   docker run -p 8888:8888 -v $(pwd):/workspace data-analysis-env
   ```
3. Access JupyterLab at http://localhost:8888
4. Your local files will be available in the /workspace directory

### Included Tools (Both Environments):
- Python 3.11 with data science packages
- Shell utilities for data processing
- Web scraping and API tools
- Geospatial analysis tools
- Data visualization libraries
- Notebook environment with JupyterLab
