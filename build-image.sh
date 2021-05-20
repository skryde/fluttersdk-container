#!/bin/bash

imageName="skryde/fluttersdk"

docker build --network=host -t $imageName .
if [[ $? -ne 0  ]]; then
	exit 1
fi

version=$(docker run $imageName flutter --version | grep "Flutter" | cut -d " " -f 2)
docker tag $imageName $imageName:$version

docker push -a $imageName
if [[ $? -ne 0  ]]; then
	exit 1
fi

