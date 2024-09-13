# ETL-Superstore

La gestión eficiente de datos se ha convertido en un factor crítico para el éxito de las organizaciones. Super Store, una empresa líder en el sector, se enfrenta al desafío de manejar grandes volúmenes de datos dispersos y no estructurados. Para abordar esta problemática, y para potenciar la toma de decisiones informada, se propone la implementación de un robusto sistema ETL (Extract, Transform, Load. Extraer, transformar y cargar) con tablas de hecho y dimensiones.

Este proyecto se enfoca en la creación de un sistema integral que permita extraer datos de diversas fuentes, transformarlos según las necesidades específicas de Super Store, y cargarlos de manera eficiente en un almacén de datos organizado.

Este proyecto no solo busca optimizar el almacenamiento de datos, sino también potenciar la capacidad de Super Store para identificar patrones, tendencias y oportunidades de mercado. Con un sistema ETL bien diseñado, la empresa estará mejor equipada para adaptarse rápidamente a cambios en la demanda del consumidor, mejorar la eficiencia operativa y mantener una ventaja competitiva en un mercado en constante evolución.

A lo largo de este proyecto, exploraremos en detalle los beneficios esperados, los costos asociados, los riesgos potenciales y el retorno de inversión proyectado para respaldar la decisión estratégica de implementar este sistema ETL con tablas de hecho y dimensiones en Super Store

## Limpieza y procesamiento de datos

#### Se identifican los datos nulos 
No tiene ningún valor nulo en la tabla de ventas, se manejarán en la creación de tablas de dimensión

#### Se identifican los datos duplicados 
No tiene ningún valor nulo en la tabla de ventas, se manejarán en la creación de tablas de dimensión

#### Discrepantes categoricas
No se trabajara con market, ni con market2, se creara Market3 que me integra Africa en EMEA
No se trabajara con la variable unknown porque no me aporta ninguna información

## Buscar Datos De Otras Fuentes (Webscrapping)

Se exporto la tabla de este link para mirar datos de competidores y tenerlos en cuenta para el análisis del comportamiento de superstore. Se utilizo la formula en pyhton y el archivo se descgargo en .csv y fue manejado en BigQuery

![image](https://github.com/user-attachments/assets/74e70c49-e4df-4212-9d0a-eaf68ae06e27)

> La formula en Pyhton esta en las carpetas como "webscrapping"

## Diseñar Estructura De La Base De Datos

Para el diseño de la estructura de datos se utilizó la herramienta MySQL Workbench. Se analizaron las definiciones de las variables, agrupándolas según su área de enfoque. La tabla de hechos contiene la información de ventas y los identificadores correspondientes.

![Esquema ETL](https://github.com/user-attachments/assets/197ac9d7-4a0d-4f0d-9b3b-1f8162aec91e)


## Flujo de  data pipeline

**Origen de los Datos (Ingesta)**

Los datos provienen de archivos CSV que contienen información relacionada con las ventas, productos, clientes, y ubicaciones.
Adicionalmente, mediante web scraping en Python (desde Google Colab), se extraen datos de tablas disponibles en páginas web sobre la competencia.

**Procesamiento/Transformación (ETL)**

SQL en BigQuery se utiliza para procesar y transformar los datos.
Transformación de datos CSV: Los archivos CSV se cargan en BigQuery donde se realizan las transformaciones necesarias. Esto puede incluir la limpieza de datos, el cambio de formatos, la normalización de valores, la agregación de datos, etc.
Web Scraping: Los datos extraídos mediante Python son limpiados y transformados dentro del flujo de trabajo para asegurar que sean coherentes con los demás datos.
Dimensiones: Los datos se procesan para poblar tablas de dimensión. Aquí se aseguran las relaciones correctas entre las entidades como Order, Superstore_location, Product, y Customer.
Hechos: Se actualiza la tabla de hechos (Ventas), donde se almacenan las métricas clave como ventas, costo de envío, descuentos, cantidad y beneficios.

**Almacenamiento**

Los datos transformados se almacenan en tablas de dimensión y hechos dentro de BigQuery.
Tablas de Dimensión:
Order: Contiene información detallada sobre los pedidos (ID, ciudad, región, fechas, ventas, prioridades, etc.).
Superstore_location: Almacena las ubicaciones registradas por país, mercado y estado.
Product: Define los productos por categorías y subcategorías.
Customer: Define los clientes, sus segmentos y nombres.
Tabla de Hechos:
Ventas: Contiene los hechos relacionados con ventas, incluyendo el ID del pedido, producto, cliente, ventas totales, costos de envío, descuentos, cantidades y beneficios.

**Acceso y Visualización**

Los datos almacenados en las tablas diseñadas se conectan a Tableau, donde se generan reportes y dashboards interactivos. Esto permite analizar la información, visualizar patrones y tomar decisiones informadas.
Ejemplos de visualizaciones en Tableau:
Ventas por región y categoría de producto.
Comparativa de ventas contra la competencia (datos obtenidos del scraping).
Evolución de las ventas por semana y año.
Margen de beneficios y costos de envío por ubicación.

![Pipeline](https://github.com/user-attachments/assets/c02bc41d-3241-4743-97c0-15752dc7c9bc)

### Variables elegidas para la unión de tablas 

- customer_id
-customer name
- Category produtct (mayor y menor profit)
- Mayor profit by user
- Menor profit by user
- first order date, city and country
- last order date, city and country
- year
- Market2 AS market
- sum (quantity)
- avg (sales by product)
- segment
-first ship_date
- last ship_date
- Primer ship mode relacionado con el ship date
- Ultimp ship mode relacionado con el ultimo ship date del usuario
- avg shipping cost
- Discount segun order_id
- order_priority

# Análisis exploratorio

**Niveles de prioridad de producto:**

![image](https://github.com/user-attachments/assets/6f6ba09d-cbfe-4a42-a1ab-9992c5b0b67b)

**Ganancia generada por categoria de producto:**

![image](https://github.com/user-attachments/assets/01dfe416-43fe-404b-884b-3016f94b5c55)

**Ganancias por región comercial:**

![image](https://github.com/user-attachments/assets/57006771-33a5-4761-8ff3-46dcd2135d05)

**Correlación entre el descuento y las ganancias**

![image](https://github.com/user-attachments/assets/e5dc873c-5b49-4778-9e75-c5d42b7664fc)


# Conclusiones

### 1. El monto total de venta del producto en el pedido no está directamente relacionado con el descuento. A lo largo de los años, se puede observar que, aunque los descuentos han sido similares, el total de ventas ha mostrado variaciones. Además, la correlación general entre las ventas y el descuento presenta una tendencia ligeramente negativa pero débil.

![image](https://github.com/user-attachments/assets/3db23e44-df16-4964-a694-039616aa479c)

![image](https://github.com/user-attachments/assets/ee30c1d6-dac4-4984-bbff-b4a7c0932400)

### 2. En las compras mas recientes (año 2014) por usuario, se perdió una ganancia en el mes de febrero, demostrando también la linea de promedio de total de ventas mas baja en todo el año, es decir en febrero se mostro un monto total de ventas de producto de 21.890 y una ganancia de -331$

![image](https://github.com/user-attachments/assets/13a79a5f-4cd6-4b2d-9c2c-d27fd3e6a48c)

 ### 3. El modo de envío que genera mayores ganancias es el de "Standard Class", mientras que el que genera menos es "Same Day". Esto podría deberse a que, aunque "Same Day" ofrece mayor comodidad, sus precios pueden ser demasiado altos, lo que reduce la demanda. Una hipótesis a analizar es que los clientes no consideran una prioridad recibir sus pedidos lo más rápido posible.

![image](https://github.com/user-attachments/assets/5d57e5a7-67bc-4571-8c18-3630e5a2be71)

### 4. El tipo de cliente que mas genera ganancias es el "Consumer", esto puede deberse a que nos representa el 51% de nuestros clientes

![image](https://github.com/user-attachments/assets/072044de-fdf5-4d43-89f1-922d40d56d57)

![image](https://github.com/user-attachments/assets/5b9f68e4-2cf0-40f1-aadd-bc10537ad152)

# Recomendaciones

## 1. Optimizar estrategias de descuento

Dado que el monto total de ventas no está directamente relacionado con los descuentos y la correlación es débil, reconsidera la frecuencia y magnitud de los descuentos ofrecidos. Podría ser más eficaz focalizar los descuentos en productos específicos o durante temporadas clave en lugar de aplicarlos de manera generalizada. Realiza pruebas A/B para evaluar cómo responden los clientes a diferentes estrategias de descuento.

## 2. Identificar y mitigar las bajas estacionales

El bajo rendimiento de ventas en febrero sugiere que hay factores estacionales afectando las compras. **Dado que diciembre presenta el mejor rendimiento del año**, es posible que las estrategias actuales estén enfocadas en la temporada alta de fin de año. Para contrarrestar la baja demanda en febrero, revisa las campañas de marketing y promociones de ese mes, y ajusta la estrategia para incentivar compras. Esto puede incluir promociones especiales o alianzas con otros servicios, así como campañas de marketing que mantengan el impulso de las ventas después de diciembre.

## 3. Reevaluar la estrategia de envío "Same Day"

Considera ajustar los precios del servicio "Same Day" o promover paquetes de envío gratuitos por volumen o para clientes recurrentes. También puedes evaluar si ofrecer incentivos o bonificaciones para la opción de envío más rápido ayudaría a aumentar la demanda, o bien reforzar el enfoque en "Standard Class", que ya genera más ganancias.

## 4. Segmentar mejor a los clientes "Consumer"

 Dado que el segmento "Consumer" genera la mayor parte de las ganancias, considera crear campañas de fidelización específicamente dirigidas a este grupo. Puedes ofrecer recompensas por compras frecuentes, acceso a descuentos exclusivos o servicios personalizados para fomentar la lealtad y aumentar el valor de cada cliente en este segmento.

 








