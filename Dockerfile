FROM node:20-slim

# Enable corepack to natively support pnpm
ENV PNPM_HOME="/pnpm"
ENV PATH="$PNPM_HOME:$PATH"
RUN corepack enable

WORKDIR /app

# Copy configuration files first to optimize Docker layer caching
COPY package.json pnpm-lock.yaml* ./

# Execute your specific build requirement
RUN pnpm install --frozen-lockfile

# Copy the rest of your application code
COPY . .

# Expose the port Back4app routes traffic to
ENV PORT=8080
EXPOSE 8080

# Launch the backend server
CMD ["node", "dist/createServer.js"]
