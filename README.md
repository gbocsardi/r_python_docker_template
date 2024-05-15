# r_python_docker_template

This repository is a template for creating a Dockerized development environment that includes the latest versions of Python and R, along with RStudio Server. It is designed to facilitate mixed-language projects and make development easier and more reproducible.

## Getting Started

### Prerequisites

- Docker
- Visual Studio Code
- Remote - Containers Extension for VS Code

### Setup

1. Clone this repository:
    ```sh
    git clone https://github.com/gbocsardi/r_python_docker_template.git
    cd r_python_docker_template
    ```

2. Build container:
```sh
    docker build -t python-r-env --platform linux/amd64 .
```

3. Run the container manually:
```sh
docker run --platform linux/amd64 -it --rm \         
    -v $(pwd)/data:/workspace/data \
    -v $(pwd)/code:/workspace/code \
    -p 8787:8787 \
    -p 8888:8888 \
    python-r-env
```
### Usage

**Make sure your container is running!**

#### VS Code for Python
1. Open VS Code, and hit CMD+Shift+P to open the command palette.
2. Seach for "Dev Containers: Attach to Running Container..."
3. From the opened context menu select your container.
4. You're in your `workspace` directory, the parent directory of `code/` and `data/`.

#### RStudio Server for R

- You can access RStudio Server at `http://localhost:8787`.
- Login credentials are `rstudio` for both username and password (without quotes).
- You're in your `workspace` directory, the parent directory of `code/` and `data/`.

#### Jupyter Notebook
- You can access Jupyter Notebook at `http://localhost:8888`. 
- The access credentials are disabled in the `supervisord.conf` file. You can enable it by removing the `--NotebookApp.token=''` and `--NotebookApp.password=''` flag from the `supervisord.conf` file.

### Customization

- **Adding Python Packages**: Update the `requirements.txt` file with the required packages.
- **Adding R Packages**: Update the `install_packages.R` file with the required packages.


# On Windows (UNTESTED)
Delete the `--platform linux/amd64` flag from the `docker run` command.
Delete the below from the `devcontainer.json` file:
```sh
"options": [
            "--platform=linux/amd64"
        ]
```