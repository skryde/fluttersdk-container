#!/bin/bash

username=`docker info | grep -i username | awk -F ": " '{ print $2 }'`
if [[ -z $username ]]; then
	echo "You must login into Docker Hub Resgistry before continue..."
	exit 1
fi

image="fluttersdk"
imageName="$username/$image"

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

