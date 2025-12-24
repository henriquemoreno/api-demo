# =========================
# Etapa 1 - Build
# =========================
FROM mcr.microsoft.com/dotnet/sdk:8.0 AS build
WORKDIR /app

COPY ApiDemo.csproj .
RUN dotnet restore ApiDemo.csproj

COPY . .
RUN dotnet publish -c Release -o /out

# =========================
# Etapa 2 - Runtime
# =========================
FROM mcr.microsoft.com/dotnet/aspnet:8.0
WORKDIR /app

# 👉 DEPENDÊNCIAS DE RUNTIME
RUN apt-get update \
 && apt-get install -y curl \
 && rm -rf /var/lib/apt/lists/*

COPY --from=build /out .

ENV ASPNETCORE_URLS=http://+:8080
EXPOSE 8080

HEALTHCHECK --interval=30s --timeout=5s --retries=3 \
  CMD curl -f http://localhost:8080/health || exit 1

ENTRYPOINT ["dotnet", "ApiDemo.dll"]
