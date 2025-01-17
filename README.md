# Andy's Data Analysis Notebook

[![Binder](https://mybinder.org/badge_logo.svg)](https://mybinder.org/v2/gh/aborruso/my-binder/HEAD)
[![Docker](https://img.shields.io/badge/Docker-Available-blue)](https://hub.docker.com/)

## About this Environment

This project provides two ways to run the data analysis environment:
1. **Binder** - Cloud-based, no installation required
2. **Docker** - Local container for better performance and customization

### Binder Environment

This Binder environment, created by Andrea Borruso, provides a ready-to-use workspace with a comprehensive set of tools for data analysis and manipulation. It's designed to be a versatile environment for working with structured data through both shell commands and Python scripts.

### Key Features:
- **Data Processing**: Tools for reading, extracting, and transforming structured data
- **Python Ecosystem**: Comprehensive Python data science stack (Pandas, NumPy, Matplotlib, etc.)
- **Geospatial Analysis**: GDAL, GeoPandas, and Shapely for working with geospatial data
- **Web Scraping**: BeautifulSoup, Selenium, and Requests for web data extraction
- **Data Visualization**: Multiple visualization libraries including Altair and Seaborn
- **Notebook Environment**: JupyterLab for interactive data exploration

### What is Binder?
Binder is a service that allows you to create custom, shareable computing environments that can be accessed through a web browser. It uses Jupyter notebooks as the interface and can run code in multiple programming languages.

### How to Use:

#### Binder
1. Click the "launch binder" badge above to start the environment
2. Wait for the environment to build (this may take a few minutes)
3. Use the JupyterLab interface to:
   - Create new Python notebooks
   - Open a terminal for shell commands
   - Upload and work with your data files
4. All tools are pre-installed and ready to use

#### Docker
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

### Included Tools:
- Python 3.11 with data science packages
- Shell utilities for data processing
- Web scraping and API tools
- Geospatial analysis tools
- Data visualization libraries
- Notebook environment with JupyterLab
