
cmake_minimum_required(VERSION 3.8 FATAL_ERROR)
project(print LANGUAGES CXX CUDA)

enable_language(CUDA)

add_executable(print script.cu)

