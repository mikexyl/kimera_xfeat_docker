# syntax=docker/dockerfile:1

ARG BASE_IMAGE=nvcr.io/nvidia/isaac/ros:x86_64-ros2_humble_52e39c39633c15484ec744d5c1921590
FROM ${BASE_IMAGE}

# Install RealSense dependencies and ROS2 packages
RUN apt-get update && \
    apt-get install -y --no-install-recommends \
        git \
        wget \
        lsb-release \
        sudo \
        udev \
        libssl-dev \
        libusb-1.0-0-dev \
        pkg-config \
        libgtk-3-dev \
        libglfw3-dev \
        libgl1-mesa-dev \
        libglu1-mesa-dev \
        && rm -rf /var/lib/apt/lists/*

# Install ROS2 RealSense wrapper
RUN source /opt/ros/humble/setup.bash && \
    apt-get update && \
    apt-get install -y ros-humble-realsense2-camera && \
    rm -rf /var/lib/apt/lists/*

# Set entrypoint
CMD ["/bin/bash"]
