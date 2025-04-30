# Etapa 1: Build
FROM mcr.microsoft.com/dotnet/sdk:7.0 AS build
WORKDIR /src

# Copiar el archivo .csproj y restaurar dependencias
COPY CRUD_Evaluacion_Mensual_Abril/CRUD_Evaluacion_Mensual_Abril/*.csproj ./ 
RUN dotnet restore ./CRUD_Evaluacion_Mensual_Abril.csproj

# Copiar el resto del proyecto y compilar
COPY CRUD_Evaluacion_Mensual_Abril/CRUD_Evaluacion_Mensual_Abril/ ./
RUN dotnet publish -c Release -o /app/publish

# Etapa 2: Runtime
FROM mcr.microsoft.com/dotnet/aspnet:7.0
WORKDIR /app

# Copiar los archivos publicados desde la etapa anterior
COPY --from=build /app/publish .

# Configurar el puerto que Railway espera
ENV ASPNETCORE_URLS=http://+:8080
EXPOSE 8080

# Ejecutar la aplicación
ENTRYPOINT ["dotnet", "CRUD_Evaluacion_Mensual_Abril.dll"]
