#!/bin/bash

# Start DeepSeek first
/usr/local/bin/deepseek --port 11434 &

# Wait for DeepSeek to fully start
sleep 10

# Start Streamlit
streamlit run app.py --server.port=10000 --server.address=0.0.0.0
