FROM python:3

WORKDIR /opt/serverless-webapp

COPY . .

### Install TF
RUN wget https://releases.hashicorp.com/terraform/1.1.9/terraform_1.1.9_linux_arm64.zip
RUN unzip terraform_1.1.9_linux_arm64.zip
RUN mv terraform /usr/local/bin/


### Install AWS CLI
# RUN curl "https://awscli.amazonaws.com/awscli-exe-linux-aarch64.zip" -o "awscliv2.zip"
# RUN unzip awscliv2.zip
# RUN ./aws/install

RUN chmod u+x ./src/backend/main.py
WORKDIR /opt/serverless-webapp/tf
RUN terraform init

ENTRYPOINT [ "terraform", "apply", "-auto-approve" ]