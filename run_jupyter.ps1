$CONTAINER="inl_poleval_project"
(docker stop $CONTAINER) 2> $null

docker run `
    --name $CONTAINER `
    --rm `
    --gpus all `
    -p 8888:8888 `
    -v "${PWD}:/tf/workdir" `
    --user root `
    inl_poleval_jupyter_img/tensorflow:2.10.1-gpu-jupyterlab
