# WIFIattackPreset.sh

![2023-03-11_17-00](https://user-images.githubusercontent.com/109326953/224509419-954b47c0-47c4-41cb-81a3-412c583e0910.png)

Herramienta hecha en Bash para automatizar las pre-configuraciones antes de un ataque WIFI.

Esta herramienta esta creada en bash y nos automatiza de forma rapida y sencilla, las configuraciones previas que debemos realizar antes de hacer cualquier tipo de ataque WIFI

## Uso y recomendaciones

Este script en bash consta de 5 opciones las cuales nos permiten Deshabilitar los procesos de red en segundo plato, que serian el **NetworkManager** y el **wpa_supplicant**, tambien podremos listar las interfaces de red que tengamos en el equipo, podremos cambiar el modo en el que opera nuestra interfaz de red(**monitor** o **managed**), ademas tendremos la opcion de cambiar nuenstra direccion MAC y por ultimo, podremos volver a rehabilitar nuestra interfaz de red de forma predeterminada con sus configuraciones por defecto.

Uso:

```./WIFIattackPreset.sh <parameters>```

Debido a que estas operaciones automatizadas requieren de privilegios elevados, es preferible corre el script como usuario root y agregar el programa a la variable de entorno, para que pueda ejecutarlo desde cualquier ubicacion en la que te encuentres operando.
