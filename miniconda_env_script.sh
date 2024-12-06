#!/bin/bash
#quick script for setting up miniconda environment for iSALE

envname=iSALEenv

if [ ! -d "/home/${USER}/miniconda3" ] ; then
	mkdir -p ~/miniconda3
	wget https://repo.anaconda.com/miniconda/Miniconda3-latest-Linux-x86_64.sh -O ~/miniconda3/miniconda.sh
	bash ~/miniconda3/miniconda.sh -b -u -p ~/miniconda3
	rm -rf ~/miniconda3/miniconda.sh

	/home/${USER}/miniconda3/bin/conda init

	source /home/${USER}/.bashrc
else
	echo "Miniconda appears to already be installed"
fi

#make sure .bashrc is sourced automatically on login
if [ ! -f "/home/${USER}/.profile" ] ; then
        echo "source ~/.bashrc" > ~/.profile
fi

if [ ! -d "/home/${USER}/miniconda3/envs/${envname}" ] ; then
	conda create --name ${envname} --file spec-file.txt
else
	echo "Environment named ${envname} already appears to exist"
fi


if [ ! -d "/home/${USER}/iSALE" ] ; then
	mkdir ~/iSALE
fi

if [ -f iSALE2D-dellen-py3.tar.gz ] ; then
	cp iSALE2D-dellen-py3.tar.gz ~/FDMNES
	cd ~/iSALE
	tar -xzvf iSALE2D-dellen-py3.tar.gz
else
	echo "No file iSALE2D-dellen-py3.tar.gz found in ${PWD}, please manually unpack this (tar -xzvf iSALE2D-dellen-py3.tar.gz) in /home/${USER}/iSALE"
fi

echo -e "\n\n" >> ~/.bashrc
echo 'PATH=$PATH:~/FDMNES/parallel_fdmnes/' >> ~/.bashrc


#fix missing .so.1 files
ln -s /home/${USER}/miniconda3/envs/${envname}/lib/libmpi_cxx.so.40.20.1  /home/${USER}/miniconda3/envs/${envname}/lib/libmpi_cxx.so.1
ln -s /home/${USER}/miniconda3/envs/${envname}/lib/libmpi.so.40.20.2  /home/${USER}/miniconda3/envs/${envname}/lib/libmpi.so.1

