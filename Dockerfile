# Use Node.js official image
FROM node:20-slim

# Install Python 3, pip, ffmpeg
RUN apt-get update && apt-get install -y --no-install-recommends \
    python3 \
    python3-pip \
    python3-venv \
    ffmpeg \
    && rm -rf /var/lib/apt/lists/*

# Set working directory
WORKDIR /app

# Copy package.json
COPY package*.json ./
RUN npm install --omit=dev

# Copy requirements and install edge-tts
COPY requirements.txt ./
RUN pip install --no-cache-dir --break-system-packages -r requirements.txt edge-tts

# Copy project files
COPY . .

# Set environment
ENV NODE_ENV=production
ENV PORT=7766
EXPOSE 7766

# Start server
CMD ["node", "app/launch.js"]
