# Use the Alpine Linux base image
FROM oraclelinux:9

# Update the package repository and install any desired packages
RUN dnf update && dnf upgrade


