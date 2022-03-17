![](https://raw.githubusercontent.com/carlos-chaguendo/Weather/main/main.png)

# Weather
Weather es una aplicacion disponible en iOS iPadOS, macOS que nos ayuda a consultar el estado del clima de diferentes ubicaciones 

## Requerimientos

- Xcode 11
- Swift Package Manager

## Ambiente de desarrollo

```
git clone git@github.com:carlos-chaguendo/Weather.git
cd Weather
open Weather.xcodeproj

```
Se debe esperar a que descarge las dependencias antes de ejecutar




## Estructura del proyecto
- **Weather:**  Fuentes principales de la aplicacion
- **Packages/WeatherCore:** Es un paquete en el cual se encuntran todas las funcionalidades de negocio, Utilerias o extensiones
    - **Model:** Los objetos que reprecentan el modelo(Entidades|Dominio) de la apliacion,
    - **Repository:** Los objetos que sirven como acceso a recurso, en este caso recursos de red, pero tambien podria ser base de datos locales
    	- **Http** Abstrae el llamado a recursos en red, por ahora usa Almofire, pero podria cambiarse
    - **Service** Objetos de negocios los cuales junto con los repositorios nos ayudan a gestionar los datos de la aplicacion, un servicio podria llamar a un recurso de red y luego guardarlo de manera local 
    
    

## Por hacer
 - Seccion de favoritos
 - usar WidgetKit para mostrar la informacion de una ubicacion en la pantalla de inicio
 	- Para esto se puede usar WeatherCore  
    

