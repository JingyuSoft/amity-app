#!/bin/bash

cd `dirname $0`/../..
WORKING_DIR=`pwd`

if [ ! -d amity ]; then
	git clone https://github.com/JingyuSoft/amity.git
else
	cd amity
	git pull
fi

cd $WORKING_DIR

cp -fv amity/amity-app/thrift/authentication.h  amity-app/Amity/Service/Generated/Authentication.h
cp -fv amity/amity-app/thrift/authentication.m  amity-app/Amity/Service/Generated/Authentication.m
cp -fv amity/amity-app/thrift/itinerary.h  amity-app/Amity/Service/Generated/Itinerary.h
cp -fv amity/amity-app/thrift/itinerary.m  amity-app/Amity/Service/Generated/Itinerary.m
cp -fv amity/amity-app/thrift/refdata.h  amity-app/Amity/Service/Generated/RefData.h
cp -fv amity/amity-app/thrift/refdata.m  amity-app/Amity/Service/Generated/RefData.m

