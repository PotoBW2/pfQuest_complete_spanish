# pfQuest_complete_spanish
<img src="https://raw.githubusercontent.com/shagu/ShaguAddons/master/_img/pfQuest/mode.png" float="right" align="right" width="25%">

Este es un complemento para World of Warcraft Vanilla (1.12) . Ayuda a los jugadores a encontrar varios objetos y misiones dentro del juego. El complemento lee los objetivos de las misiones, los analiza y utiliza su base de datos interna para trazar las coincidencias encontradas en el mundo y el minimapa. Viene con una interfaz gráfica de usuario para explorar todos los objetos conocidos. Si uno de los elementos aún no está disponible en tu reino, verás un [?] delante del nombre.

El complemento no está diseñado para ser una guía de misiones o de recorridos turísticos, sino que los objetivos son proporcionar una versión precisa del juego de [AoWoW](https://classicdb.ch/) o [Wowhead](http://www.wowhead.com/). La versión original funciona con la base de datos de [VMaNGOS](https://github.com/vmangos). La versión de Burning Crusade utiliza datos del proyecto [CMaNGOS](https://github.com/cmangos) con traducciones tomadas de [MaNGOS Extras](https://github.com/MangosExtras).

pfQuest is the successor of [ShaguQuest](https://shagu.org/ShaguQuest/) and has been entirely written from scratch. In comparison to [ShaguQuest](https://shagu.org/ShaguQuest/), this addon does not depend on any specific map- or questlog addon. It's designed to support the default interface aswell as every other addon. In case you experience any addon conflicts, please add an issue to the bugtracker.

pfQuest es el sucesor de [ShaguQuest](https://shagu.org/ShaguQuest/) y ha sido escrito completamente desde cero. En comparación con [ShaguQuest](https://shagu.org/ShaguQuest/), este complemento no depende de ningún mapa específico ni de ningún complemento de registro de misiones. Está diseñado para admitir la interfaz predeterminada y todos los demás complementos. En caso de que experimentes algún conflicto con los complementos, agrega un problema al rastreador de errores de la página [original de Shagu](https://github.com/shagu/pfQuest).

# Traducción por PotoBW

Shagu brindó todas las herramientas para hacer las traducciones. Así que el mérito es para ese pedazo de hombre (quien sabe, quizas sea una mujer). Las traducciones están hechas en Google Translate así que pueden estar mal traducidas o intelegibles. En caso de que tenga alguna inconformidad al respecto puede contactarme para arreglar estas malas traducciones.

Telefono, WhatSapp, Telegram: +53 55920042

Telegram: @potobw

Correo: dmosquerabw@gmail.com


# Donaciones

PayPal: joseamosher@gmail.com

# Descargas

Puedes consultar la página [[Últimos cambios]](https://github.com/PotoBW2/pfQuest_complete_spanish/commits/master) para ver qué ha cambiado recientemente. O consultar los ultimos [cambios de Shagu](https://github.com/shagu/pfQuest/commits/master)

## World of Warcraft: **Vanilla**
1. **[[Download pfQuest]](https://github.com/PotoBW2/pfQuest_complete_spanish/releases/download/pfQuest_Complete_Spanish/pfQuest.rar)** (\*)
2. Descomprima el archivo RAR
3. Mueva `pfQuest` a la carpeta  `Wow-Directory\Interface\AddOns`
4. Reiniciar Wow
5. Establezca "Memoria de script" en "0" ([Cómo hacerlo](https://i.imgur.com/rZXwaK0.jpg))


## Controles

- Para cambiar los colores de los nodos en el mapa mundial, **haz clic** en el nodo.
- Para eliminar misiones realizadas anteriormente del mapa, **\<shift\>-haz clic** en el dador de misiones en el mapa mundial
- Para ocultar temporalmente los grupos en el mapa mundial, mantén presionada la tecla **\<ctrl\>**
- Para ocultar temporalmente los nodos en el minimapa, pasa el cursor sobre él y mantén presionada la tecla **\<ctrl\>**
- Para mover el botón del minimapa, **\<shift\>-arrastra** el ícono
- Para mover la flecha, **\<shift\>-arrastra** el marco

## Uso de memoria adicional

El complemento incluye una base de datos completa de todos los engendros, objetos, elementos y misiones y, por lo tanto, incluye una enorme base de datos (~80 MB, incluidas todas las configuraciones regionales) que se carga en la memoria al iniciar el juego. Sin embargo, el uso de memoria de pfQuest es persistente y no aumenta más con el tiempo, por lo que no hay nada malo en el rendimiento en absoluto. Para deshacerte de cualquier advertencia, puedes establecer el límite de memoria del complemento en "0", que se lee como "sin límite". Esta opción se puede encontrar en la [pantalla de selección de personajes](https://i.imgur.com/rZXwaK0.jpg).

# Nodos de mapa y minimapa
<img src="https://raw.githubusercontent.com/shagu/ShaguAddons/master/_img/pfQuest/arrow.jpg" width="35.8%" align="left">
<img src="https://raw.githubusercontent.com/shagu/ShaguAddons/master/_img/pfQuest/minimap-nodes.png" width="59.25%">
<img src="https://raw.githubusercontent.com/shagu/ShaguAddons/master/_img/pfQuest/map-quests.png" width="55.35%" align="left">
<img src="https://raw.githubusercontent.com/shagu/ShaguAddons/master/_img/pfQuest/map-spawnpoints.png" width="39.65%">

# Seguimiento automático
<img src="https://raw.githubusercontent.com/shagu/ShaguAddons/master/_img/pfQuest/map-autotrack.png" float="right" align="right" width="30%">
El complemento incluye 4 modos diferentes que definen cómo se deben gestionar los objetivos de misiones nuevos o actualizados. Estos modos se pueden seleccionar en el menú desplegable que se encuentra en la parte superior derecha del mapa.

### Opción: Todas las misiones
Cada misión se mostrará y actualizará automáticamente en el mapa.

### Opción: Misiones rastreadas
Sólo las misiones rastreadas (Shift-Clic) se mostrarán y actualizarán automáticamente en el mapa.

### Opción: Selección manual
Solo se mostrarán los objetivos de misiones que se hayan mostrado manualmente (botón "Mostrar" en el registro de misiones).
Los objetivos de misiones completados se eliminarán automáticamente del mapa.

### Opción: Ocultar misiones
Igual que "Selección manual" y además, los otorgadores de misiones no se mostrarán automáticamente.
Además, los objetivos de misiones completados permanecerán en el mapa. Este modo no afectará a ninguno de los nodos del mapa creados.

# Navegador de base de datos
<img src="https://raw.githubusercontent.com/shagu/ShaguAddons/master/_img/pfQuest/browser-spawn.png" align="left" width="30%">
<img src="https://raw.githubusercontent.com/shagu/ShaguAddons/master/_img/pfQuest/browser-quests.png" align="left" width="30%">
<img src="https://raw.githubusercontent.com/shagu/ShaguAddons/master/_img/pfQuest/browser-items.png" align="center" width="33%">

La interfaz gráfica de usuario de la base de datos le permite marcar como favoritas y explorar todas las entradas dentro de la base de datos de pfQuest. Puede abrirse haciendo clic en el icono del minimapa de pfQuest o mediante `/db show`. El navegador mostrará un máximo de 100 entradas a la vez para cada pestaña. Utilice la rueda de desplazamiento o presione las flechas arriba/abajo para subir y bajar por la lista.

# Integración de Questlog
### Enlaces de misiones
<img src="https://raw.githubusercontent.com/shagu/ShaguAddons/master/_img/pfQuest/questlink.png" float="right" align="right" width="30%">

En los servidores que admiten enlaces de misiones, al hacer clic con la tecla Shift presionada en una misión seleccionada, se agregará un enlace de misión al chat. Esos enlaces son similares a los enlaces de misiones conocidos de TBC+ y son compatibles con los producidos por [ShaguQuest](https://shagu.org/ShaguQuest/), [Questie](https://github.com/AeroScripts/QuestieDev) y [QuestLink](http://addons.us.to/addon/questlink-0). Ten en cuenta que algunos servidores (por ejemplo, Kronos) están bloqueando los enlaces de misiones y tendrás que desactivar esta función en la configuración de pfQuest para poder imprimir el nombre de la misión en el chat en lugar de agregar un enlace de misión. Los enlaces de misiones enviados de pfQuest a pfQuest son independientes de la configuración regional y dependen del ID de la misión.

The tooltip will display quest information such as your current state on the quest (new, in progress, already done) as well as the quest objective text and the full quest description. In addition to that, the suggested level and the minimum level are shown.

La información sobre herramientas mostrará información sobre la misión, como tu estado actual en la misión (nueva, en progreso, ya realizada), así como el texto del objetivo de la misión y la descripción completa de la misión. Además, se muestran el nivel sugerido y el nivel mínimo.

### Botones de Registro de Misiones
<img src="https://raw.githubusercontent.com/shagu/ShaguAddons/master/_img/pfQuest/questlog-integration.png" align="left" width="300">

El registro de misiones mostrará 4 botones adicionales en cada misión para facilitar el seguimiento manual de las misiones. Esos botones se pueden usar para mostrar u ocultar misiones individuales en el mapa. Esos botones no afectarán las entradas que hayas colocado mediante el navegador de la base de datos.

**Mostrar**  
El botón "Mostrar" agregará los objetivos de la misión actual al mapa.

**Ocultar**  
El botón "Ocultar" eliminará la misión seleccionada actualmente del mapa.

**Limpiar**  
El botón "Limpiar" eliminará todos los nodos que pfQuest haya colocado en el mapa.

**Restablecer**  
The "Reset" button will restore the default visibility of icons to match the set values on the map dropdown menu (e.g "All Quests" by default).

El botón "Restablecer" restaurará la visibilidad predeterminada de los íconos para que coincidan con los valores establecidos en el menú desplegable del mapa (por ejemplo, "Todas las misiones" de forma predeterminada).

# Interfaz de línea de comandos de chat/macros
<img src="https://raw.githubusercontent.com/shagu/ShaguAddons/master/_img/pfQuest/chat-cli.png">

El complemento cuenta con una interfaz CLI que te permite crear fácilmente macros para mostrar tus hierbas o vetas de minas favoritas. Digamos que quieres mostrar todos los depósitos de **Depósito de hierro**, entonces escribe en el chat o crea una macro con el texto: `/db object Iron Deposit`. También puedes mostrar todas las minas en el mapa escribiendo: `/db mines`. Esto se puede ampliar dando la habilidad mínima y máxima requerida como parámetro, como: `/db mines 150 225` para mostrar todos los minerales entre la habilidad 150 y 225. El parámetro `mines` también se puede reemplazar por `herbs`, `rares`, `chests` o `taxi` para mostrarlos en su lugar. Si `/db` no funciona para ti, también hay otros alias disponibles como `/shagu`, `pfquest` y `/pfdb`.
