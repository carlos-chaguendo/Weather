![](https://raw.githubusercontent.com/carlos-chaguendo/Weather/main/main.png)

# Weather
Weather es una aplicación disponible en iOS iPadOS, macOS que nos ayuda a consultar el estado del clima de diferentes ubicaciones 

## Requerimientos

- Xcode 11
- Swift Package Manager

## Ambiente de desarrollo

```
git clone git@github.com:carlos-chaguendo/Weather.git
cd Weather
open Weather.xcworkspace
```
Se debe esperar a que descarge las dependencias antes de compilarlo

Si surge algún erro con las dependencias se puede eliminar la cache
> File>Packages>Reset Packages cache




## Estructura del proyecto
- **Weather:**  Fuentes principales de la aplicación
- **Packages/WeatherCore:** Es un paquete en el cual se encuentran todas las funcionalidades de negocio
    - **Model:** Los objetos que representan el modelo(Entidades|Dominio) de la aplicación,
    - **Repository:** Los objetos que sirven como acceso a recurso, en este caso recursos de red, pero también podría ser base de datos locales
    	- **Http** Abstrae el llamado a recursos en red, por ahora usa Almofire, pero podría cambiarse
    - **Service** Objetos de negocios los cuales junto con los repositorios nos ayudan a gestionar los datos de la aplicación, un servicio podría llamar a un recurso de red y luego guardarlo de manera local 
    
    

## Por hacer
 - Integrar git actions
 - Sección de favoritos
 - usar WidgetKit para mostrar la información de una ubicación en la pantalla de inicio
 	- Para esto se puede usar WeatherCore  
    

