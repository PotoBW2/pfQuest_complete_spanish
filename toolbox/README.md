# pfQuest-toolbox

## Configurar dependencias
### Archlinux

    # pacman -S mariadb mariadb-clients luarocks
    # mysql_install_db --user=mysql --basedir=/usr --datadir=/var/lib/mysql
    # systemctl start mariadb
    # luarocks install luasql-mysql MYSQL_INCDIR=/usr/include/mysql

## Preparar bases de datos
El extractor de pfQuest es compatible con las bases de datos VMaNGOS y CMaNGOS. De forma predeterminada, se utiliza VMaNGOS para la versión *vanilla* y CMaNGOS para TBC. Para las traducciones en CMaNGOS, se emplea el proyecto Mangos-Extras.

### Crear usuarios y permisos

    mariadb <<< '
        DROP DATABASE IF EXISTS `pfquest`;
        DROP DATABASE IF EXISTS `vmangos`;
        DROP DATABASE IF EXISTS `cmangos-tbc`;
        DROP DATABASE IF EXISTS `turtle`;

        CREATE USER 'mangos'@'localhost' IDENTIFIED BY 'mangos';

        CREATE DATABASE `pfquest` DEFAULT CHARACTER SET utf8 COLLATE utf8_general_ci;
        GRANT SELECT, INSERT, UPDATE, DELETE, CREATE, DROP, ALTER, LOCK TABLES, CREATE TEMPORARY TABLES, EXECUTE, ALTER ROUTINE, CREATE ROUTINE ON `pfquest`.* TO 'mangos'@'localhost';

        CREATE DATABASE `vmangos` DEFAULT CHARACTER SET utf8 COLLATE utf8_general_ci;
        GRANT SELECT, INSERT, UPDATE, DELETE, CREATE, DROP, ALTER, LOCK TABLES, CREATE TEMPORARY TABLES, EXECUTE, ALTER ROUTINE, CREATE ROUTINE ON `vmangos`.* TO 'mangos'@'localhost';

        CREATE DATABASE `cmangos-tbc` DEFAULT CHARACTER SET utf8 COLLATE utf8_general_ci;
        GRANT SELECT, INSERT, UPDATE, DELETE, CREATE, DROP, ALTER, LOCK TABLES, CREATE TEMPORARY TABLES, EXECUTE, ALTER ROUTINE, CREATE ROUTINE ON `cmangos-tbc`.* TO 'mangos'@'localhost';

        CREATE DATABASE `turtle` DEFAULT CHARACTER SET utf8 COLLATE utf8_general_ci;
        GRANT SELECT, INSERT, UPDATE, DELETE, CREATE, DROP, ALTER, LOCK TABLES, CREATE TEMPORARY TABLES, EXECUTE, ALTER ROUTINE, CREATE ROUTINE ON `turtle`.* TO 'mangos'@'localhost';
    '

### Importar datos de clientes

Importa los archivos SQL de los datos del cliente del juego:

    mariadb -u mangos -p"mangos" pfquest < ../client-data.sql

### Vanilla (VMaNGOS)

Descarga manualmente la versión más reciente de la [base de datos de VMaNGOS](https://github.com/vmangos/core/releases/tag/db_latest) y descomprímela.

    mariadb -u mangos -p"mangos" vmangos < mangos.sql

Clona el repositorio principal de VMaNGOS para obtener todas las actualizaciones SQL.

    git clone https://github.com/vmangos/core.git

    cd core/sql/migrations
    for file in *_world.sql; do mariadb -u mangos -p"mangos" vmangos < $file; done
    cd -

Crea entradas `_loc10` en las tablas de traducción de VMaNGOS para `ptBR`:

    mariadb -u mangos -p"mangos" vmangos <<< '
        # select database
        USE vmangos;

        # locales_creature
        ALTER TABLE locales_creature ADD name_loc10 varchar(100);
        ALTER TABLE locales_creature ADD subname_loc10 varchar(100);

        # locales_gameobject
        ALTER TABLE locales_gameobject ADD name_loc10 varchar(100);

        # locales_item
        ALTER TABLE locales_item ADD name_loc10 varchar(100);
        ALTER TABLE locales_item ADD description_loc10 varchar(255);

        # locales_quest
        ALTER TABLE locales_quest ADD Title_loc10 TEXT;
        ALTER TABLE locales_quest ADD Details_loc10 TEXT;
        ALTER TABLE locales_quest ADD Objectives_loc10 TEXT;
        ALTER TABLE locales_quest ADD ObjectiveText1_loc10 TEXT;
        ALTER TABLE locales_quest ADD ObjectiveText2_loc10 TEXT;
        ALTER TABLE locales_quest ADD ObjectiveText3_loc10 TEXT;
        ALTER TABLE locales_quest ADD ObjectiveText4_loc10 TEXT;
        ALTER TABLE locales_quest ADD OfferRewardText_loc10 TEXT;
        ALTER TABLE locales_quest ADD RequestItemsText_loc10 TEXT;
        ALTER TABLE locales_quest ADD EndText_loc10 TEXT;
    '

Utiliza las localizaciones `ptBR` actuales del repositorio principal de vmangos e incorpóralas como entradas `_loc10`.

    cd core/sql/translations/ptBR
    git checkout .
    sed -i 's/`name`/`name_loc10`/g' *.sql
    sed -i 's/`subname`/`subname_loc10`/g' *.sql
    sed -i 's/`description`/`description_loc10`/g' *.sql
    sed -i 's/`Title`/`Title_loc10`/g' *.sql
    sed -i 's/`Details`/`Details_loc10`/g' *.sql
    sed -i 's/`Objectives`/`Objectives_loc10`/g' *.sql
    sed -i 's/`ObjectiveText1`/`ObjectiveText1_loc10`/g' *.sql
    sed -i 's/`ObjectiveText2`/`ObjectiveText2_loc10`/g' *.sql
    sed -i 's/`ObjectiveText3`/`ObjectiveText3_loc10`/g' *.sql
    sed -i 's/`ObjectiveText4`/`ObjectiveText4_loc10`/g' *.sql
    sed -i 's/`OfferRewardText`/`OfferRewardText_loc10`/g' *.sql
    sed -i 's/`RequestItemsText`/`RequestItemsText_loc10`/g' *.sql
    sed -i 's/`EndText`/`EndText_loc10`/g' *.sql

    sed -i 's/`creature_template`/`locales_creature`/' *.sql
    sed -i 's/`gameobject_template`/`locales_gameobject`/' *.sql
    sed -i 's/`item_template`/`locales_item`/' *.sql
    sed -i 's/`quest_template`/`locales_quest`/' *.sql

    mariadb -u mangos -p"mangos" vmangos < creature_template.sql
    mariadb -u mangos -p"mangos" vmangos < gameobject_template.sql
    mariadb -u mangos -p"mangos" vmangos < item_template.sql
    mariadb -u mangos -p"mangos" vmangos < quest_template.sql
    cd -

### TurtleWoW (Opcional)

Obtén y descarga la base de datos más reciente de TurtleWoW y descomprímela.

    mariadb -u mangos -p"mangos" turtle < turtle/*.sql

### La Cruzada Ardiente (CMaNGOS)

Clona la base de datos más reciente de CMaNGOS TBC y las traducciones del proyecto Mangos-Extras:

    git clone https://github.com/cmangos/mangos-tbc.git
    git clone https://github.com/cmangos/tbc-db.git
    git clone https://github.com/mangosone/database.git

    mariadb -u mangos -p"mangos" cmangos-tbc < mangos-tbc/sql/base/mangos.sql
    mariadb -u mangos -p"mangos" cmangos-tbc < tbc-db/Full_DB/TBCDB_1.10.0_ReturnOfTheVengeance.sql
    for file in tbc-db/Updates/*.sql; do mariadb -u mangos -p"mangos" cmangos-tbc < "$file"; done
    for file in mangos-tbc/sql/updates/mangos/*.sql; do mariadb -u mangos -p"mangos" cmangos-tbc < "$file"; done
    mariadb -u mangos -p"mangos" cmangos-tbc < mangos-tbc/sql/base/dbc/original_data/Spell.sql
    mariadb -u mangos -p"mangos" cmangos-tbc < mangos-tbc/sql/base/dbc/cmangos_fixes/Spell.sql
    mariadb -u mangos -p"mangos" cmangos-tbc < tbc-db/ACID/acid_tbc.sql

    sed -i "/locales_command/d" database/Translations/1_LocaleTablePrepare.sql
    mariadb -u mangos -p"mangos" cmangos-tbc < database/Translations/1_LocaleTablePrepare.sql
    for file in database/Translations/1_LocaleTablePrepare.sql database/Translations/Translations/*/*.sql; do echo "$file"; mariadb -u mangos -p"mangos" cmangos-tbc < "$file"; done


## Optimizar el rendimiento de la base de datos

Ejecuta los siguientes comandos para mejorar el rendimiento del extractor mediante la indexación de las entradas SQL:

    mariadb <<< '
        use 'vmangos';
        # creatures
        CREATE INDEX idx_cse_guid ON creature_spawn_entry(guid);
        CREATE INDEX idx_cse_entry ON creature_spawn_entry(entry);
        CREATE INDEX idx_guid_map_position ON creature(guid, map, position_x, position_y);
        # gameobjects
        CREATE INDEX idx_gse_guid ON gameobject_spawn_entry(guid);
        CREATE INDEX idx_gse_entry ON gameobject_spawn_entry(entry);
        # items
        CREATE INDEX idx_got_data1 ON gameobject_template(data1);
        CREATE INDEX idx_golt_entry ON gameobject_loot_template(entry);
        CREATE INDEX idx_npcvt_entry ON npc_vendor_template(entry);
        CREATE INDEX idx_ct_entry ON creature_template(Entry);

        use 'turtle';
        # creatures
        CREATE INDEX idx_cse_guid ON creature_spawn_entry(guid);
        CREATE INDEX idx_cse_entry ON creature_spawn_entry(entry);
        CREATE INDEX idx_guid_map_position ON creature(guid, map, position_x, position_y);
        # gameobjects
        CREATE INDEX idx_gse_guid ON gameobject_spawn_entry(guid);
        CREATE INDEX idx_gse_entry ON gameobject_spawn_entry(entry);
        # items
        CREATE INDEX idx_got_data1 ON gameobject_template(data1);
        CREATE INDEX idx_golt_entry ON gameobject_loot_template(entry);
        CREATE INDEX idx_npcvt_entry ON npc_vendor_template(entry);
        CREATE INDEX idx_ct_entry ON creature_template(Entry);

        use 'cmangos-tbc';
        # creatures
        CREATE INDEX idx_cse_guid ON creature_spawn_entry(guid);
        CREATE INDEX idx_cse_entry ON creature_spawn_entry(entry);
        CREATE INDEX idx_guid_map_position ON creature(guid, map, position_x, position_y);
        # gameobjects
        CREATE INDEX idx_gse_guid ON gameobject_spawn_entry(guid);
        CREATE INDEX idx_gse_entry ON gameobject_spawn_entry(entry);
        # items
        CREATE INDEX idx_got_data1 ON gameobject_template(data1);
        CREATE INDEX idx_golt_entry ON gameobject_loot_template(entry);
        CREATE INDEX idx_npcvt_entry ON npc_vendor_template(entry);
        CREATE INDEX idx_ct_entry ON creature_template(Entry);

        use 'pfquest';
        # worldmap
        CREATE INDEX idx_wma_vanilla_sizes ON pfquest.WorldMapArea_vanilla(x_min, x_max, y_min, y_max);
        CREATE INDEX idx_wma_vanilla_mapid ON pfquest.WorldMapArea_vanilla(mapID);
        CREATE INDEX idx_wma_vanilla_area ON pfquest.WorldMapArea_vanilla(areatableID);
        CREATE INDEX idx_wma_tbc_sizes ON pfquest.WorldMapArea_tbc(x_min, x_max, y_min, y_max);
        CREATE INDEX idx_wma_tbc_mapid ON pfquest.WorldMapArea_tbc(mapID);
        CREATE INDEX idx_wma_tbc_area ON pfquest.WorldMapArea_tbc(areatableID);
    '

## Ejecuta el extractor

Inicia el extractor de bases de datos

    $ make

## Opcional: Generar datos de cliente
### Copiar CSV a DBC/
Además, necesitas extraer los archivos `dbc` de los clientes de tu juego.
Estos se pueden obtener mediante la herramienta `ad`, incluida en el conjunto de herramientas de CMaNGOS.
A continuación, los archivos DBC deben convertirse al formato `.csv` y ubicarse de la siguiente manera:

    $ ls -1 DBC/
    deDE  enUS  esES  frFR  koKR  ruRU  zhCN

    $ ls -1 DBC/deDE
    AreaTable.dbc.csv
    SkillLine.dbc.csv
    WorldMapArea.dbc.csv

### DBC requeridos
#### WorldMapArea.dbc [enUS]
Se requiere obtener los tamaños de mapa que se utilizan para
  1. cálculo del desplazamiento del minimapa
  2. calcular las posibles asignaciones de los objetos durante la extracción

#### Lock.dbc [enUS]
Se utiliza para obtener una lista de todos los requisitos de habilidades empleados durante la extracción de la meta-lista.

#### AreaTable.dbc [todos]
El archivo `AreaTable.dbc` se utiliza para construir la tabla de zonas. Esta tabla es necesaria para indicar al cliente del juego qué mapa debe mostrarse al buscar un objeto. En esencia, se trata de una tabla de conversión entre identificadores de mapa y nombres de mapa.

#### SkillLine.dbc [todos]
El archivo `SkillLine.db` se utiliza para construir la tabla de profesiones. Esta tabla es necesaria para comparar las profesiones de los jugadores con los requisitos de las misiones. En esencia, se trata de una tabla de conversión que relaciona el identificador de una profesión con su nombre.
