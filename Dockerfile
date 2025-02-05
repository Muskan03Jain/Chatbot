# Use Python as the base image
FROM python:3.10

# Set the working directory
WORKDIR /app

# Install dependencies
RUN pip install --no-cache-dir streamlit langchain_ollama requests

# Install DeepSeek manually (instead of using Docker)
RUN apt update && apt install -y wget tar
RUN wget https://huggingface.co/deepseek-ai/deepseek-coder/resolve/main/deepseek-coder.tar.gz -O deepseek-coder.tar.gz
RUN tar -xvf deepseek-coder.tar.gz
RUN mv deepseek-coder /usr/local/bin/deepseek

# Expose ports for both DeepSeek and Streamlit
EXPOSE 11434 10000

# Copy all files into the container
COPY . /app

# Run both DeepSeek and Streamlit
CMD ["bash", "start.sh"]
