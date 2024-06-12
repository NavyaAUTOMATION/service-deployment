# Use a small base image
FROM alpine:3.12

# Install necessary packages
RUN apk add --no-cache python3 py3-pip

# Create the version file
RUN echo "3.0.1" > /version.txt

# Create a simple HTTP server script
RUN echo "import http.server\nimport socketserver\n\nPORT = 8080\n\nclass Handler(http.server.SimpleHTTPRequestHandler):\n    def do_GET(self):\n        self.send_response(200)\n        self.send_header('Content-type', 'text/plain')\n        self.end_headers()\n        with open('/version.txt', 'r') as file:\n            self.wfile.write(file.read().encode())\n\nwith socketserver.TCPServer(('', PORT), Handler) as httpd:\n    print(f'Serving on port {PORT}')\n    httpd.serve_forever()" > /server.py

# Set the working directory
WORKDIR /

# Expose the port
EXPOSE 8080

# Run the server
CMD ["python3", "/server.py"]
