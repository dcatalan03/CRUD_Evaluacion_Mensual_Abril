# -------------------------------
# 🏗️ Etapa 1: Construcción (Build)
# -------------------------------

# Utilizamos la imagen oficial de .NET SDK 8.0 para compilar la aplicación
FROM mcr.microsoft.com/dotnet/sdk:8.0 AS build

# Establecemos el directorio de trabajo dentro del contenedor
WORKDIR /src

# Copiamos el archivo .csproj al contenedor
COPY CRUD_Evaluacion_Mensual_Abril/CRUD_Evaluacion_Mensual_Abril.csproj ./CRUD_Evaluacion_Mensual_Abril/

# Restauramos las dependencias de NuGet
RUN dotnet restore ./CRUD_Evaluacion_Mensual_Abril/CRUD_Evaluacion_Mensual_Abril.csproj

# Copiamos el resto de los archivos del proyecto al contenedor
COPY . .

# Publicamos la aplicación en modo Release en la carpeta /app/publish
RUN dotnet publish ./CRUD_Evaluacion_Mensual_Abril/CRUD_Evaluacion_Mensual_Abril.csproj -c Release -o /app/publish

# -----------------------------------
# 🚀 Etapa 2: Imagen final (Runtime)
# -----------------------------------

# Utilizamos la imagen oficial de ASP.NET Core Runtime 8.0 para ejecutar la aplicación
FROM mcr.microsoft.com/dotnet/aspnet:8.0 AS final

# Establecemos el directorio de trabajo dentro del contenedor
WORKDIR /app

# Copiamos los archivos publicados desde la etapa de construcción
COPY --from=build /app/publish .

# Exponemos el puerto 8080 (puerto predeterminado en .NET 8)
EXPOSE 8080

# Definimos la variable de entorno para que la aplicación escuche en el puerto 8080
ENV ASPNETCORE_URLS=http://+:8080

# Comando para ejecutar la aplicación
ENTRYPOINT ["dotnet", "CRUD_Evaluacion_Mensual_Abril.dll"]
