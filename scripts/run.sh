#!/bin/bash -e

~/glslang/bin/glslangValidator -DWIDTH=$2 -DHEIGHT=$3 -DWORKGROUP_SIZE_X=$4 -DWORKGROUP_SIZE_Y=$5 --target-env vulkan1.2 -V $1 -o shaders/comp.spv

rm -f mandelbrot.png
ANV_ENABLE_PIPELINE_CACHE=0 MESA_GLSL_CACHE_DISABLE=1 CSV=1 mygl.sh $GDB ./vulkan_minimal_compute $2 $3 $4 $5
if [ ! -f mandelbrot.png ]; then
	echo "output file doesn't exist"
	exit 1
fi
