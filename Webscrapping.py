-- La tabla a exportar es de Wikipedia, disponible.
import requests
from bs4 import BeautifulSoup
import csv

# URL de la página de Wikipedia
url = "https://en.wikipedia.org/wiki/List_of_supermarket_chains"

# Obtener el contenido de la página
response = requests.get(url)
soup = BeautifulSoup(response.content, 'html.parser')

# Encontrar todas las tablas en la página
tables = soup.find_all('table', {'class': 'wikitable'})

# Si hay múltiples tablas, seleccionar la que deseas (en este caso, la primera)
table = tables[0]

# Obtener todos los encabezados de columna
headers = [header.text.strip() for header in table.find_all('th')]

# Extraer todas las filas de la tabla
rows = table.find_all('tr')

# Crear una lista para almacenar los datos de la tabla
data = []

# Extraer cada celda de cada fila
for row in rows:
    cells = row.find_all(['td', 'th'])  # Considerar tanto las celdas de datos como las de encabezado
    cells = [cell.text.strip() for cell in cells]  # Quitar espacios en blanco
    if cells:  # Si hay celdas
        data.append(cells)

# Exportar a CSV tratando todo como cadenas
csv_filename = 'supermarket_chains.csv'
with open(csv_filename, 'w', newline='', encoding='utf-8') as f:
    writer = csv.writer(f, quoting=csv.QUOTE_ALL, delimiter=';')
    writer.writerow(headers)  # Escribir los encabezados
    for row in data:
        writer.writerow([str(cell) for cell in row])  # Escribir cada fila asegurando que todo sea string

print(f'Datos exportados correctamente a {csv_filename}')
