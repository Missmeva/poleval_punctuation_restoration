# Base image with working GPU connection
FROM tensorflow/tensorflow:2.10.1-gpu-jupyter

# Install jupyter lab and resolve nbformat version issues
RUN pip install jupyterlab && pip install --upgrade nbformat

# Install graphviz to display DL models graph structure
RUN apt-get update && apt install graphviz -y

# Install additional requirements
ADD ./requirements_gpu.txt /home/requirements.txt
RUN pip install -r /home/requirements.txt

# Set entrypoint to jupyter lab
EXPOSE 8888
ENTRYPOINT ["jupyter", "lab", "--ip=0.0.0.0","--allow-root"]
