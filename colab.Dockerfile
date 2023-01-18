# Base image with working GPU connection and jupyter lab
FROM inl_poleval_jupyter_img/tensorflow:2.10.1-gpu-jupyterlab

# Install jupyter_http_over_ws and enable it
RUN pip install --upgrade nbformat jupyter_http_over_ws>=0.0.7 \
&& jupyter serverextension enable --py jupyter_http_over_ws

# Install opencv dependencies
RUN apt-get install ffmpeg libsm6 libxext6 -y

# Install additional requirements
ADD ./requirements_general.txt /home/requirements.txt
RUN pip install -r /home/requirements.txt

COPY . .

RUN python download_model.py pl

# # Set entrypoint to jupyter notebook allowing access from colab
EXPOSE 8888
ENTRYPOINT ["jupyter", "notebook", "--ip=0.0.0.0","--allow-root","--NotebookApp.allow_origin=https://colab.research.google.com"]
