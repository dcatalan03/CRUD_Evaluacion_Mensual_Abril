# Usa la imagen oficial de .NET 8 SDK para compilar
FROM mcr.microsoft.com/dotnet/sdk:8.0 AS build

WORKDIR /app

# Copia todo el código
COPY . ./

# Restaura dependencias
RUN dotnet restore "./CRUD_Evaluacion_Mensual_Abril.csproj"

# Publica en modo Release
RUN dotnet publish "./CRUD_Evaluacion_Mensual_Abril.csproj" -c Release -o /out

# Imagen de runtime
FROM mcr.microsoft.com/dotnet/aspnet:8.0 AS runtime

WORKDIR /app

COPY --from=build /out ./

ENTRYPOINT ["dotnet", "CRUD_Evaluacion_Mensual_Abril.dll"]

