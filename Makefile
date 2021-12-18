IMAGE := autoformer
ROOT := $(shell dirname $(realpath $(firstword ${MAKEFILE_LIST})))
PARENT_ROOT := $(shell dirname ${ROOT})
PORT := 8888

DOCKER_PARAMETERS := \
	--user $(shell id -u) \
	-v ${ROOT}:/app \
	-w /app \
	-e HOME=/tmp

init:
	docker build -t ${IMAGE} .

get_dataset:
	mkdir -p dataset/ && \
		wget -O dataset/datasets.zip "https://cloud.tsinghua.edu.cn/seafhttp/files/f7ec21ba-6b2b-4715-a4ee-f0b4022e3fec/all_six_datasets.zip" && \
		unzip dataset/datasets.zip -d dataset/ && \
		mv dataset/all_six_datasets/* dataset && \
		rm -r dataset/all_six_datasets dataset/__MACOSX 

jupyter:
	docker run -d --rm ${DOCKER_PARAMETERS} -e HOME=/tmp -p ${PORT}:8888 ${IMAGE} \
		bash -c "jupyter lab --ip=0.0.0.0 --no-browser --NotebookApp.token=''"

run_module: .require-module
	docker run -i --rm ${DOCKER_PARAMETERS} \
		${IMAGE} ${module}

bash_docker:
	docker run -it --rm ${DOCKER_PARAMETERS} ${IMAGE}

.require-module:
ifndef module
	$(error module is required)
endif
