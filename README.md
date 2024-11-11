# Bitcoin Challenge API

Este repositorio contiene una API REST desarrollada en **Ruby on Rails**, que utiliza una base de datos **PostgreSQL**. La API permite gestionar transacciones de compra y venta de Bitcoin (BTC) usando **USD** como moneda base, y consulta el precio en tiempo real de BTC mediante la API abierta de **CoinDesk**.

## Características

La API proporciona los siguientes servicios:

### 1. **Información del precio USD - BTC**
   - Permite obtener el precio del **Bitcoin (BTC)** en tiempo real, consultando la API abierta de **CoinDesk**. El precio se devuelve en **USD (dólares americanos)**.

### 2. **Creación de una transacción de compra o venta**
   - Permite al usuario realizar una transacción de compra o venta de Bitcoin, usando **USD** como moneda base.
   - Se valida que el usuario tenga un balance suficiente antes de realizar la compra.
   - Para cada transacción, se deben enviar los siguientes parámetros:
     - **Moneda a enviar** (USD)
     - **Moneda a recibir** (BTC)
     - **Cantidad a enviar** (en USD)
   - La cantidad a recibir (en BTC) se calcula automáticamente.

### 3. **Listado de transacciones realizadas por un usuario particular**
   - Permite consultar todas las transacciones realizadas por un usuario específico, con detalles como la cantidad de BTC comprada o vendida y su valor en USD.

### 4. **Detalle de una transacción específica**
   - Permite obtener información detallada sobre una transacción específica, incluyendo los detalles del envío y la recepción, así como la cantidad de Bitcoin involucrada.

## Tecnologías

- **Ruby on Rails**: Framework utilizado para el desarrollo de la API.
- **PostgreSQL**: Base de datos utilizada para almacenar la información de las transacciones y balances de los usuarios.
- **CoinDesk API**: Utilizada para obtener el precio en tiempo real de Bitcoin en dólares americanos.

## Endpoints

### 1. **GET /api/v1/bitcoin_price**
   Obtiene el precio de **Bitcoin (BTC)** en **USD** en tiempo real desde la API de **CoinDesk**.

### 2. **POST /api/v1/transactions**
   Crea una nueva transacción de compra o venta de Bitcoin. Los parámetros requeridos son:
   - Moneda a enviar (USD).
   - Moneda a recibir (BTC).
   - Cantidad a enviar en USD.
   - La cantidad a recibir (BTC) se calcula automáticamente.

### 3. **GET /api/v1/transactions/users/:user_id**
   Devuelve un listado de todas las transacciones realizadas por un usuario específico, identificado por `user_id`.

### 4. **GET /api/v1/transactions/:id**
   Devuelve el detalle de una transacción específica, identificada por su `id`.
