![pngLua logo](/logo.png?raw=true)

Una implementación en Lua puro de un decodificador PNG

Uso
-----

Para inicializar una nueva imagen PNG:

    img = pngImage(<path to image>, newRowCallback)
    
A continuación, la imagen será decodificada. Los datos disponibles a partir de la imagen son los siguientes:
```
img.width = 0
img.height = 0
img.depth = 0
img.colorType = 0

img:getPixel(x, y)
```
La decodificación de la imagen es síncrona y, en el caso de imágenes grandes, requerirá mucho tiempo.

Apoyo
-------

Los tipos de color admitidos son los siguientes:

-    Escala de grises
-    Color verdadero
-    Indexado
-    Escala de grises/alfa
-    Color verdadero/alfa

Hasta el momento, el módulo solo admite 256 colores en archivos PNG-8, PNG-24 y PNG-32, y no permite bloques auxiliares (ancillary chunks).

Es posible que se admitan más de 256 colores (profundidades de color superiores a 8 bits), siempre que se ajusten a bytes completos. Estos casos no han sido probados.

Se admiten múltiples fragmentos IDAT de longitudes arbitrarias, así como todos los filtros.

Errores
-------
Hasta ahora no se ha implementado ninguna comprobación de errores. No se realizan verificaciones CRC32.
