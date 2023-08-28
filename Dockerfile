# We just want ubuntu with our apt packages already included
# Bump for rebuild on 28/08/2023 16:45 UTC +3
# Get Ubuntu Image
FROM ubuntu:23.04
RUN DEBIAN_FRONTEND=noninteractive apt-get -y update
RUN DEBIAN_FRONTEND=noninteractive apt-get -y install software-properties-common sudo git bc gpg gpg-agent wget -y
# Install Pika Apt Sources
RUN wget https://ppa.pika-os.com/dists/lunar/pika-sources.deb
RUN DEBIAN_FRONTEND=noninteractive apt-get install ./pika-sources.deb --yes --option Acquire::Retries=5 --option Acquire::http::Timeout=100 --option Dpkg::Options::="--force-confnew"
RUN rm -rf ./pika-sources.deb
RUN DEBIAN_FRONTEND=noninteractive apt-get -y update
RUN DEBIAN_FRONTEND=noninteractive apt-get -y upgrade --allow-downgrades
RUN ln -fs /usr/share/zoneinfo/America/New_York /etc/localtime
RUN DEBIAN_FRONTEND=noninteractive apt-get install -y tzdata
# Actions to do before DISTRO_PKGS
RUN DEBIAN_FRONTEND=noninteractive apt install initramfs-tools adwaita-icon-theme humanity-icon-theme amdgpu-drm --yes --option Acquire::Retries=5
RUN DEBIAN_FRONTEND=noninteractive apt install update-notifier --yes --option Acquire::Retries=5
RUN DEBIAN_FRONTEND=noninteractive apt install update-manager --yes --option Acquire::Retries=5
RUN DEBIAN_FRONTEND=noninteractive apt install ubuntu-release-upgrader-gtk --yes --option Acquire::Retries=5
RUN DEBIAN_FRONTEND=noninteractive mkdir -p /usr/lib/firmware/
# Add Packages
RUN DEBIAN_FRONTEND=noninteractive apt-get install ubuntu-minimal pika-baseos -y

