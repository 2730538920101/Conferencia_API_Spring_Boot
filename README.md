## Build and push de imagenes con soporte para todas las arquitecturas:

docker buildx build --platform linux/amd64,linux/arm64 \
  -t carlosmz87/conferencias2025_frontend:latest \
  -f ./frontend/Dockerfile \
  ./frontend \
  --push


docker buildx build --platform linux/amd64,linux/arm64 \
  -t carlosmz87/conferencias2025_backend:latest \ 
  -f ./api-conferencia/Dockerfile \
  ./api-conferencia \
  --push
