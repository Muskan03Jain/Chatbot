# Use Ubuntu as the base image
FROM ubuntu:22.04

# Install dependencies
RUN apt-get update && apt-get install -y \
    curl \
    python3-pip \
    && rm -rf /var/lib/apt/lists/*

# Install Ollama
RUN curl -fsSL https://ollama.ai/install.sh | sh

# Set Ollama path
ENV PATH="/root/.ollama/bin:$PATH"

# Install Python dependencies
WORKDIR /app
COPY requirements.txt .
RUN pip install --no-cache-dir -r requirements.txt

# Download and prepare DeepSeek model
RUN ollama pull deepseek-coder:1.5b

# Copy app files
COPY . .

# Expose Streamlit and Ollama ports
EXPOSE 8501 11434

# Start Ollama in the background and launch Streamlit
CMD ollama serve & streamlit run app.py --server.port 8501 --server.enableCORS false
