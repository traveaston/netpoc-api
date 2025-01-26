FROM mcr.microsoft.com/dotnet/sdk:8.0-noble AS build
WORKDIR /app
COPY . ./
RUN dotnet restore
RUN dotnet publish -c Release -o out

FROM mcr.microsoft.com/dotnet/aspnet:8.0-noble AS runtime
WORKDIR /app
COPY --from=build /app/out ./

EXPOSE 5068
ENV ASPNETCORE_URLS=http://+:5068
ENTRYPOINT ["dotnet", "netpoc-api.dll"]
