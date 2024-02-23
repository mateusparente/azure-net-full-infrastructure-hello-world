# TodoApi

This is a sample ASP.NET Core Web API project. 
For now, just a hello world.

## Prerequisites

- .NET 8 SDK

## Getting Started

1. Clone the repository.
2. Build the project using the .NET CLI: `dotnet build`.
3. Run the project using the .NET CLI: `dotnet run`.
4. Open your browser and navigate to `https://localhost:5226/swagger` to access the Swagger UI.

## Getting Started with Docker Compose

2. Build the project using: `docker compose build`.
3. Run the project using: `docker compose up`.
4. Open your browser and navigate to `http://localhost:8080/swagger` to access the Swagger UI.

## Project Structure

- `TodoApi.csproj`: The project file containing the project configuration.
- `Startup.cs`: The startup class where the application configuration is defined.
- `/terraform`: This folder contains all the terraform resources necessary to deploy the application on the K8S cluster.

## Dependencies

- Swashbuckle.AspNetCore 6.5.0: Used for generating API documentation with Swagger.