meta objeto
===========

El objeto «meta» es el objeto central de cada nodo. Contiene información como los valores 'x' e 'y' del nodo, así como la zona a la que pertenece. Constituye la fuente principal de toda la información que posteriormente se mostrará en la descripción emergente  y, además, se utiliza para transmitir opciones y argumentos adicionales a las funciones de visualización del mapa y de la base de datos.

## Obligatorio
### ["complemento"]
El nombre del complemento que crea el nodo. Este dato se utiliza posteriormente para eliminar nodos a partir del nombre del complemento. pfQuest emplea «PFQUEST», mientras que, en caso de valores vacíos, se asigna por defecto «PFDB»; esto permite eliminar de una sola vez todos los nodos asociados a un mismo complemento.

### ["título"]
Este es el título del nodo que debe mostrarse. También puede utilizarse para eliminar todos los nodos a partir de su título.

### ["zona"]
El mapID (véase zones.lua) de la posición del nodo.

### ["x"]
El eje x de la posición del nodo

### ["y"]
El eje y de la posición del nodo

## Definido mediante consultas de aparición/objetos
### ["aparición"]
Esto define el nombre del elemento que debe mostrarse y el título del nodo. Se reemplaza si se establece `"item"` o `"quest"`.
Las funciones `SearchMob` y `SearchObject` utilizarán esto para establecer el «título» del nodo.

### ["ID de generación"]
Esto define el ID del aparición que debe mostrarse en el título de la información emergente del nodo cuando la opción `mostrar identificadores` está habilitada.
La función `pfMap:NodeEnter()` utilizará este valor para establecer el «título» del nodo.

### ["nivel"]
Se puede utilizar para imprimir un nivel para el nodo creado; este puede ser una cadena que contenga un número o un rango, como `"16-18"`.

### ["reaparecer"]
Esto puede ajustarse al temporizador de reaparición del objeto o unidad en cuestión.

### ["tipo de aparición"]
Esto debe establecerse según el tipo del nodo. Por lo general, se trata de `"Unidad"` u `"Objeto"`.

## Consultas por elemento
### ["elemento"]
Esto define el nombre del objeto que debe mostrarse y el título del nodo. Se reemplaza si se establece «quest».
Las funciones `SearchMob` y `SearchObject` utilizarán esto para establecer el «título» del nodo.

### ["ID de elemento"]
Si el nodo muestra un elemento, este valor puede establecerse en el `itemid` correspondiente para facilitar el trabajo posterior con el nodo.

### ["enlace al elemento"]
Esto no se establece directamente. Puede asignarse al enlace del objeto  generado, el cual se construye a partir del color de rareza, el nombre y el ID del objeto. Por lo general, esto se realiza dentro de la función de información emergente y se almacena aquí en caché.

### ["tasa de obtención"]
Si el objeto se obtiene —ya sea porque cae o porque se saquea de algún elemento o unidad—, esto puede representar la probabilidad de obtención.

### ["cantidad de ventas"]
Esto se utiliza para las entradas dentro de la tabla de proveedores de la base de datos de artículos, con el fin de indicar la cantidad de artículos de los que dispone un proveedor. Si se establece en `0`, equivale a una cantidad infinita.

## Establecido por consultas de búsqueda
### ["qlvl"]
El nivel mínimo requerido para aceptar la misión.

### ["qmin"]
Las misiones muestran un nivel; por lo general, se trata del nivel recomendado que indica el registro de misiones.

### ["quest"]
Esto define el nombre de la misión que debe mostrarse, así como el título del nodo. Si se especifica una misión, ni la aparición ni el objeto se utilizarán como título.
Las funciones `SearchMob` y `SearchObject` emplearán este valor para establecer el «título» del nodo.

## Relacionado con la visualización
### ["textura"]
Si no se define ninguna textura, la función de mapa utilizará el icono de nodo predeterminado. De lo contrario, puede tratarse de símbolos para vendedores, misiones o elementos personalizados. El valor debe ser la ruta a un archivo de imagen existente (por ejemplo: `Interface\\AddOns\\pfQuest\\img\\icon_vendor`).

### ["vértice"]
Esto puede utilizarse para teñir texturas con un color determinado. El valor es una tabla con colores RGB (por ejemplo: `{ 1, .8, .4 }`).

### ["capa"]
[OBSOLETO: La capa se genera ahora automáticamente con un valor basado en su textura.]
La capa puede utilizarse para forzar una posición por encima o por debajo de otros nodos. Varios nodos situados en el mismo eje x/y se fusionan en uno solo. Cuanto mayor sea el valor, más probable será que esta textura sustituya la visibilidad de los otros nodos.


## Argumentos adicionales de la función
Dichos valores no son fiables para su lectura después de las llamadas a las funciones. Se utilizan para solicitar comportamientos especiales en una de las funciones de consulta a la base de datos.

### ["qlogid"]
Representa la posición actual de la misión en el registro de misiones del jugador. Se utiliza para recopilar información detallada, como el progreso actual de la misión, la cual se registrará en `qstate`. Si este parámetro está definido, las funciones `SearchQuest` y `SearchQuestByID` se comportarán de la manera que requiere el rastreador de pfQuest:
* No muestra los puntos de inicio de las misiones.
* Utiliza signos de interrogación grises para las misiones incompletas.
* Utiliza signos de interrogación amarillos para las misiones completadas.
* Omite los objetivos que ya han sido finalizados.

### ["qstate"]
Esto refleja el estado actual de la misión en el registro de misiones; puede tratarse de cadenas de texto como `"hecho"` o `"progreso"`.
