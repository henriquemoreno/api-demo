# =========================
# Etapa 1 - Build
# =========================
FROM mcr.microsoft.com/dotnet/sdk:8.0 AS build
WORKDIR /app

# Copia o csproj (raiz)
COPY ApiDemo.csproj .
RUN dotnet restore ApiDemo.csproj

# Copia o restante do código
COPY . .
RUN dotnet publish -c Release -o /out

# =========================
# Etapa 2 - Runtime
# =========================
FROM mcr.microsoft.com/dotnet/aspnet:8.0
WORKDIR /app

COPY --from=build /out .

ENV ASPNETCORE_URLS=http://+:5000
EXPOSE 5000

ENTRYPOINT ["dotnet", "ApiDemo.dll"]
