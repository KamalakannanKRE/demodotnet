# Use the official .NET SDK as a base image
FROM mcr.microsoft.com/dotnet/sdk:7.0 AS build

# Set the working directory in the container
WORKDIR /app

# Copy the project files to the container
COPY . .

# Build the project
RUN dotnet publish -c Release -o out

# Create a runtime image
FROM mcr.microsoft.com/dotnet/aspnet:7.0
WORKDIR /app
COPY --from=build /app/out .

# Expose the port that the app will run on
EXPOSE 5059

# Define the entry point for the container
ENTRYPOINT ["dotnet", "DotNet.dll"]
