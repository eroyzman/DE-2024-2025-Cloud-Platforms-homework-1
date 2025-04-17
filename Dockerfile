FROM mcr.microsoft.com/dotnet/sdk:7.0 AS build
WORKDIR /app

COPY *.sln .
COPY SampleWebApiAspNetCore/*.csproj ./SampleWebApiAspNetCore/
RUN dotnet restore

COPY SampleWebApiAspNetCore/. ./SampleWebApiAspNetCore/
WORKDIR /app/SampleWebApiAspNetCore
RUN dotnet publish -c Release -o out

FROM mcr.microsoft.com/dotnet/aspnet:7.0 AS runtime
WORKDIR /app
COPY --from=build /app/SampleWebApiAspNetCore/out ./

ENTRYPOINT ["dotnet", "SampleWebApiAspNetCore.dll"]