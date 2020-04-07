FROM continuumio/miniconda3

# Configure conda and kafka-libs
RUN conda update conda --yes

COPY environment.yml ./
RUN conda env create -f environment.yml python=3.8

RUN echo "source activate kafka-libs" > ~/.bashrc
ENV PATH /opt/conda/envs/kafka-libs/bin:$PATH

# Install consumer testing
COPY . .
ENTRYPOINT [ "python" ]
CMD [ "consumer.py" ]
