# syntax=docker/dockerfile:1


ARG BASE_IMAGE=dustynv/ros:noetic-desktop-l4t-r35.4.1
ARG USERNAME=kimera
FROM ${BASE_IMAGE}


# Create user and add to sudoers
RUN apt-get update && \
    apt-get install -y sudo curl && \
    useradd -m -s /bin/bash "$USERNAME" && \
    echo "$USERNAME ALL=(ALL) NOPASSWD:ALL" >> /etc/sudoers

# Install pixi for the user
USER $USERNAME
RUN curl -fsSL https://pixi.sh/install.sh | bash
ENV PATH="/home/$USERNAME/.pixi/bin:$PATH"
USER root

# Set entrypoint
CMD ["sleep", "infinity"]
