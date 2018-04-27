# Sample contents of Dockerfile
# Stage 1
FROM microsoft/aspnetcore-build AS builder
WORKDIR /source

# caches restore result by copying csproj file separately
COPY DockerPlayground/*.csproj .
RUN dotnet restore

# copies the rest of your code
COPY DockerPlayground/. .
RUN dotnet publish --output /app/ --configuration Release

# Stage 2
FROM microsoft/aspnetcore:latest
WORKDIR /app
COPY --from=builder /app .
ENTRYPOINT ["dotnet", "myapp.dll"]