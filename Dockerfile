# Etapa de build
FROM mcr.microsoft.com/dotnet/sdk:8.0 AS build

WORKDIR /src

# Copiamos todos los archivos del repositorio
COPY . .

# Restaurar paquetes (ajustado a la ruta real del .csproj)
RUN dotnet restore "CRUD_Evaluacion_Mensual_Abril/CRUD_Evaluacion_Mensual_Abril.csproj"

# Publicar en modo Release
RUN dotnet publish "CRUD_Evaluacion_Mensual_Abril/CRUD_Evaluacion_Mensual_Abril.csproj" -c Release -o /app/publish

# Etapa de runtime
FROM mcr.microsoft.com/dotnet/aspnet:8.0 AS runtime

WORKDIR /app

# Copiamos lo publicado desde la etapa anterior
COPY --from=build /app/publish .

# Comando para ejecutar la app
ENTRYPOINT ["dotnet", "CRUD_Evaluacion_Mensual_Abril.dll"]


